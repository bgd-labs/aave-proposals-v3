// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {ISpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISpoke.sol';
import {IHub} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IHub.sol';
import {ITokenizationSpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ITokenizationSpoke.sol';
import {INativeTokenGateway} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/INativeTokenGateway.sol';
import {ISignatureGateway} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISignatureGateway.sol';
import {AaveV4EthereumPositionManagers, AaveV4EthereumTokenizationSpokes, AaveV4EthereumHubs} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4EthereumAddresses.sol';
import {GovV3Helpers, ChainIds} from 'aave-helpers/src/GovV3Helpers.sol';
import {Types} from './Types.sol';
import {SnapshotV4} from './SnapshotV4.sol';

/// @title ProtocolV4TestBase
/// @notice E2E test base for Aave V4 hub/spoke architecture.
///         Tests supply, withdraw, borrow, repay, and liquidation for each reserve on a spoke.
///         Tests deposit, mint, withdraw, redeem for each tokenization spoke.
///         Tests NativeTokenGateway and SignatureGateway for each spoke.
///         Loops over all good collaterals and uses randomized amounts.
contract ProtocolV4TestBase is SnapshotV4 {
  using SafeERC20 for IERC20;

  /// @notice Run the full V4 test suite: snapshot before, execute payload, snapshot after, diff, then e2e.
  function defaultTest(
    string memory reportName,
    ISpoke[] memory spokes,
    address[] memory tokenizationSpokes,
    address payload
  ) public {
    return defaultTest(reportName, spokes, tokenizationSpokes, payload, true);
  }

  function defaultTest(
    string memory reportName,
    ISpoke[] memory spokes,
    address[] memory tokenizationSpokes,
    address payload,
    bool runE2E
  ) public {
    if (payload != address(0)) {
      _snapshotDiffAndExecute(reportName, spokes, payload);
    }

    if (runE2E) {
      e2eTestAllSpokes(spokes);
      e2eTestAllTokenizationSpokes(tokenizationSpokes);
    }
  }

  function _snapshotDiffAndExecute(
    string memory reportName,
    ISpoke[] memory spokes,
    address payload
  ) private {
    IHub[] memory hubs = AaveV4EthereumHubs.getHubs();
    string memory beforeName = string.concat(reportName, '_before');
    string memory afterName = string.concat(reportName, '_after');

    Types.V4Snapshot memory snapshotBefore = createV4Snapshot(spokes, hubs);
    writeV4SnapshotJson(beforeName, snapshotBefore);

    (string memory rawDiff, string memory logsJson) = _executePayloadWithRecording(payload);

    Types.V4Snapshot memory snapshotAfter = createV4Snapshot(spokes, hubs);
    writeV4SnapshotJson(afterName, snapshotAfter);

    string memory afterPath = string.concat('./reports/', afterName, '.json');
    vm.writeJson(rawDiff, afterPath, '$.raw');
    vm.writeJson(logsJson, afterPath, '$.logs');

    diffV4Snapshots(reportName, snapshotBefore, snapshotAfter);
  }

  function _executePayloadWithRecording(
    address payload
  ) private returns (string memory rawDiff, string memory logsJson) {
    uint256 startGas = gasleft();
    vm.startStateDiffRecording();
    vm.recordLogs();

    GovV3Helpers.executePayload(
      vm,
      payload,
      address(GovV3Helpers.getPayloadsController(ChainIds.MAINNET))
    );

    uint256 gasUsed = startGas - gasleft();
    assertLt(gasUsed, (block.gaslimit * 95) / 100, 'BLOCK_GAS_LIMIT_EXCEEDED');

    rawDiff = vm.getStateDiffJson();
    logsJson = vm.getRecordedLogsJson();
  }

  /// @notice Test all reserves on every spoke in the array.
  function e2eTestAllSpokes(ISpoke[] memory spokes) public {
    for (uint256 i; i < spokes.length; i++) {
      console.log('--- E2E: Testing spoke %s ---', address(spokes[i]));
      console.log('--------------------------------');
      e2eTestSpoke(spokes[i]);
    }
  }

  /// @notice Test all reserves on one spoke, looping over ALL good collaterals, then gateway tests.
  function e2eTestSpoke(ISpoke spoke) public {
    Types.ReserveInfo[] memory allReserves = _getReserveInfo(spoke);
    Types.ReserveInfo[] memory goodCollaterals = _getAllUsableCollaterals(allReserves);
    require(goodCollaterals.length > 0, 'No usable collateral found');

    for (uint256 collateralIndex; collateralIndex < goodCollaterals.length; collateralIndex++) {
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
  function e2eTestAllTokenizationSpokes(address[] memory tokenizationSpokes) public {
    for (uint256 i; i < tokenizationSpokes.length; i++) {
      console.log('--- E2E: Testing tokenization spoke %s ---', tokenizationSpokes[i]);
      console.log('------------------------------------------');
      e2eTestTokenizationSpoke(ITokenizationSpoke(tokenizationSpokes[i]));
    }
  }

  /// @notice Run all tokenization spoke scenarios for a single spoke.
  function e2eTestTokenizationSpoke(ITokenizationSpoke tokenizationSpoke) public {
    Types.ReserveInfo memory reserveInfo = _getTokenizationReserveInfo(tokenizationSpoke);
    console.log('E2E: TokenizationSpoke asset: %s', reserveInfo.symbol);

    uint256 snapshot = vm.snapshotState();

    _testTokenizationAddCap(tokenizationSpoke, reserveInfo);
    vm.revertToState(snapshot);

    uint256 addCap = IHub(reserveInfo.hub)
      .getSpokeConfig(reserveInfo.assetId, address(tokenizationSpoke))
      .addCap;
    if (addCap == 0) {
      console.log('E2E: Skipping tokenization spoke %s (addCap is 0)', reserveInfo.symbol);
      return;
    }
    uint256 maxAddAmount = uint256(addCap) * 10 ** reserveInfo.decimals;

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
  }
}
