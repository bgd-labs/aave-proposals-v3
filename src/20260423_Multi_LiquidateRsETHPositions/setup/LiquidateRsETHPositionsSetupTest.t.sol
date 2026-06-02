// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {EModeConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/EModeConfiguration.sol';
import {UserConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/UserConfiguration.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {PercentageMath} from 'aave-v3-origin/contracts/protocol/libraries/math/PercentageMath.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/contracts/interfaces/IScaledBalanceToken.sol';
import {IPool, IAaveOracle, IPoolConfigurator} from 'aave-address-book/AaveV3.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IFixedPriceAdapter} from 'src/interfaces/IFixedPriceFeed.sol';
import {IGuardianEnabledFlag} from 'src/interfaces/IGuardianEnabledFlag.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {LiquidateRsETHPositionsSetup} from './LiquidateRsETHPositionsSetup.sol';

/// @notice Common tests + helpers shared across chains. Chain-only tests live per-chain.
abstract contract LiquidateRsETHPositionsSetupTest is ProtocolV3TestBase {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;
  using UserConfiguration for DataTypes.UserConfigurationMap;
  using PercentageMath for uint256;
  using SafeERC20 for IERC20;

  string internal constant FAILED_ACTION_EXECUTION = '29'; // action failed to execute
  int256 internal constant FIXED_PRICE = 1;
  uint256 internal constant HEALTH_FACTOR_LIQUIDATION_THRESHOLD = 1e18;

  LiquidateRsETHPositionsSetup internal proposal;
  address internal user;

  function _setupFork() internal virtual;
  function _newProposal() internal virtual returns (LiquidateRsETHPositionsSetup);
  function _executor() internal pure virtual returns (address);

  function setUp() public virtual {
    _setupFork();
    proposal = _newProposal();
    user = proposal.getUser();
    _enableGuardianFlag();
  }

  function _pool() internal view returns (IPool) {
    return proposal.POOL();
  }

  function _oracle() internal view returns (IAaveOracle) {
    return proposal.ORACLE();
  }

  function _poolConfigurator() internal view returns (IPoolConfigurator) {
    return proposal.POOL_CONFIGURATOR();
  }

  function _collector() internal view returns (address) {
    return address(proposal.COLLECTOR());
  }

  function _weth() internal view returns (address) {
    return proposal.WETH();
  }

  function _wsteth() internal view returns (address) {
    return proposal.WSTETH();
  }

  function _rsEth() internal view returns (address) {
    return proposal.RSETH();
  }

  function _recoveryGuardian() internal view returns (address) {
    return proposal.RECOVERY_GUARDIAN();
  }

  function _guardianEnabledFlag() internal view returns (address) {
    return proposal.GUARDIAN_ENABLED_FLAG();
  }

  function _aTokenOf(address asset) internal view returns (address) {
    return _pool().getReserveData(asset).aTokenAddress;
  }

  function _vDebtTokenOf(address asset) internal view returns (address) {
    return _pool().getReserveData(asset).variableDebtTokenAddress;
  }

  function test_liquidatedDebtAsset() public view virtual {
    assertEq(_liquidatedDebtAsset(), _weth());
  }

  function test_guardianEnabledFlag_enabledInSetup() public view {
    assertTrue(IGuardianEnabledFlag(_guardianEnabledFlag()).enabled());
    assertEq(IGuardianEnabledFlag(_guardianEnabledFlag()).GUARDIAN(), _recoveryGuardian());
  }

  /// @dev Calls `execute()` directly so the gate revert isn't swallowed by the
  /// payloads controller's action-execution wrapper.
  function test_executeRevertsWhenGuardianFlagDisabled() public {
    address guardianEnabledFlag = _guardianEnabledFlag();
    vm.prank(_recoveryGuardian());
    IGuardianEnabledFlag(guardianEnabledFlag).setEnabled(false);
    assertFalse(IGuardianEnabledFlag(guardianEnabledFlag).enabled());

    vm.expectRevert(bytes('GUARDIAN_FLAG_DISABLED'));
    proposal.execute();
  }

  function test_executePayloadRevertsWhenGuardianFlagDisabled() public {
    address guardianEnabledFlag = _guardianEnabledFlag();
    vm.prank(_recoveryGuardian());
    IGuardianEnabledFlag(guardianEnabledFlag).setEnabled(false);

    uint40 payloadId = GovV3Helpers.readyPayload(vm, address(proposal));
    address controller = address(GovV3Helpers.getPayloadsController(block.chainid));

    vm.expectRevert(abi.encode(FAILED_ACTION_EXECUTION));
    IPayloadsControllerCore(controller).executePayload(payloadId);
  }

  function test_executeSucceedsAfterFlagDisabledThenReEnabled() public {
    address guardianEnabledFlag = _guardianEnabledFlag();
    vm.prank(_recoveryGuardian());
    IGuardianEnabledFlag(guardianEnabledFlag).setEnabled(false);
    vm.prank(_recoveryGuardian());
    IGuardianEnabledFlag(guardianEnabledFlag).setEnabled(true);

    executePayload(vm, address(proposal));
    assertEq(IERC20(_aTokenOf(_rsEth())).balanceOf(user), 0, 'rsETH not seized after re-enable');
  }

  function test_setEnabledRevertsForNonGuardian() public {
    address guardianEnabledFlag = _guardianEnabledFlag();

    vm.expectRevert('Only guardian');
    vm.prank(makeAddr('notGuardian'));
    IGuardianEnabledFlag(guardianEnabledFlag).setEnabled(true);

    vm.expectRevert('Only guardian');
    vm.prank(makeAddr('notGuardian'));
    IGuardianEnabledFlag(guardianEnabledFlag).setEnabled(false);
  }

  function test_userDebtAssets() public view virtual {
    address[] memory debts = _allDebtAssets();
    assertEq(debts.length, 1, 'user has unexpected number of debt assets');
    assertEq(debts[0], _weth(), 'user has unexpected debt asset');
  }

  function test_userHasRsEthEnabledAsCollateral() public view {
    uint256 rsethId = _pool().getReserveData(_rsEth()).id;
    assertTrue(
      _pool().getUserConfiguration(user).isUsingAsCollateral(rsethId),
      'user does not have rsETH enabled as collateral'
    );
    assertGt(IERC20(_aTokenOf(_rsEth())).balanceOf(user), 0, 'user has zero rsETH balance');
  }

  function test_userOnlyHasRsEthAsCollateral() public view {
    address rseth = _rsEth();
    address[] memory reserves = _pool().getReservesList();
    DataTypes.UserConfigurationMap memory cfg = _pool().getUserConfiguration(user);
    for (uint256 i; i < reserves.length; ++i) {
      if (reserves[i] == rseth) {
        assertTrue(
          cfg.isUsingAsCollateral(i),
          'user does not have rsETH reserve enabled as collateral'
        );
      } else {
        assertFalse(
          cfg.isUsingAsCollateral(i),
          'user has a non-rsETH reserve enabled as collateral'
        );
      }
    }
  }

  function test_userDoesNotHaveDebtAssetsAsCollateral() public view {
    address[] memory debts = _allDebtAssets();
    DataTypes.UserConfigurationMap memory cfg = _pool().getUserConfiguration(user);
    for (uint256 j; j < debts.length; ++j) {
      uint256 id = _pool().getReserveData(debts[j]).id;
      assertFalse(cfg.isUsingAsCollateral(id), 'user has debt asset enabled as collateral');
    }
  }

  /// @dev End-to-end happy path: payload fully seizes rsETH. liquidationCall
  /// repays `dust` on the liquidated debt asset, `_burnBadDebt` zeros the residual
  /// on every debt asset and converts it to reserve deficit.
  function test_userLiquidated() public {
    address[] memory debts = _allDebtAssets();
    address liquidatedAsset = _liquidatedDebtAsset();
    uint256[] memory userDebtBefore = new uint256[](debts.length);
    uint256[] memory deficitBefore = new uint256[](debts.length);
    uint256[] memory expectedIncrease = new uint256[](debts.length);
    for (uint256 j; j < debts.length; ++j) {
      userDebtBefore[j] = IERC20(_vDebtTokenOf(debts[j])).balanceOf(user);
      deficitBefore[j] = _pool().getReserveDeficit(debts[j]);
      // Liquidated debt asset: repaid via liquidationCall before _burnBadDebt.
      // Other debt assets: full pre-AIP debt converted to deficit.
      expectedIncrease[j] = debts[j] == liquidatedAsset
        ? userDebtBefore[j] -
          _calcDebtRepaid({
            debtAsset: debts[j],
            colPrice: uint256(FIXED_PRICE),
            debtPrice: _oracle().getAssetPrice(debts[j])
          })
        : userDebtBefore[j];
    }

    executePayload(vm, address(proposal));

    assertEq(IERC20(_aTokenOf(_rsEth())).balanceOf(user), 0, 'rsETH not fully liquidated');

    for (uint256 j; j < debts.length; ++j) {
      assertEq(
        IERC20(_vDebtTokenOf(debts[j])).balanceOf(user),
        0,
        'user vDebt not cleared post-AIP'
      );
      assertEq(
        _pool().getReserveDeficit(debts[j]) - deficitBefore[j],
        expectedIncrease[j],
        'deficit increase != userDebt - dust'
      );
    }
  }

  function test_allReserveConfigsAndOraclesUnchanged() public {
    address[] memory reserves = _pool().getReservesList();
    uint256[] memory configsBefore = new uint256[](reserves.length);
    address[] memory oraclesBefore = new address[](reserves.length);
    for (uint256 i; i < reserves.length; ++i) {
      configsBefore[i] = _pool().getConfiguration(reserves[i]).data;
      oraclesBefore[i] = _oracle().getSourceOfAsset(reserves[i]);
    }

    executePayload(vm, address(proposal));

    for (uint256 i; i < reserves.length; ++i) {
      assertEq(
        _pool().getConfiguration(reserves[i]).data,
        configsBefore[i],
        string.concat('reserve config changed for ', vm.toString(reserves[i]))
      );
      assertEq(
        _oracle().getSourceOfAsset(reserves[i]),
        oraclesBefore[i],
        string.concat('oracle source changed for ', vm.toString(reserves[i]))
      );
    }
  }

  function test_fixedFeedPriceSetToOne() public {
    assertEq(
      IFixedPriceAdapter(proposal.FIXED_PRICE_FEED()).price(),
      FIXED_PRICE,
      'fixed feed price not set to 1 pre-AIP'
    );

    vm.recordLogs();
    executePayload(vm, address(proposal));
    Vm.Log[] memory logs = vm.getRecordedLogs();
    for (uint256 i; i < logs.length; ++i) {
      assertNotEq(
        logs[i].topics[0],
        IFixedPriceAdapter.FixedPriceUpdated.selector,
        'FixedPriceUpdated event emitted'
      );
    }

    assertEq(
      IFixedPriceAdapter(proposal.FIXED_PRICE_FEED()).price(),
      FIXED_PRICE,
      'fixed feed price not set to 1 post-AIP'
    );
  }

  function test_constants() public view {
    assertEq(proposal.MIN_LT_BPS(), 1, 'MIN_LT_BPS');
    assertEq(proposal.MIN_LTV_BPS(), 1, 'MIN_LTV_BPS');
    assertEq(proposal.DEBT_ASSET_BUFFER(), 0.01 ether, 'DEBT_ASSET_BUFFER');
  }

  function test_wethEffectiveLtvIsZeroPreAndPostAip() public {
    _assertAssetEffectiveLtvIsZero(_weth(), 'WETH (before AIP)');
    executePayload(vm, address(proposal));
    _assertAssetEffectiveLtvIsZero(_weth(), 'WETH (after AIP)');
  }

  function test_rsEthLtvIsZeroPreAndPostAip() public {
    _assertAssetEffectiveLtvIsZero(_rsEth(), 'rsETH (before AIP)');
    executePayload(vm, address(proposal));
    _assertAssetEffectiveLtvIsZero(_rsEth(), 'rsETH (after AIP)');
  }

  function test_rsEthPausedPreAndPostAip() public {
    assertTrue(_pool().getConfiguration(_rsEth()).getPaused(), 'rsETH not paused pre-AIP');
    executePayload(vm, address(proposal));
    assertTrue(_pool().getConfiguration(_rsEth()).getPaused(), 'rsETH not paused post-AIP');
  }

  function test_allowancesCleared() public {
    executePayload(vm, address(proposal));
    assertEq(
      IERC20(_weth()).allowance(_executor(), address(_pool())),
      0,
      'WETH allowance not cleared'
    );
    assertEq(
      IERC20(_wsteth()).allowance(_executor(), address(_pool())),
      0,
      'wstETH allowance not cleared'
    );
  }

  /// @dev Pre-pausing the liquidated debt asset must not block the AIP: it
  /// unpauses for the call and restores the pause state on exit.
  function test_aipWorksWithPausedLiquidatedAsset() public {
    address liquidatedAsset = _liquidatedDebtAsset();

    IPoolConfigurator configurator = _poolConfigurator();
    vm.prank(_executor());
    configurator.setReservePause({asset: liquidatedAsset, paused: true, gracePeriod: 0});
    assertTrue(
      _pool().getConfiguration(liquidatedAsset).getPaused(),
      'precondition: liquidatedAsset must be paused'
    );

    executePayload(vm, address(proposal));

    assertEq(IERC20(_aTokenOf(_rsEth())).balanceOf(user), 0, 'rsETH not seized');
    assertTrue(
      _pool().getConfiguration(liquidatedAsset).getPaused(),
      'liquidatedAsset pause flipped post-AIP'
    );
  }

  function test_aipDebtAssetsPausedPreAndPostAip() public {
    IPoolConfigurator configurator = _poolConfigurator();
    address[] memory debtAssets = _allDebtAssets();
    for (uint256 i; i < debtAssets.length; ++i) {
      vm.prank(_executor());
      configurator.setReservePause({asset: debtAssets[i], paused: true, gracePeriod: 0});
      assertTrue(
        _pool().getConfiguration(debtAssets[i]).getPaused(),
        'precondition: debtAsset must be paused'
      );
    }

    executePayload(vm, address(proposal));

    for (uint256 i; i < debtAssets.length; ++i) {
      assertTrue(
        _pool().getConfiguration(debtAssets[i]).getPaused(),
        'debtAsset pause not restored post-AIP'
      );
    }
    assertEq(
      IERC20(_aTokenOf(_rsEth())).balanceOf(user),
      0,
      'rsETH not seized despite paused WETH'
    );
  }

  function test_executorFundsSwept() public {
    uint256 rsEthExecutorBefore = 1 ether;
    deal(_rsEth(), _executor(), rsEthExecutorBefore);

    address[] memory debtAssets = _allDebtAssets();
    executePayload(vm, address(proposal));
    for (uint256 i; i < debtAssets.length; ++i) {
      assertEq(IERC20(debtAssets[i]).balanceOf(_executor()), 0);
    }
    assertEq(IERC20(_rsEth()).balanceOf(_executor()), rsEthExecutorBefore);
  }

  /// @dev Collector net-loss <= `DEBT_ASSET_BUFFER`
  function test_collectorWethLossBoundedByBuffer() public {
    address[] memory debtAssets = _allDebtAssets();
    uint256[] memory collectorDebtAssetsBefore = new uint256[](debtAssets.length);
    for (uint256 i; i < debtAssets.length; ++i) {
      collectorDebtAssetsBefore[i] = IERC20(debtAssets[i]).balanceOf(_collector());
    }
    executePayload(vm, address(proposal));
    for (uint256 i; i < debtAssets.length; ++i) {
      assertGe(
        IERC20(debtAssets[i]).balanceOf(_collector()) + proposal.DEBT_ASSET_BUFFER(),
        collectorDebtAssetsBefore[i],
        'collector lost more than DEBT_ASSET_BUFFER'
      );
    }
  }

  /// @dev Verifies rsETH flow accounting: seized user rsETH is delivered to
  /// guardian, reflected in aToken virtual balance, and never routed to collector.
  function test_guardianReceivedAllUserRsEth() public {
    address rsEthA = _aTokenOf(_rsEth());

    uint256 userRsEthBefore = IERC20(rsEthA).balanceOf(user);
    uint256 guardianRsEthBefore = IERC20(_rsEth()).balanceOf(_recoveryGuardian());
    uint256 collectorRsEthBefore = IERC20(_rsEth()).balanceOf(_collector());
    uint128 vbalanceBefore = _pool().getVirtualUnderlyingBalance(_rsEth());

    executePayload(vm, address(proposal));

    assertEq(IERC20(rsEthA).balanceOf(user), 0, 'user rsETH not fully seized');

    uint256 guardianIncrease = IERC20(_rsEth()).balanceOf(_recoveryGuardian()) -
      guardianRsEthBefore;
    assertApproxEqAbs(guardianIncrease, userRsEthBefore, 1, 'guardian rsETH increase != seized');

    uint256 vbalanceDecrease = vbalanceBefore - _pool().getVirtualUnderlyingBalance(_rsEth());
    assertEq(vbalanceDecrease, guardianIncrease, 'rsETH aToken vbalance drop != guardian receipt');

    assertEq(
      IERC20(_rsEth()).balanceOf(_collector()),
      collectorRsEthBefore,
      'collector rsETH balance changed (rsETH must bypass collector)'
    );
  }

  /// @dev Users expected to produce WETH deficit equal to `userWethDebtBefore - debt repaid(WETH)`
  function test_deficitCreated() public {
    address[] memory debtAssets = _allDebtAssets();
    address liquidatedAsset = _liquidatedDebtAsset();
    uint256[] memory userDebtBefore = new uint256[](debtAssets.length);
    uint256[] memory deficitBefore = new uint256[](debtAssets.length);
    for (uint256 i; i < debtAssets.length; ++i) {
      userDebtBefore[i] = IERC20(_vDebtTokenOf(debtAssets[i])).balanceOf(user);
      deficitBefore[i] = _pool().getReserveDeficit(debtAssets[i]);
    }
    uint256 debtRepaid = _calcDebtRepaid(
      liquidatedAsset,
      uint256(FIXED_PRICE),
      _oracle().getAssetPrice(liquidatedAsset)
    );

    executePayload(vm, address(proposal));

    for (uint256 i; i < debtAssets.length; ++i) {
      uint256 deficitAfter = _pool().getReserveDeficit(debtAssets[i]);
      assertEq(
        deficitAfter - deficitBefore[i],
        (debtAssets[i] == liquidatedAsset) ? userDebtBefore[i] - debtRepaid : userDebtBefore[i],
        'deficit increase != userDebtBefore - debtRepaid'
      );
    }
  }

  function test_logUserDebtScaledBalance() public {
    address weth = _weth();
    address vWeth = _vDebtTokenOf(weth);

    emit log_named_address('user', user);
    emit log_named_uint('block', block.number);
    emit log_named_uint('weth.debt.balanceOf', IERC20(vWeth).balanceOf(user));
    emit log_named_uint(
      'weth.debt.scaledBalanceOf',
      IScaledBalanceToken(vWeth).scaledBalanceOf(user)
    );
    emit log_named_decimal_uint(
      'weth.debt.scaledBalanceOf 1e18',
      IScaledBalanceToken(vWeth).scaledBalanceOf(user),
      18
    );
  }

  /// @dev Full-seize debt formula for rsETH collateral:
  ///   debtAmountNeeded = (colPrice * userColBal * debtUnit / (debtPrice * colUnit)).percentDiv(lb)
  /// Both prices passed in so the helper works with arbitrary live oracle values.
  function _calcDebtRepaid(
    address debtAsset,
    uint256 colPrice,
    uint256 debtPrice
  ) internal view returns (uint256) {
    DataTypes.ReserveConfigurationMap memory rsEthCfg = _pool().getConfiguration(_rsEth());
    uint256 lb = _rsEthLiquidationBonusForUser();
    uint256 userColBal = IERC20(_aTokenOf(_rsEth())).balanceOf(user);
    if (debtPrice == 0 || lb == 0) {
      return 0;
    }
    uint256 colUnit = 10 ** rsEthCfg.getDecimals();
    uint256 debtUnit = 10 ** _pool().getConfiguration(debtAsset).getDecimals();
    return ((colPrice * userColBal * debtUnit) / (debtPrice * colUnit)).percentDivCeil(lb);
  }

  /// @dev Mirrors the proposal's `_liquidateUser` logic: pick the debt asset
  /// with the larger USD-valued debt (WETH vs extras like wstETH).
  function _liquidatedDebtAsset() internal view returns (address) {
    address[] memory debts = _allDebtAssets();
    address asset = debts[0];
    uint256 maxValue = IERC20(_vDebtTokenOf(asset)).balanceOf(user) *
      _oracle().getAssetPrice(asset);
    for (uint256 j = 1; j < debts.length; ++j) {
      uint256 value = IERC20(_vDebtTokenOf(debts[j])).balanceOf(user) *
        _oracle().getAssetPrice(debts[j]);
      if (value > maxValue) {
        maxValue = value;
        asset = debts[j];
      }
    }
    return asset;
  }

  /// @dev eMode LB when user is in an eMode that lists
  /// rsETH as collateral; otherwise the reserve config's LB.
  function _rsEthLiquidationBonusForUser() internal view returns (uint256) {
    uint8 eModeId = uint8(_pool().getUserEMode(user));
    if (eModeId != 0) {
      uint128 colBitmap = _pool().getEModeCategoryCollateralBitmap(eModeId);
      uint256 rsEthId = _pool().getReserveData(_rsEth()).id;
      if (EModeConfiguration.isReserveEnabledOnBitmap(colBitmap, rsEthId)) {
        return _pool().getEModeCategoryCollateralConfig(eModeId).liquidationBonus;
      }
    }
    return _pool().getConfiguration(_rsEth()).getLiquidationBonus();
  }

  function _allDebtAssets() internal view returns (address[] memory all) {
    uint256 count = 0;
    for (uint256 i; i < _pool().getReservesList().length; ++i) {
      address asset = _pool().getReservesList()[i];
      uint256 balance = IERC20(_vDebtTokenOf(asset)).balanceOf(user);
      if (balance > 0) {
        count += 1;
      }
    }

    all = new address[](count);
    count = 0;
    for (uint256 i; i < _pool().getReservesList().length; ++i) {
      address asset = _pool().getReservesList()[i];
      uint256 balance = IERC20(_vDebtTokenOf(asset)).balanceOf(user);
      if (balance > 0) {
        all[count] = asset;
        count += 1;
      }
    }
  }

  function _assertAssetEffectiveLtvIsZero(address asset, string memory label) internal view {
    assertEq(
      _pool().getConfiguration(asset).getLtv(),
      0,
      string.concat(label, ' reserve LTV not 0')
    );

    uint256 reserveId = _pool().getReserveData(asset).id;
    for (uint8 id = 1; id < type(uint8).max; ++id) {
      uint128 collateralBitmap = _pool().getEModeCategoryCollateralBitmap(id);
      if (!EModeConfiguration.isReserveEnabledOnBitmap(collateralBitmap, reserveId)) {
        continue;
      }
      uint128 ltvzeroBitmap = _pool().getEModeCategoryLtvzeroBitmap(id);
      if (EModeConfiguration.isReserveEnabledOnBitmap(ltvzeroBitmap, reserveId)) {
        continue;
      }
      assertEq(
        _pool().getEModeCategoryCollateralConfig(id).ltv,
        0,
        string.concat(label, ' raw eMode LTV not 0 (and asset not in ltvzeroBitmap)')
      );
    }
  }

  function _fundGuardianWithAToken(address asset, uint256 amount) internal {
    IPool pool = _pool();
    IPoolConfigurator configurator = _poolConfigurator();
    if (pool.getConfiguration(asset).getFrozen()) {
      vm.prank(_executor());
      configurator.setReserveFreeze(asset, false);
    }
    uint256 unit = 10 ** pool.getConfiguration(asset).getDecimals();
    uint256 toMint = amount + unit;
    deal(asset, address(this), toMint);
    IERC20(asset).forceApprove(address(pool), toMint);
    pool.supply(asset, toMint, _recoveryGuardian(), 0);
  }

  /// @dev Etches a fresh `GuardianEnabledFlag` at the payload's hardcoded
  /// address (with `RECOVERY_GUARDIAN` baked in as the immutable guardian)
  /// and flips `enabled` to true so the AIP can run.
  function _enableGuardianFlag() internal {
    address guardianEnabledFlag = _guardianEnabledFlag();
    vm.prank(_recoveryGuardian());
    IGuardianEnabledFlag(guardianEnabledFlag).setEnabled(true);
  }
}
