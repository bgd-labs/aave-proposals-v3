// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {GovernanceV3Plasma} from 'aave-address-book/GovernanceV3Plasma.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IPendlePriceCapAdapter} from '../interfaces/IPendlePriceCapAdapter.sol';
import {AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615} from './AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615.sol';

/**
 * @dev Test for AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260615_AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma/AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615.t.sol -vv
 */
contract AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615_Test is ProtocolV3TestBase {
  AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 24585111);
    proposal = new AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasPT_sUSDE_22OCT2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_sUSDE_22OCT2026());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 10 ** 18);
  }

  function test_borrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = address(505);
    uint256 supplyAmount = 100_000e18;
    deal(proposal.PT_sUSDE_22OCT2026(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.PT_sUSDE_22OCT2026()).approve(address(AaveV3Plasma.POOL), supplyAmount);
    AaveV3Plasma.POOL.supply(proposal.PT_sUSDE_22OCT2026(), supplyAmount, user, 0);

    // PT-sUSDe has LTV=0 outside e-mode, borrow must revert
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Plasma.POOL.borrow(AaveV3PlasmaAssets.USDe_UNDERLYING, 1, 2, 0, user);

    vm.stopPrank();
  }

  function test_eMode_Stablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyPTAndBorrowInEMode(
      'sUSDe_PT_sUSDe_22OCT2026__Stablecoins',
      AaveV3PlasmaAssets.USDe_UNDERLYING,
      AaveV3PlasmaAssets.USDe_V_TOKEN
    );
  }

  function test_eMode_USDe_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyPTAndBorrowInEMode(
      'sUSDe_PT_sUSDe_22OCT2026__USDe',
      AaveV3PlasmaAssets.USDe_UNDERLYING,
      AaveV3PlasmaAssets.USDe_V_TOKEN
    );
  }

  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address[] memory collaterals = new address[](2);
    collaterals[0] = AaveV3PlasmaAssets.sUSDe_UNDERLYING;
    collaterals[1] = proposal.PT_sUSDE_22OCT2026();

    uint8 stablecoins = _findEModeCategoryId('sUSDe_PT_sUSDe_22OCT2026__Stablecoins');
    _assertEModeCollateralConfig({
      id: stablecoins,
      ltv: 87_71,
      liquidationThreshold: 89_71,
      liquidationBonus: 104_87
    });
    assertTrue(AaveV3Plasma.POOL.getIsEModeCategoryIsolated(stablecoins));

    address[] memory stablecoinsBorrowables = new address[](3);
    stablecoinsBorrowables[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;
    stablecoinsBorrowables[1] = AaveV3PlasmaAssets.USDe_UNDERLYING;
    stablecoinsBorrowables[2] = AaveV3PlasmaAssets.GHO_UNDERLYING;

    assertEq(
      AaveV3Plasma.POOL.getEModeCategoryCollateralBitmap(stablecoins),
      _toBitmap(collaterals)
    );
    assertEq(
      AaveV3Plasma.POOL.getEModeCategoryBorrowableBitmap(stablecoins),
      _toBitmap(stablecoinsBorrowables)
    );

    uint8 usde = _findEModeCategoryId('sUSDe_PT_sUSDe_22OCT2026__USDe');
    _assertEModeCollateralConfig({
      id: usde,
      ltv: 90_35,
      liquidationThreshold: 92_35,
      liquidationBonus: 101_87
    });
    assertTrue(AaveV3Plasma.POOL.getIsEModeCategoryIsolated(usde));

    address[] memory usdeBorrowables = new address[](1);
    usdeBorrowables[0] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    assertEq(AaveV3Plasma.POOL.getEModeCategoryCollateralBitmap(usde), _toBitmap(collaterals));
    assertEq(AaveV3Plasma.POOL.getEModeCategoryBorrowableBitmap(usde), _toBitmap(usdeBorrowables));
  }

  function test_oracleConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address priceFeed = proposal.PT_sUSDE_22OCT2026_PRICE_FEED();
    assertEq(AaveV3Plasma.ORACLE.getSourceOfAsset(proposal.PT_sUSDE_22OCT2026()), priceFeed);
    assertGt(AaveV3Plasma.ORACLE.getAssetPrice(proposal.PT_sUSDE_22OCT2026()), 0);

    IPendlePriceCapAdapter adapter = IPendlePriceCapAdapter(priceFeed);

    assertEq(
      adapter.ASSET_TO_USD_AGGREGATOR(),
      AaveV3Plasma.ORACLE.getSourceOfAsset(AaveV3PlasmaAssets.USDe_UNDERLYING)
    );

    assertEq(adapter.discountRatePerYear(), 4.37e16);
    assertEq(adapter.MAX_DISCOUNT_RATE_PER_YEAR(), 12.27e16);
    // discount applied to the PT is bounded within [0, 100%)
    assertLt(adapter.getCurrentDiscount(), 1e18);
  }

  function test_reserveParameters() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    (
      uint256 decimals,
      uint256 ltv,
      uint256 liquidationThreshold,
      uint256 liquidationBonus,
      uint256 reserveFactor,
      ,
      bool borrowingEnabled,
      ,
      bool isActive,

    ) = AaveV3Plasma.AAVE_PROTOCOL_DATA_PROVIDER.getReserveConfigurationData(
        proposal.PT_sUSDE_22OCT2026()
      );

    assertEq(decimals, 18);
    assertEq(ltv, 0);
    assertEq(liquidationThreshold, 0);
    assertEq(liquidationBonus, 0);
    assertEq(reserveFactor, 4500);
    assertFalse(borrowingEnabled);
    assertTrue(isActive);

    (uint256 borrowCap, uint256 supplyCap) = AaveV3Plasma
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(proposal.PT_sUSDE_22OCT2026());
    assertEq(supplyCap, 150_000_000);
    assertEq(borrowCap, 1);

    assertFalse(
      AaveV3Plasma.AAVE_PROTOCOL_DATA_PROVIDER.getFlashLoanEnabled(proposal.PT_sUSDE_22OCT2026())
    );

    assertEq(
      AaveV3Plasma.AAVE_PROTOCOL_DATA_PROVIDER.getDebtCeiling(proposal.PT_sUSDE_22OCT2026()),
      0
    );
  }

  /// @dev supplies PT-sUSDe as collateral in the given e-mode and borrows `borrowAsset` against it
  function _supplyPTAndBorrowInEMode(
    string memory label,
    address borrowAsset,
    address borrowVToken
  ) internal {
    uint8 eModeId = _findEModeCategoryId(label);

    address user = makeAddr('user');
    uint256 supplyAmount = 100_000e18;
    deal(proposal.PT_sUSDE_22OCT2026(), user, supplyAmount);

    vm.startPrank(user);

    AaveV3Plasma.POOL.setUserEMode(eModeId);

    IERC20(proposal.PT_sUSDE_22OCT2026()).approve(address(AaveV3Plasma.POOL), supplyAmount);
    AaveV3Plasma.POOL.supply(proposal.PT_sUSDE_22OCT2026(), supplyAmount, user, 0);

    address aPT = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_sUSDE_22OCT2026());
    assertApproxEqAbs(IERC20(aPT).balanceOf(user), supplyAmount, 2);

    uint256 borrowAmount = 100e18;
    AaveV3Plasma.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    assertApproxEqAbs(IERC20(borrowVToken).balanceOf(user), borrowAmount, 2);

    // repay and withdraw
    IERC20(borrowAsset).approve(address(AaveV3Plasma.POOL), borrowAmount);
    AaveV3Plasma.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3Plasma.POOL.withdraw(proposal.PT_sUSDE_22OCT2026(), supplyAmount / 2, user);

    vm.stopPrank();
  }

  /// @dev asserts the (ltv, liquidationThreshold, liquidationBonus) of an e-mode category
  function _assertEModeCollateralConfig(
    uint8 id,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus
  ) internal view {
    DataTypes.CollateralConfig memory cfg = AaveV3Plasma.POOL.getEModeCategoryCollateralConfig(id);
    assertEq(cfg.ltv, ltv);
    assertEq(cfg.liquidationThreshold, liquidationThreshold);
    assertEq(cfg.liquidationBonus, liquidationBonus);
  }

  /// @dev builds the expected e-mode bitmap by setting the bit at each asset's reserve id
  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3Plasma.POOL.getReserveData(assets[i]).id;
    }
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3Plasma.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
        return i;
      }
    }
    revert('eMode category not found');
  }
}
