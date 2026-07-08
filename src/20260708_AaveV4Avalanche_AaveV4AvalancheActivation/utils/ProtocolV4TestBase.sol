// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {Strings} from 'openzeppelin-contracts/contracts/utils/Strings.sol';

import {ISpoke, IHub, ITokenizationSpoke, INativeTokenGateway, ISignatureGateway, IGiverPositionManager, ITakerPositionManager, IConfigPositionManager} from 'aave-address-book/AaveV4.sol';
import {IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-address-book/GovernanceV3.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {SeatbeltUtils} from 'aave-helpers/src/SeatbeltUtils.sol';
import {Types} from 'aave-helpers/src/dependencies/v4/Types.sol';
import {SnapshotV4} from 'aave-helpers/src/dependencies/v4/SnapshotV4.sol';
import {Scenarios} from './Scenarios.sol';
import {TokenizationScenarios} from 'aave-helpers/src/dependencies/v4/TokenizationScenarios.sol';
import {GatewayScenarios} from 'aave-helpers/src/dependencies/v4/GatewayScenarios.sol';

/// @title ProtocolV4TestBase
/// @notice E2E test base for Aave V4 hub/spoke architecture.
/// Tests supply, withdraw, borrow, repay, and liquidation for each reserve on a spoke.
/// Tests deposit, mint, withdraw, redeem for each tokenization spoke.
/// Tests NativeTokenGateway and SignatureGateway for each spoke.
/// Loops over all good collaterals and uses randomized amounts.
contract ProtocolV4TestBase is
  SnapshotV4,
  Scenarios,
  TokenizationScenarios,
  GatewayScenarios,
  SeatbeltUtils
{
  using SafeERC20 for IERC20;

  /// @notice Position managers and gateways exercised by the e2e suite and included
  ///         as snapshot candidates.
  /// @dev Passed in via `defaultTest` because, unlike hubs and access managers, they
  ///      cannot be derived from on-chain spoke/hub state (there is no registry to
  ///      enumerate). Any member left as the zero address (or pointing at an
  ///      undeployed address) is skipped: its e2e checks and snapshot probe are no-ops.
  struct PositionManagers {
    IGiverPositionManager giver;
    ITakerPositionManager taker;
    IConfigPositionManager config;
    INativeTokenGateway nativeGateway;
    ISignatureGateway signatureGateway;
  }

  /// @dev Set by `defaultTest`; read by the e2e position-manager/gateway helpers and
  ///      by `_positionManagerCandidates`.
  PositionManagers internal _positionManagers;

  /// @notice Run the full V4 test suite: snapshot before, execute payload, snapshot after, diff, then e2e.
  /// @dev the calling test must run in foundry's isolation mode (the `--isolate` CLI flag, or the
  /// per-test isolate inline-config annotation) so each top-level call is metered as its own
  /// transaction. Otherwise the payload gas measurement reads warm storage and under-counts, and the
  /// gas-limit check reverts (see `_requireIsolation`).
  function defaultTest(
    string memory reportName,
    ISpoke[] memory spokes,
    ITokenizationSpoke[] memory tokenizationSpokes,
    address payload
  ) public {
    PositionManagers memory noPositionManagers;
    return
      defaultTest({
        reportName: reportName,
        spokes: spokes,
        tokenizationSpokes: tokenizationSpokes,
        positionManagers: noPositionManagers,
        payload: payload,
        runE2E: true,
        testPositionManagers: false,
        runSeatbelt: false
      });
  }

  function defaultTest(
    string memory reportName,
    ISpoke[] memory spokes,
    ITokenizationSpoke[] memory tokenizationSpokes,
    PositionManagers memory positionManagers,
    address payload,
    bool runE2E,
    bool testPositionManagers
  ) public {
    return
      defaultTest({
        reportName: reportName,
        spokes: spokes,
        tokenizationSpokes: tokenizationSpokes,
        positionManagers: positionManagers,
        payload: payload,
        runE2E: runE2E,
        testPositionManagers: testPositionManagers,
        runSeatbelt: false
      });
  }

  function defaultTest(
    string memory reportName,
    ISpoke[] memory spokes,
    ITokenizationSpoke[] memory tokenizationSpokes,
    PositionManagers memory positionManagers,
    address payload,
    bool runE2E,
    bool testPositionManagers,
    bool runSeatbelt
  ) public {
    _positionManagers = positionManagers;

    if (payload != address(0)) {
      Types.V4Snapshot memory snapshotAfter = _snapshotDiffAndExecute(reportName, spokes, payload);

      if (runSeatbelt) {
        generateSeatbeltReport(
          reportName,
          address(GovV3Helpers.getPayloadsController(block.chainid)),
          payload.code
        );
      }

      configChangePlausibilityTest(snapshotAfter);
    }

    if (runE2E) {
      vm.pauseGasMetering();
      e2eTestAllSpokes({spokes: spokes, testPositionManagers: testPositionManagers});
      e2eTestAllTokenizationSpokes(tokenizationSpokes);
      vm.resumeGasMetering();
    }
  }

  /// @notice Sanity-check post-payload spoke caps for known invariants.
  /// @dev Liquidity is pooled at the hub, so the invariant is a per-asset
  ///      aggregate across all spokes. `type(uint40).max` is the IHub sentinel
  ///      meaning "no cap" — we branch on it instead of summing, so the check
  ///      neither inflates totals nor false-positives on uncapped configs.
  function configChangePlausibilityTest(Types.V4Snapshot memory snapshotAfter) public pure {
    Types.SpokeConfigSnapshot[] memory caps = snapshotAfter.spokeConfigs;
    uint40 sentinel = type(uint40).max;
    for (uint256 i; i < caps.length; i++) {
      // Skip (hub, assetId) groups already aggregated in a prior iteration.
      bool alreadyAggregated = false;
      for (uint256 j; j < i; j++) {
        if (caps[j].hubAddress == caps[i].hubAddress && caps[j].assetId == caps[i].assetId) {
          alreadyAggregated = true;
          break;
        }
      }
      if (alreadyAggregated) {
        continue;
      }

      uint256 sumAdd;
      uint256 sumDraw;
      bool addUnlimited;
      bool drawUnlimited;
      for (uint256 k; k < caps.length; k++) {
        if (caps[k].hubAddress == caps[i].hubAddress && caps[k].assetId == caps[i].assetId) {
          if (caps[k].addCap == sentinel) {
            addUnlimited = true;
          } else {
            sumAdd += uint256(caps[k].addCap);
          }
          if (caps[k].drawCap == sentinel) {
            drawUnlimited = true;
          } else {
            sumDraw += uint256(caps[k].drawCap);
          }
        }
      }
      // Unlimited draw with bounded add is economically impossible: hub
      // liquidity is bounded by the supply caps.
      require(!(drawUnlimited && !addUnlimited), 'PL_UNLIMITED_DRAW_BOUNDED_ADD');
      // If add is unlimited, sumAdd can hold any draw — skip the numeric check.
      if (addUnlimited) {
        continue;
      }
      require(sumDraw <= sumAdd, 'PL_ADD_LT_DRAW');
    }
  }

  /// @notice Collect the unique set of hubs referenced by the given spokes.
  /// @dev Chain-agnostic: reads each spoke's reserves rather than a hardcoded
  ///      per-chain address-book list, so the snapshot targets the hubs actually
  ///      under test on whatever network the payload runs on.
  function _hubsFromSpokes(ISpoke[] memory spokes) internal view returns (IHub[] memory) {
    // Upper bound on distinct hubs: total reserves across all spokes.
    uint256 max;
    for (uint256 s; s < spokes.length; s++) {
      max += spokes[s].getReserveCount();
    }

    address[] memory buf = new address[](max);
    uint256 count;
    for (uint256 s; s < spokes.length; s++) {
      uint256 reserveCount = spokes[s].getReserveCount();
      for (uint256 r; r < reserveCount; r++) {
        count = _appendUnique(buf, count, address(spokes[s].getReserve(r).hub));
      }
    }

    IHub[] memory hubs = new IHub[](count);
    for (uint256 i; i < count; i++) {
      hubs[i] = IHub(buf[i]);
    }
    return hubs;
  }

  /// @notice Collect the unique set of AccessManagers governing the given spokes and hubs.
  /// @dev Chain-agnostic: reads each contract's `authority()` (AccessManaged) rather
  ///      than a hardcoded per-chain address, so role grants are snapshotted for the
  ///      deployment actually under test.
  function _accessManagersFrom(
    ISpoke[] memory spokes,
    IHub[] memory hubs
  ) internal view returns (address[] memory) {
    address[] memory buf = new address[](spokes.length + hubs.length);
    uint256 count;
    for (uint256 s; s < spokes.length; s++) {
      count = _appendUnique(buf, count, spokes[s].authority());
    }
    for (uint256 h; h < hubs.length; h++) {
      count = _appendUnique(buf, count, hubs[h].authority());
    }

    address[] memory ams = new address[](count);
    for (uint256 i; i < count; i++) {
      ams[i] = buf[i];
    }
    return ams;
  }

  /// @dev Append `value` to `buf[0..count)` if non-zero and not already present; returns the new count.
  function _appendUnique(
    address[] memory buf,
    uint256 count,
    address value
  ) private pure returns (uint256) {
    if (value == address(0)) {
      return count;
    }
    for (uint256 k; k < count; k++) {
      if (buf[k] == value) {
        return count;
      }
    }
    buf[count] = value;
    return count + 1;
  }

  function _snapshotDiffAndExecute(
    string memory reportName,
    ISpoke[] memory spokes,
    address payload
  ) internal virtual returns (Types.V4Snapshot memory snapshotAfter) {
    IHub[] memory hubs = _hubsFromSpokes(spokes);
    address[] memory positionManagerCandidates = _positionManagerCandidates();
    address[] memory accessManagers = _accessManagersFrom(spokes, hubs);
    string memory beforeName = string.concat(reportName, '_before');
    string memory afterName = string.concat(reportName, '_after');

    Types.V4Snapshot memory snapshotBefore = createV4Snapshot(
      spokes,
      hubs,
      positionManagerCandidates,
      accessManagers
    );
    writeV4SnapshotJson(beforeName, snapshotBefore);

    (string memory rawDiff, string memory logsJson) = _executePayloadWithRecording(payload);

    // as executor does delegateCall to the payload, the executor should have no storage changes.
    // Walk every configured access level so payloads run by Level_2+ are also covered.
    {
      IPayloadsControllerCore pc = GovV3Helpers.getPayloadsController(block.chainid);
      PayloadsControllerUtils.AccessControl[2] memory levels = [
        PayloadsControllerUtils.AccessControl.Level_1,
        PayloadsControllerUtils.AccessControl.Level_2
      ];
      for (uint256 i; i < levels.length; i++) {
        address executor = pc.getExecutorSettingsByAccessControl(levels[i]).executor;
        if (executor == address(0)) {
          continue;
        }
        _validateNoExecutorStorageChange(rawDiff, executor);
      }
    }

    snapshotAfter = createV4Snapshot(spokes, hubs, positionManagerCandidates, accessManagers);
    writeV4SnapshotJson(afterName, snapshotAfter);

    string memory afterPath = string.concat('./reports/', afterName, '.json');
    vm.writeJson(rawDiff, afterPath, '$.raw');
    vm.writeJson(logsJson, afterPath, '$.logs');

    diffV4Snapshots(reportName);
  }

  function _executePayloadWithRecording(
    address payload
  ) private returns (string memory rawDiff, string memory logsJson) {
    address payloadsController = address(GovV3Helpers.getPayloadsController(block.chainid));

    // Meter execution on a dedicated run: vm.startStateDiffRecording (needed for the diff below)
    // suppresses isolate's transaction-level gas accounting, so gas must be measured without it.
    // This run is reverted and has no effect on the recorded snapshot/diff.
    uint256 snapshotId = vm.snapshotState();
    GovV3Helpers.executePayload(vm, payload, payloadsController);
    _assertPayloadGasWithinLimit(vm.lastCallGas().gasTotalUsed);
    vm.revertToState(snapshotId);

    vm.startStateDiffRecording();
    vm.recordLogs();
    GovV3Helpers.executePayload(vm, payload, payloadsController);
    rawDiff = vm.getStateDiffJson();
    logsJson = vm.getRecordedLogsJson();
  }

  /// @notice Test all reserves on every spoke in the array.
  function e2eTestAllSpokes(ISpoke[] memory spokes, bool testPositionManagers) public {
    for (uint256 i; i < spokes.length; i++) {
      console.log('--- E2E: Testing spoke %s ---', address(spokes[i]));
      console.log('--------------------------------');
      e2eTestSpoke(spokes[i]);
      if (testPositionManagers) {
        e2eTestPositionManagers(spokes[i]);
      }
    }
  }

  /// @notice Test all reserves on one spoke, looping over ALL good collaterals, then gateway tests.
  function e2eTestSpoke(ISpoke spoke) public {
    Types.ReserveInfo[] memory allReserves = _getReserveInfo(spoke);
    Types.ReserveInfo[] memory goodCollaterals = _getAllUsableCollaterals(allReserves);
    // A fully frozen/deprecated spoke has no usable collateral and cannot be exercised e2e.
    if (goodCollaterals.length == 0) {
      console.log('--- E2E: Skipping spoke %s (no usable collateral) ---', address(spoke));
      return;
    }

    uint256 numCollateralsToTest = 5;
    numCollateralsToTest = goodCollaterals.length < numCollateralsToTest
      ? goodCollaterals.length
      : numCollateralsToTest;

    for (uint256 collateralIndex; collateralIndex < numCollateralsToTest; collateralIndex++) {
      console.log('--- E2E: Using collateral %s ---', goodCollaterals[collateralIndex].symbol);

      uint256 spokeSnapshot = vm.snapshotState();

      for (uint256 assetIndex; assetIndex < allReserves.length; assetIndex++) {
        if (allReserves[assetIndex].paused) {
          e2eTestPausedAsset({spoke: spoke, pausedAsset: allReserves[assetIndex]});
          vm.revertToState(spokeSnapshot);
          continue;
        }

        if (allReserves[assetIndex].frozen) {
          e2eTestFrozenAsset({spoke: spoke, frozenAsset: allReserves[assetIndex]});
          vm.revertToState(spokeSnapshot);
          continue;
        }

        e2eTestAsset({
          spoke: spoke,
          goodCollaterals: goodCollaterals,
          primaryCollateralIndex: collateralIndex,
          testAssetInfo: allReserves[assetIndex]
        });
        vm.revertToState(spokeSnapshot);
      }
    }
  }

  /// @notice Test all position managers on a spoke.
  function e2eTestPositionManagers(ISpoke spoke) public {
    // Skip spokes the position managers cannot exercise: a fully frozen/deprecated spoke has no
    // usable collateral, and a spoke not registered with the managers reverts with
    // SpokeNotRegistered(). Registration is spoke-level, so the giver manager is representative.
    // Also skip when no giver was provided or it is not deployed on this chain.
    IGiverPositionManager giver = _positionManagers.giver;
    if (
      _getAllUsableCollaterals(_getReserveInfo(spoke)).length == 0 ||
      address(giver).code.length == 0 ||
      !giver.isSpokeRegistered(address(spoke))
    ) {
      console.log('--- E2E: Skipping position managers on spoke %s ---', address(spoke));
      return;
    }
    e2eTestGateways(spoke);
    e2eTestRegularPositionManagers(spoke);
  }

  /// @notice Test all gateways on a spoke.
  function e2eTestGateways(ISpoke spoke) public {
    // set caps to max to simplify user ops
    _setCapsToMax(spoke);

    Types.ReserveInfo[] memory allReserves = _getReserveInfo(spoke);
    Types.ReserveInfo[] memory goodCollaterals = _getAllUsableCollaterals(allReserves);
    Types.ReserveInfo[] memory goodDebtReserves = _getAllUsableDebtReserves(allReserves);

    // NativeTokenGateway — only if provided, deployed, and the spoke lists WETH
    {
      INativeTokenGateway nativeGateway = _positionManagers.nativeGateway;
      if (address(nativeGateway).code.length != 0) {
        (bool hasWeth, Types.ReserveInfo memory wethInfo) = _findNativeTokenReserveInfo(
          nativeGateway,
          spoke
        );
        if (hasWeth) {
          uint256 gatewaySnapshot = vm.snapshotState();
          _testNativeGateway(nativeGateway, spoke, wethInfo);
          vm.revertToState(gatewaySnapshot);
        }
      }
    }

    // SignatureGateway — on first usable debt reserve + collateral, if provided and deployed
    if (
      goodCollaterals.length > 0 &&
      goodDebtReserves.length > 0 &&
      address(_positionManagers.signatureGateway).code.length != 0
    ) {
      uint256 gatewaySnapshot = vm.snapshotState();
      _testSignatureGateway({
        gateway: _positionManagers.signatureGateway,
        spoke: spoke,
        reserveInfo: goodDebtReserves[0],
        collateralInfo: goodCollaterals[0]
      });
      vm.revertToState(gatewaySnapshot);
    }
  }

  /// @notice Test all regular position managers on a spoke.
  function e2eTestRegularPositionManagers(ISpoke spoke) public {
    _setCapsToMax(spoke);

    Types.ReserveInfo[] memory allReserves = _getReserveInfo(spoke);
    Types.ReserveInfo[] memory goodCollaterals = _getAllUsableCollaterals(allReserves);
    Types.ReserveInfo[] memory goodDebtReserves = _getAllUsableDebtReserves(allReserves);

    if (goodCollaterals.length == 0 || goodDebtReserves.length == 0) {
      console.log('POSITION_MANAGERS: Skipping spoke (no collateral or debt reserves)');
      return;
    }

    Types.ReserveInfo memory collateralInfo = goodCollaterals[0];
    Types.ReserveInfo memory debtReserveInfo = goodDebtReserves[0];

    _testGiverPositionManager(spoke, debtReserveInfo, collateralInfo);
    _testTakerPositionManager(spoke, debtReserveInfo, collateralInfo);
    _testConfigPositionManager(spoke, collateralInfo);
  }

  /// @notice Test GiverPositionManager: supplyOnBehalfOf and repayOnBehalfOf.
  function _testGiverPositionManager(
    ISpoke spoke,
    Types.ReserveInfo memory debtReserveInfo,
    Types.ReserveInfo memory collateralInfo
  ) internal {
    uint256 snapshot = vm.snapshotState();
    console.log('GIVER_PM: Testing supplyOnBehalfOf and repayOnBehalfOf');

    IGiverPositionManager giverPositionManager = _positionManagers.giver;
    address oracleAddr = spoke.ORACLE();
    address owner = makeAddr('GIVER_OWNER');
    address supplier = makeAddr('GIVER_SUPPLIER');

    // Owner approves GiverPositionManager
    vm.prank(owner);
    spoke.setUserPositionManager(address(giverPositionManager), true);

    // --- supplyOnBehalfOf ---
    uint256 supplyAmount = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: collateralInfo,
      dollarValue: 10_000
    });

    uint256 ownerSupplyBefore = spoke.getUserSuppliedAssets(collateralInfo.reserveId, owner);

    vm.startPrank(supplier);
    deal2(collateralInfo.underlying, supplier, supplyAmount);
    IERC20(collateralInfo.underlying).forceApprove(address(giverPositionManager), supplyAmount);
    giverPositionManager.supplyOnBehalfOf({
      spoke: address(spoke),
      reserveId: collateralInfo.reserveId,
      amount: supplyAmount,
      onBehalfOf: owner
    });
    vm.stopPrank();

    uint256 ownerSupplyAfter = spoke.getUserSuppliedAssets(collateralInfo.reserveId, owner);
    assertApproxEqAbs(
      ownerSupplyAfter,
      ownerSupplyBefore + supplyAmount,
      1,
      'GIVER_PM: supplyOnBehalfOf owner balance mismatch'
    );

    // --- repayOnBehalfOf ---
    // Setup: owner needs a borrow position first
    vm.prank(owner);
    spoke.setUsingAsCollateral({
      reserveId: collateralInfo.reserveId,
      usingAsCollateral: true,
      onBehalfOf: owner
    });

    uint256 borrowAmount = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: debtReserveInfo,
      dollarValue: 1_000
    });
    _ensureLiquidity({spoke: spoke, reserveInfo: debtReserveInfo, amount: borrowAmount});

    vm.prank(owner);
    spoke.borrow({reserveId: debtReserveInfo.reserveId, amount: borrowAmount, onBehalfOf: owner});

    uint256 ownerDebtBefore = spoke.getUserTotalDebt(debtReserveInfo.reserveId, owner);
    assertGt(ownerDebtBefore, 0, 'GIVER_PM: owner should have debt before repay');

    uint256 repayAmount = borrowAmount / 2;
    vm.startPrank(supplier);
    deal2(debtReserveInfo.underlying, supplier, repayAmount);
    IERC20(debtReserveInfo.underlying).forceApprove(address(giverPositionManager), repayAmount);
    giverPositionManager.repayOnBehalfOf({
      spoke: address(spoke),
      reserveId: debtReserveInfo.reserveId,
      amount: repayAmount,
      onBehalfOf: owner
    });
    vm.stopPrank();

    uint256 ownerDebtAfter = spoke.getUserTotalDebt(debtReserveInfo.reserveId, owner);
    assertApproxEqAbs(
      ownerDebtBefore - ownerDebtAfter,
      repayAmount,
      2,
      'GIVER_PM: repayOnBehalfOf debt should decrease'
    );
    vm.revertToState(snapshot);
  }

  /// @notice Test TakerPositionManager: withdrawOnBehalfOf and borrowOnBehalfOf.
  function _testTakerPositionManager(
    ISpoke spoke,
    Types.ReserveInfo memory debtReserveInfo,
    Types.ReserveInfo memory collateralInfo
  ) internal {
    uint256 snapshot = vm.snapshotState();
    console.log('TAKER_PM: Testing withdrawOnBehalfOf and borrowOnBehalfOf');

    ITakerPositionManager takerPositionManager = _positionManagers.taker;
    address owner = makeAddr('TAKER_OWNER');
    address taker = makeAddr('TAKER_DELEGATEE');

    // Owner approves TakerPositionManager
    vm.prank(owner);
    spoke.setUserPositionManager(address(takerPositionManager), true);

    // Supply collateral for owner
    uint256 supplyAmount = _getTokenAmountByDollarValue({
      oracleAddr: spoke.ORACLE(),
      reserveInfo: collateralInfo,
      dollarValue: 10_000
    });
    _supply({spoke: spoke, reserveInfo: collateralInfo, user: owner, amount: supplyAmount});

    _testTakerWithdraw(spoke, takerPositionManager, collateralInfo, owner, taker, supplyAmount / 4);
    _testTakerBorrow(spoke, takerPositionManager, debtReserveInfo, collateralInfo, owner, taker);
    vm.revertToState(snapshot);
  }

  function _testTakerWithdraw(
    ISpoke spoke,
    ITakerPositionManager takerPositionManager,
    Types.ReserveInfo memory collateralInfo,
    address owner,
    address taker,
    uint256 withdrawAmount
  ) internal {
    vm.prank(owner);
    takerPositionManager.approveWithdraw({
      spoke: address(spoke),
      reserveId: collateralInfo.reserveId,
      spender: taker,
      amount: withdrawAmount
    });

    uint256 ownerSupplyBefore = spoke.getUserSuppliedAssets(collateralInfo.reserveId, owner);
    uint256 takerBalanceBefore = IERC20(collateralInfo.underlying).balanceOf(taker);

    vm.prank(taker);
    takerPositionManager.withdrawOnBehalfOf({
      spoke: address(spoke),
      reserveId: collateralInfo.reserveId,
      amount: withdrawAmount,
      onBehalfOf: owner
    });

    assertApproxEqAbs(
      ownerSupplyBefore - spoke.getUserSuppliedAssets(collateralInfo.reserveId, owner),
      withdrawAmount,
      1,
      'TAKER_PM: owner supply should decrease'
    );
    assertEq(
      takerBalanceBefore + withdrawAmount,
      IERC20(collateralInfo.underlying).balanceOf(taker),
      'TAKER_PM: taker should receive withdrawn tokens'
    );
  }

  function _testTakerBorrow(
    ISpoke spoke,
    ITakerPositionManager takerPositionManager,
    Types.ReserveInfo memory debtReserveInfo,
    Types.ReserveInfo memory collateralInfo,
    address owner,
    address taker
  ) internal {
    vm.prank(owner);
    spoke.setUsingAsCollateral({
      reserveId: collateralInfo.reserveId,
      usingAsCollateral: true,
      onBehalfOf: owner
    });

    uint256 borrowAmount = _getTokenAmountByDollarValue({
      oracleAddr: spoke.ORACLE(),
      reserveInfo: debtReserveInfo,
      dollarValue: 1_000
    });
    _ensureLiquidity({spoke: spoke, reserveInfo: debtReserveInfo, amount: borrowAmount});

    vm.prank(owner);
    takerPositionManager.approveBorrow({
      spoke: address(spoke),
      reserveId: debtReserveInfo.reserveId,
      spender: taker,
      amount: borrowAmount
    });

    uint256 ownerDebtBefore = spoke.getUserTotalDebt(debtReserveInfo.reserveId, owner);
    uint256 takerBalanceBefore = IERC20(debtReserveInfo.underlying).balanceOf(taker);

    vm.prank(taker);
    takerPositionManager.borrowOnBehalfOf({
      spoke: address(spoke),
      reserveId: debtReserveInfo.reserveId,
      amount: borrowAmount,
      onBehalfOf: owner
    });

    assertApproxEqAbs(
      spoke.getUserTotalDebt(debtReserveInfo.reserveId, owner),
      ownerDebtBefore + borrowAmount,
      2,
      'TAKER_PM: owner debt should increase'
    );
    assertEq(
      takerBalanceBefore + borrowAmount,
      IERC20(debtReserveInfo.underlying).balanceOf(taker),
      'TAKER_PM: taker should receive borrowed tokens'
    );
  }

  /// @notice Test ConfigPositionManager: setUsingAsCollateralOnBehalfOf.
  function _testConfigPositionManager(
    ISpoke spoke,
    Types.ReserveInfo memory collateralInfo
  ) internal {
    uint256 snapshot = vm.snapshotState();
    console.log('CONFIG_PM: Testing setUsingAsCollateralOnBehalfOf');

    IConfigPositionManager configPositionManager = _positionManagers.config;
    address oracleAddr = spoke.ORACLE();
    address owner = makeAddr('CONFIG_OWNER');
    address configDelegatee = makeAddr('CONFIG_DELEGATEE');

    // Owner approves ConfigPositionManager
    vm.prank(owner);
    spoke.setUserPositionManager(address(configPositionManager), true);

    // Supply collateral for owner
    uint256 supplyAmount = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: collateralInfo,
      dollarValue: 10_000
    });
    _supply({spoke: spoke, reserveInfo: collateralInfo, user: owner, amount: supplyAmount});

    // Owner grants global permission to delegatee
    vm.prank(owner);
    configPositionManager.setGlobalPermission({
      spoke: address(spoke),
      delegatee: configDelegatee,
      status: true
    });

    // Delegatee enables collateral on behalf of owner
    vm.prank(configDelegatee);
    configPositionManager.setUsingAsCollateralOnBehalfOf({
      spoke: address(spoke),
      reserveId: collateralInfo.reserveId,
      usingAsCollateral: true,
      onBehalfOf: owner
    });

    (bool usingAsCollateralBeforeDisable, ) = spoke.getUserReserveStatus(
      collateralInfo.reserveId,
      owner
    );
    assertEq(usingAsCollateralBeforeDisable, true, 'CONFIG_PM: collateral should be enabled');

    // Delegatee disables collateral on behalf of owner
    vm.prank(configDelegatee);
    configPositionManager.setUsingAsCollateralOnBehalfOf({
      spoke: address(spoke),
      reserveId: collateralInfo.reserveId,
      usingAsCollateral: false,
      onBehalfOf: owner
    });

    (bool usingAsCollateralAfterDisable, ) = spoke.getUserReserveStatus(
      collateralInfo.reserveId,
      owner
    );
    assertEq(usingAsCollateralAfterDisable, false, 'CONFIG_PM: collateral should be disabled');
    vm.revertToState(snapshot);
  }

  /// @notice Test that a paused reserve correctly reverts on all actions.
  function e2eTestPausedAsset(ISpoke spoke, Types.ReserveInfo memory pausedAsset) public {
    console.log('E2E: Testing paused reserve %s (should revert)', pausedAsset.symbol);

    address oracleAddr = spoke.ORACLE();
    address user = vm.randomAddress();
    uint256 amount = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: pausedAsset,
      dollarValue: 1_000
    });

    deal2(pausedAsset.underlying, user, amount);

    // Supply should revert with ReservePaused
    vm.startPrank(user);
    IERC20(pausedAsset.underlying).forceApprove(address(spoke), amount);
    vm.expectRevert(ISpoke.ReservePaused.selector);
    spoke.supply({reserveId: pausedAsset.reserveId, amount: amount, onBehalfOf: user});
    vm.stopPrank();

    // Borrow should revert with ReservePaused
    vm.prank(user);
    vm.expectRevert(ISpoke.ReservePaused.selector);
    spoke.borrow({reserveId: pausedAsset.reserveId, amount: amount, onBehalfOf: user});

    // Withdraw should revert with ReservePaused
    vm.prank(user);
    vm.expectRevert(ISpoke.ReservePaused.selector);
    spoke.withdraw({reserveId: pausedAsset.reserveId, amount: amount, onBehalfOf: user});

    // Repay should revert with ReservePaused
    vm.startPrank(user);
    IERC20(pausedAsset.underlying).forceApprove(address(spoke), amount);
    vm.expectRevert(ISpoke.ReservePaused.selector);
    spoke.repay({reserveId: pausedAsset.reserveId, amount: amount, onBehalfOf: user});
    vm.stopPrank();

    // Liquidation should revert with ReservePaused (paused as debt asset)
    address liquidator = vm.randomAddress();
    vm.prank(liquidator);
    vm.expectRevert(ISpoke.ReservePaused.selector);
    spoke.liquidationCall({
      collateralReserveId: pausedAsset.reserveId,
      debtReserveId: pausedAsset.reserveId,
      user: user,
      debtToCover: amount,
      receiveShares: false
    });

    // setUsingAsCollateral should revert with ReservePaused
    vm.prank(user);
    vm.expectRevert(ISpoke.ReservePaused.selector);
    spoke.setUsingAsCollateral({
      reserveId: pausedAsset.reserveId,
      usingAsCollateral: true,
      onBehalfOf: user
    });
  }

  /// @notice Test that a frozen reserve correctly reverts on supply and borrow.
  function e2eTestFrozenAsset(ISpoke spoke, Types.ReserveInfo memory frozenAsset) public {
    console.log('E2E: Testing frozen reserve %s (should revert)', frozenAsset.symbol);

    address oracleAddr = spoke.ORACLE();
    address user = vm.randomAddress();
    uint256 amount = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: frozenAsset,
      dollarValue: 1_000
    });

    deal2(frozenAsset.underlying, user, amount);

    // Supply should revert with ReserveFrozen
    vm.startPrank(user);
    IERC20(frozenAsset.underlying).forceApprove(address(spoke), amount);
    vm.expectRevert(ISpoke.ReserveFrozen.selector);
    spoke.supply({reserveId: frozenAsset.reserveId, amount: amount, onBehalfOf: user});
    vm.stopPrank();

    // Borrow should revert with ReserveFrozen (if borrowable)
    if (frozenAsset.borrowable) {
      vm.prank(user);
      vm.expectRevert(ISpoke.ReserveFrozen.selector);
      spoke.borrow({reserveId: frozenAsset.reserveId, amount: amount, onBehalfOf: user});
    }
  }

  /// @notice Per-asset e2e test with randomized amounts and extra collaterals.
  function e2eTestAsset(
    ISpoke spoke,
    Types.ReserveInfo[] memory goodCollaterals,
    uint256 primaryCollateralIndex,
    Types.ReserveInfo memory testAssetInfo
  ) public {
    Types.ReserveInfo memory collateralInfo = goodCollaterals[primaryCollateralIndex];
    console.log('E2E: Collateral %s, TestAsset %s', collateralInfo.symbol, testAssetInfo.symbol);
    require(collateralInfo.collateralEnabled, 'COLLATERAL_CONFIG_MUST_BE_COLLATERAL');

    uint256 scenarioSnapshot;

    scenarioSnapshot = vm.snapshotState();
    _testZeroAmountReverts({spoke: spoke, reserveInfo: testAssetInfo, user: vm.randomAddress()});
    vm.revertToState(scenarioSnapshot);

    scenarioSnapshot = vm.snapshotState();
    _testCaps({spoke: spoke, reserveInfo: testAssetInfo});
    vm.revertToState(scenarioSnapshot);

    // Set caps to max after cap testing for the rest of the flow
    _setCapsToMax(spoke);

    address collateralSupplier = makeAddr('COLLATERAL_SUPPLIER');
    address testAssetSupplier = makeAddr('TEST_ASSET_SUPPLIER');

    uint256 testAssetAmount = _setupPositions({
      spoke: spoke,
      goodCollaterals: goodCollaterals,
      primaryCollateralIndex: primaryCollateralIndex,
      testAssetInfo: testAssetInfo,
      collateralSupplier: collateralSupplier,
      testAssetSupplier: testAssetSupplier
    });

    scenarioSnapshot = vm.snapshotState();
    _testPartialWithdrawal({
      spoke: spoke,
      testAssetInfo: testAssetInfo,
      testAssetSupplier: testAssetSupplier,
      testAssetAmount: testAssetAmount
    });
    vm.revertToState(scenarioSnapshot);

    scenarioSnapshot = vm.snapshotState();
    _testFullWithdrawal({
      spoke: spoke,
      testAssetInfo: testAssetInfo,
      testAssetSupplier: testAssetSupplier
    });
    vm.revertToState(scenarioSnapshot);

    if (testAssetInfo.borrowable) {
      scenarioSnapshot = vm.snapshotState();
      uint256 borrowCeiling = _setupBorrows(
        spoke,
        testAssetInfo,
        collateralSupplier,
        testAssetAmount
      );
      if (borrowCeiling > 0) {
        uint256 postBorrowSnapshot = vm.snapshotState();

        // Partial repay
        _testPartialRepay(spoke, testAssetInfo, collateralSupplier);
        vm.revertToState(postBorrowSnapshot);

        // Full repay
        _testFullRepay(spoke, testAssetInfo, collateralSupplier);
        vm.revertToState(postBorrowSnapshot);

        // Repay after interest accrual
        _testRepayAfterInterest(spoke, testAssetInfo, collateralSupplier);
        vm.revertToState(postBorrowSnapshot);

        // Liquidation
        _testLiquidation(spoke, collateralInfo, testAssetInfo, collateralSupplier);
        vm.revertToState(postBorrowSnapshot);
      }
      vm.revertToState(scenarioSnapshot);
    } else {
      // Non-borrowable: verify borrow reverts with ReserveNotBorrowable
      vm.prank(collateralSupplier);
      vm.expectRevert(ISpoke.ReserveNotBorrowable.selector);
      spoke.borrow({
        reserveId: testAssetInfo.reserveId,
        amount: testAssetAmount,
        onBehalfOf: collateralSupplier
      });
    }

    // Collateral toggle: disable all, verify borrow fails, re-enable all, verify borrow works
    if (collateralInfo.collateralEnabled && testAssetInfo.borrowable) {
      scenarioSnapshot = vm.snapshotState();
      _testCollateralToggle({
        spoke: spoke,
        goodCollaterals: goodCollaterals,
        testAssetInfo: testAssetInfo,
        collateralSupplier: collateralSupplier,
        testAssetAmount: testAssetAmount
      });
      vm.revertToState(scenarioSnapshot);
    }
  }

  /// @notice Test all tokenization spokes in the array.
  function e2eTestAllTokenizationSpokes(ITokenizationSpoke[] memory tokenizationSpokes) public {
    for (uint256 i; i < tokenizationSpokes.length; i++) {
      console.log('--- E2E: Testing tokenization spoke %s ---', address(tokenizationSpokes[i]));
      console.log('------------------------------------------');
      e2eTestTokenizationSpoke(tokenizationSpokes[i]);
    }
  }

  /// @notice Run all tokenization spoke scenarios for a single spoke.
  function e2eTestTokenizationSpoke(ITokenizationSpoke tokenizationSpoke) public {
    Types.ReserveInfo memory reserveInfo = _getTokenizationReserveInfo(tokenizationSpoke);
    console.log('E2E: TokenizationSpoke asset: %s', reserveInfo.symbol);

    uint256 snapshot = vm.snapshotState();

    _testTokenizationAddCap(tokenizationSpoke, reserveInfo);
    vm.revertToState(snapshot);

    _setTokenizationCapsToMax(tokenizationSpoke);
    snapshot = vm.snapshotState();

    uint256 maxAddAmount = _toAssetDecimals(10_000, reserveInfo.decimals);

    _testTokenizationDepositWithdraw({
      tokenizationSpoke: tokenizationSpoke,
      reserveInfo: reserveInfo,
      maxAddAmount: maxAddAmount
    });
    vm.revertToState(snapshot);

    _testTokenizationMintRedeem({
      tokenizationSpoke: tokenizationSpoke,
      reserveInfo: reserveInfo,
      maxAddAmount: maxAddAmount
    });
    vm.revertToState(snapshot);

    _testTokenizationPermitDeposit({
      tokenizationSpoke: tokenizationSpoke,
      reserveInfo: reserveInfo,
      maxAddAmount: maxAddAmount
    });
    vm.revertToState(snapshot);

    _testTokenizationTimeSkip({
      tokenizationSpoke: tokenizationSpoke,
      reserveInfo: reserveInfo,
      maxAddAmount: maxAddAmount
    });
    vm.revertToState(snapshot);

    _testTokenizationTransferAndWithdraw({
      tokenizationSpoke: tokenizationSpoke,
      reserveInfo: reserveInfo,
      maxAddAmount: maxAddAmount
    });
    vm.revertToState(snapshot);
  }

  /// @notice List of position-manager candidates checked per spoke in the snapshot.
  /// @dev Derived from the `PositionManagers` passed to `defaultTest`. Zero-address
  ///      members are harmless: `isPositionManagerActive(address(0))` simply returns
  ///      false. Override to probe additional (e.g. legacy) managers.
  function _positionManagerCandidates() internal view virtual returns (address[] memory) {
    address[] memory candidates = new address[](5);
    candidates[0] = address(_positionManagers.giver);
    candidates[1] = address(_positionManagers.taker);
    candidates[2] = address(_positionManagers.config);
    candidates[3] = address(_positionManagers.nativeGateway);
    candidates[4] = address(_positionManagers.signatureGateway);
    return candidates;
  }

  /// @notice Validate that the executor has no storage changes after payload execution.
  function _validateNoExecutorStorageChange(
    string memory stateDiffJson,
    address executor
  ) internal view virtual {
    string memory executorKey = Strings.toHexString(uint160(executor), 20);
    string memory stateDiffPath = string.concat('.', executorKey, '.stateDiff');
    if (vm.keyExistsJson(stateDiffJson, stateDiffPath)) {
      string[] memory slots = vm.parseJsonKeys(stateDiffJson, stateDiffPath);
      require(
        slots.length == 0,
        string.concat(
          'EXECUTOR_MUST_NOT_HAVE_STORAGE_CHANGES: ',
          Strings.toString(slots.length),
          ' slot(s) modified on executor ',
          executorKey
        )
      );
    }
  }
}
