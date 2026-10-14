// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IHub, ISpoke, INativeTokenGateway} from 'aave-address-book/AaveV4.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV4EthereumSentoraCuratedAssets as Assets, AaveV4EthereumSentoraCuratedPositionManagers} from 'aave-address-book/AaveV4EthereumSentoraCurated.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {SentoraTestBase} from './SentoraTestBase.sol';
import {IMidasToken, IMidasAccessControl} from './SentoraInterfaces.sol';

/// @dev The market once the activation payload has unhalted it: parameters against the ARFC, and
/// every reserve exercised by a user.
contract SentoraMarketOpen_Test is SentoraTestBase {
  struct ReserveSpec {
    ISpoke spoke;
    address underlying;
    uint16 collateralFactor;
    uint32 maxLiquidationBonus;
    uint16 liquidationFee;
    uint24 collateralRisk;
    bool borrowable;
    uint40 addCap;
    uint40 drawCap;
  }

  INativeTokenGateway internal constant NATIVE_GATEWAY =
    AaveV4EthereumSentoraCuratedPositionManagers.NATIVE_TOKEN_GATEWAY;

  address internal lender = makeAddr('lender');
  address internal borrower = makeAddr('borrower');

  function test_haltedBeforeActivation() public {
    uint256 reserveId = _reserveId(RLUSD_YIELD, Assets.USDe_UNDERLYING);
    uint256 amount = 1_000e18;
    deal2(Assets.USDe_UNDERLYING, lender, amount);
    vm.startPrank(lender);
    IERC20(Assets.USDe_UNDERLYING).approve(address(RLUSD_YIELD), amount);
    vm.expectRevert(IHub.SpokeHalted.selector);
    RLUSD_YIELD.supply(reserveId, amount, lender);
    vm.stopPrank();
  }

  function test_parametersMatchSpec() public activated {
    ReserveSpec[] memory specs = _specs();
    for (uint256 i; i < specs.length; ++i) {
      ReserveSpec memory spec = specs[i];
      uint256 assetId = HUB.getAssetId(spec.underlying);
      uint256 reserveId = _reserveId(spec.spoke, spec.underlying);
      ISpoke.Reserve memory reserve = spec.spoke.getReserve(reserveId);
      ISpoke.ReserveConfig memory config = spec.spoke.getReserveConfig(reserveId);
      ISpoke.DynamicReserveConfig memory dynamicConfig = spec.spoke.getDynamicReserveConfig(
        reserveId,
        reserve.dynamicConfigKey
      );
      assertEq(dynamicConfig.collateralFactor, spec.collateralFactor, 'collateral factor');
      assertEq(dynamicConfig.maxLiquidationBonus, spec.maxLiquidationBonus, 'max bonus');
      assertEq(dynamicConfig.liquidationFee, spec.liquidationFee, 'liquidation fee');
      assertEq(config.collateralRisk, spec.collateralRisk, 'collateral risk');
      assertEq(config.borrowable, spec.borrowable, 'borrowable');
      assertFalse(config.paused, 'paused');
      assertFalse(config.frozen, 'frozen');
      // ARFC silent (D17): every reserve lets liquidators receive shares, as on chain
      assertTrue(config.receiveSharesEnabled, 'receive shares');

      IHub.SpokeConfig memory spokeConfig = HUB.getSpokeConfig(assetId, address(spec.spoke));
      assertEq(spokeConfig.addCap, spec.addCap, 'add cap');
      assertEq(spokeConfig.drawCap, spec.drawCap, 'draw cap');
      // ARFC silent (D17): borrowables carry no premium ceiling (uint24 max), as on chain
      assertEq(
        spokeConfig.riskPremiumThreshold,
        spec.borrowable ? type(uint24).max : 0,
        'risk premium threshold'
      );
      assertTrue(spokeConfig.active, 'active');
      assertFalse(spokeConfig.halted, 'halted');
    }

    for (uint256 assetId; assetId < ASSET_COUNT; ++assetId) {
      IHub.AssetConfig memory assetConfig = HUB.getAssetConfig(assetId);
      (address underlying, ) = HUB.getAssetUnderlyingAndDecimals(assetId);
      bool borrowable = underlying == Assets.RLUSD_UNDERLYING ||
        underlying == Assets.PYUSD_UNDERLYING ||
        underlying == Assets.OUSD_UNDERLYING;
      assertEq(assetConfig.feeReceiver, address(TREASURY_SPOKE), 'fee receiver');
      assertEq(assetConfig.liquidityFee, borrowable ? 20_00 : 0, 'liquidity fee');
      IAssetInterestRateStrategy.InterestRateData memory rates = IAssetInterestRateStrategy(
        assetConfig.irStrategy
      ).getInterestRateData(assetId);
      assertEq(rates.optimalUsageRatio, 90_00, 'optimal usage');
      assertEq(rates.baseDrawnRate, borrowable ? 50 : 0, 'base rate');
      assertEq(rates.rateGrowthBeforeOptimal, borrowable ? 3_50 : 0, 'slope 1');
      assertEq(rates.rateGrowthAfterOptimal, borrowable ? 12_00 : 0, 'slope 2');

      IHub.SpokeConfig memory treasury = HUB.getSpokeConfig(assetId, address(TREASURY_SPOKE));
      assertEq(treasury.addCap, HUB.MAX_ALLOWED_SPOKE_CAP(), 'treasury add cap');
      assertEq(treasury.drawCap, 0, 'treasury draw cap');
      assertFalse(treasury.halted, 'treasury halted');
    }

    ISpoke[] memory spokes = _spokes();
    for (uint256 i; i < spokes.length; ++i) {
      ISpoke.LiquidationConfig memory liquidation = spokes[i].getLiquidationConfig();
      assertEq(liquidation.targetHealthFactor, 1.24e18, 'target health factor');
      assertEq(liquidation.healthFactorForMaxBonus, 0.9e18, 'health factor for max bonus');
      assertEq(liquidation.liquidationBonusFactor, 90_00, 'liquidation bonus factor');
    }
  }

  function test_collateralsSupplyAndWithdraw() public activated {
    ReserveSpec[] memory specs = _specs();
    for (uint256 i; i < specs.length; ++i) {
      if (specs[i].borrowable) continue;
      uint256 snapshot = vm.snapshotState();
      ISpoke spoke = specs[i].spoke;
      uint256 reserveId = _reserveId(spoke, specs[i].underlying);
      uint256 amount = _units(spoke, reserveId, specs[i].addCap) / 100;

      _supplyCollateralAs(spoke, reserveId, lender, amount);
      uint256 kept = IERC20(specs[i].underlying).balanceOf(lender);
      assertEq(spoke.getUserSuppliedAssets(reserveId, lender), amount, 'supplied');
      (bool usingAsCollateral, ) = spoke.getUserReserveStatus(reserveId, lender);
      assertTrue(usingAsCollateral, 'collateral');
      assertGt(spoke.getUserAccountData(lender).totalCollateralValue, 0, 'collateral value');

      vm.prank(lender);
      vm.expectRevert(ISpoke.ReserveNotBorrowable.selector);
      spoke.borrow(reserveId, 1, lender);

      vm.prank(lender);
      spoke.withdraw(reserveId, type(uint256).max, lender);
      assertEq(spoke.getUserSuppliedAssets(reserveId, lender), 0, 'withdrawn');
      assertEq(IERC20(specs[i].underlying).balanceOf(lender), kept + amount, 'balance');
      vm.revertToState(snapshot);
    }
  }

  function test_borrowablesSupplyBorrowRepayWithdraw() public activated {
    ReserveSpec[] memory specs = _specs();
    for (uint256 i; i < specs.length; ++i) {
      if (!specs[i].borrowable) continue;
      uint256 snapshot = vm.snapshotState();
      ISpoke spoke = specs[i].spoke;
      address underlying = specs[i].underlying;
      uint256 reserveId = _reserveId(spoke, underlying);
      uint256 supplied = _units(spoke, reserveId, 100_000);
      uint256 borrowed = _units(spoke, reserveId, 50_000);

      _supplyAs(spoke, reserveId, lender, supplied);
      assertEq(spoke.getUserSuppliedAssets(reserveId, lender), supplied, 'supplied');

      (address collateral, uint256 collateralAmount) = spoke == BLUECHIP
        ? (Assets.kBTC_UNDERLYING, 2e8)
        : (Assets.USDe_UNDERLYING, 100_000e18);
      uint256 collateralId = _reserveId(spoke, collateral);
      _supplyCollateralAs(spoke, collateralId, borrower, collateralAmount);

      _borrowAs(spoke, reserveId, borrower, borrowed);
      assertEq(IERC20(underlying).balanceOf(borrower), borrowed, 'borrowed');
      assertEq(spoke.getUserTotalDebt(reserveId, borrower), borrowed, 'debt');

      vm.warp(block.timestamp + 30 days);
      uint256 debt = spoke.getUserTotalDebt(reserveId, borrower);
      assertGt(debt, borrowed, 'interest');
      deal2(underlying, borrower, debt);
      vm.startPrank(borrower);
      IERC20(underlying).approve(address(spoke), debt);
      spoke.repay(reserveId, type(uint256).max, borrower);
      spoke.withdraw(collateralId, type(uint256).max, borrower);
      vm.stopPrank();
      assertEq(spoke.getUserTotalDebt(reserveId, borrower), 0, 'repaid');
      assertEq(IERC20(underlying).balanceOf(borrower), 0, 'repay pulled the debt');
      assertEq(IERC20(collateral).balanceOf(borrower), collateralAmount, 'collateral back');

      uint256 lenderAssets = spoke.getUserSuppliedAssets(reserveId, lender);
      assertGt(lenderAssets, supplied, 'lender earned');
      vm.prank(lender);
      spoke.withdraw(reserveId, type(uint256).max, lender);
      assertEq(IERC20(underlying).balanceOf(lender), lenderAssets, 'lender withdrew');
      vm.revertToState(snapshot);
    }
  }

  function test_borrowablesAreNotCollateral() public activated {
    ReserveSpec[] memory specs = _specs();
    for (uint256 i; i < specs.length; ++i) {
      if (!specs[i].borrowable) continue;
      uint256 snapshot = vm.snapshotState();
      ISpoke spoke = specs[i].spoke;
      uint256 reserveId = _reserveId(spoke, specs[i].underlying);
      _supplyCollateralAs(spoke, reserveId, borrower, _units(spoke, reserveId, 10_000));
      assertEq(spoke.getUserAccountData(borrower).totalCollateralValue, 0, 'collateral value');

      vm.prank(borrower);
      vm.expectRevert(ISpoke.HealthFactorBelowThreshold.selector);
      spoke.borrow(reserveId, 1, borrower);
      vm.revertToState(snapshot);
    }
  }

  function test_nativeGatewayRejectsEveryReserve() public activated {
    vm.expectRevert(IHub.AssetNotListed.selector);
    HUB.getAssetId(AaveV3EthereumAssets.WETH_UNDERLYING);

    vm.deal(borrower, 1 ether);
    ISpoke[] memory spokes = _spokes();
    for (uint256 i; i < spokes.length; ++i) {
      address spoke = address(spokes[i]);
      uint256 reserveCount = spokes[i].getReserveCount();
      for (uint256 reserveId; reserveId < reserveCount; ++reserveId) {
        vm.startPrank(borrower);
        vm.expectRevert(INativeTokenGateway.NotNativeWrappedAsset.selector);
        NATIVE_GATEWAY.supplyNative{value: 1 ether}(spoke, reserveId, 1 ether);
        vm.expectRevert(INativeTokenGateway.NotNativeWrappedAsset.selector);
        NATIVE_GATEWAY.supplyAsCollateralNative{value: 1 ether}(spoke, reserveId, 1 ether);
        vm.expectRevert(INativeTokenGateway.NotNativeWrappedAsset.selector);
        NATIVE_GATEWAY.withdrawNative(spoke, reserveId, 1 ether);
        vm.expectRevert(INativeTokenGateway.NotNativeWrappedAsset.selector);
        NATIVE_GATEWAY.borrowNative(spoke, reserveId, 1 ether);
        vm.expectRevert(INativeTokenGateway.NotNativeWrappedAsset.selector);
        NATIVE_GATEWAY.repayNative{value: 1 ether}(spoke, reserveId, 1 ether);
        vm.stopPrank();
      }
    }
  }

  /// @dev Pins the on-chain mWIN restrictions other tests resolve by simulating Midas onboarding:
  /// the Hub holds neither the Midas greenlist role nor the min-balance exemption, so a deposit from
  /// a greenlisted holder still reverts in the token.
  function test_mWinTransferRestrictions() public activated {
    IMidasToken mWin = IMidasToken(Assets.mWIN_UNDERLYING);
    IMidasAccessControl accessControl = IMidasAccessControl(mWin.accessControl());
    bytes32 greenlisted = mWin.M_WIN_GREENLISTED_ROLE();
    bytes32 minBalanceExempt = mWin.M_WIN_MIN_BALANCE_EXEMPT_ROLE();
    assertFalse(accessControl.hasRole(greenlisted, address(HUB)), 'hub greenlisted');
    assertFalse(accessControl.hasRole(minBalanceExempt, address(HUB)), 'hub min balance exempt');
    assertEq(accessControl.getRoleAdmin(greenlisted), bytes32(0), 'greenlist admin role');
    assertEq(accessControl.getRoleAdmin(minBalanceExempt), bytes32(0), 'exempt admin role');
    assertTrue(accessControl.hasRole(bytes32(0), MIDAS_ADMIN), 'midas admin');

    uint256 reserveId = _reserveId(RLUSD_YIELD, Assets.mWIN_UNDERLYING);
    uint256 amount = 1e18;
    deal(Assets.mWIN_UNDERLYING, lender, amount);
    _midasGrant(greenlisted, lender);
    vm.startPrank(lender);
    IERC20(Assets.mWIN_UNDERLYING).approve(address(RLUSD_YIELD), amount);
    vm.expectRevert(bytes('WMAC: hasnt role'));
    RLUSD_YIELD.supply(reserveId, amount, lender);
    vm.stopPrank();
  }

  /// @dev Once the Hub is onboarded, a greenlisted holder still cannot receive mWIN into a balance
  /// under the Midas minimum of 1 mWIN.
  function test_mWinMinBalanceOnWithdraw() public activated {
    _midasOnboardHub();
    uint256 reserveId = _reserveId(RLUSD_YIELD, Assets.mWIN_UNDERLYING);
    deal(Assets.mWIN_UNDERLYING, lender, 2e18);
    _midasGrant(_mWin().M_WIN_GREENLISTED_ROLE(), lender);
    vm.startPrank(lender);
    IERC20(Assets.mWIN_UNDERLYING).approve(address(RLUSD_YIELD), 2e18);
    RLUSD_YIELD.supply(reserveId, 2e18, lender);

    vm.expectRevert(bytes('MTMB: min balance not met'));
    RLUSD_YIELD.withdraw(reserveId, M_WIN_MIN_BALANCE - 1, lender);
    RLUSD_YIELD.withdraw(reserveId, M_WIN_MIN_BALANCE, lender);
    vm.stopPrank();
    assertEq(IERC20(Assets.mWIN_UNDERLYING).balanceOf(lender), M_WIN_MIN_BALANCE, 'withdrawn');
  }

  /// @dev ARFC "Spoke Parameters" and "Add & Draw Caps" tables; borrowables carry no collateral
  /// config in the ARFC, so their 0 collateral factor, 100.00% bonus and 0 fee are as on chain.
  function _specs() internal pure returns (ReserveSpec[] memory s) {
    s = new ReserveSpec[](14);
    s[0] = _borrowable(RLUSD_YIELD, Assets.RLUSD_UNDERLYING, 100_000_000, 90_000_000);
    s[1] = _usde(RLUSD_YIELD, 50_000_000);
    s[2] = _prime(RLUSD_YIELD, 15_000_000);
    s[3] = _mWin(RLUSD_YIELD, 75);
    s[4] = _pst(RLUSD_YIELD, 20_000_000);
    s[5] = _borrowable(OUSD_YIELD, Assets.OUSD_UNDERLYING, 10_000_000, 9_000_000);
    s[6] = _usde(OUSD_YIELD, 5_000_000);
    s[7] = _prime(OUSD_YIELD, 1_500_000);
    s[8] = _mWin(OUSD_YIELD, 7);
    s[9] = _pst(OUSD_YIELD, 2_000_000);
    s[10] = _borrowable(BLUECHIP, Assets.RLUSD_UNDERLYING, 33_300_000, 30_000_000);
    s[11] = _borrowable(BLUECHIP, Assets.PYUSD_UNDERLYING, 33_300_000, 30_000_000);
    s[12] = _borrowable(BLUECHIP, Assets.OUSD_UNDERLYING, 5_000_000, 4_500_000);
    s[13] = ReserveSpec(BLUECHIP, Assets.kBTC_UNDERLYING, 86_00, 104_50, 4_50, 0, false, 580, 0);
  }

  function _borrowable(
    ISpoke spoke,
    address underlying,
    uint40 addCap,
    uint40 drawCap
  ) internal pure returns (ReserveSpec memory) {
    return ReserveSpec(spoke, underlying, 0, 100_00, 0, 0, true, addCap, drawCap);
  }

  function _usde(ISpoke spoke, uint40 addCap) internal pure returns (ReserveSpec memory) {
    return ReserveSpec(spoke, Assets.USDe_UNDERLYING, 91_50, 103_50, 3_50, 6_25, false, addCap, 0);
  }

  function _prime(ISpoke spoke, uint40 addCap) internal pure returns (ReserveSpec memory) {
    return
      ReserveSpec(spoke, Assets.PRIME_UNDERLYING, 89_50, 105_00, 5_00, 18_75, false, addCap, 0);
  }

  function _mWin(ISpoke spoke, uint40 addCap) internal pure returns (ReserveSpec memory) {
    return ReserveSpec(spoke, Assets.mWIN_UNDERLYING, 84_60, 107_50, 7_50, 0, false, addCap, 0);
  }

  function _pst(ISpoke spoke, uint40 addCap) internal pure returns (ReserveSpec memory) {
    return ReserveSpec(spoke, Assets.PST_UNDERLYING, 87_50, 105_00, 5_00, 75_00, false, addCap, 0);
  }
}
