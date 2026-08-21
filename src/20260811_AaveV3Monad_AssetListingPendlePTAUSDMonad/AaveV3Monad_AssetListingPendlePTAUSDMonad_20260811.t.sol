// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Monad, AaveV3MonadAssets} from 'aave-address-book/AaveV3Monad.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig, ExpectedListing} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811} from './AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811.sol';
import {IPendlePriceCapAdapter} from '../interfaces/IPendlePriceCapAdapter.sol';

/**
 * @dev Test for AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260811_AaveV3Monad_AssetListingPendlePTAUSDMonad/AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811.t.sol -vv
 */
contract AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811_Test is ProtocolV3TestBase {
  AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('monad'), 97672700);
    proposal = new AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811',
      AaveV3Monad.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3Monad.POOL, address(proposal), updatedAssets);
  }

  function test_dustBinHasPT_AUSD_8OCT2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.PT_AUSD_8OCT2026());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.PT_AUSD_8OCT2026_SEED_AMOUNT(),
      'dust bin should hold at least the seeded aPT-AUSD amount'
    );
  }

  function test_priceFeedReturnsSanePrice() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      AaveV3Monad.ORACLE.getSourceOfAsset(proposal.PT_AUSD_8OCT2026()),
      proposal.PT_AUSD_8OCT2026_PRICE_FEED(),
      'PT-AUSD should be priced by the configured linear discount oracle'
    );
    uint256 price = AaveV3Monad.ORACLE.getAssetPrice(proposal.PT_AUSD_8OCT2026());
    assertGt(price, 0.9e8, 'PT-AUSD price should be within a sane discount band');
    assertLt(price, 1e8, 'PT-AUSD should price below par (1 USD) before maturity');

    IPendlePriceCapAdapter adapter = IPendlePriceCapAdapter(proposal.PT_AUSD_8OCT2026_PRICE_FEED());
    assertEq(
      adapter.discountRatePerYear(),
      0.06661e18,
      'initial discount rate should be 6.661% per LlamaRisk'
    );
    assertEq(
      adapter.MAX_DISCOUNT_RATE_PER_YEAR(),
      0.08829e18,
      'max discount rate should be 8.829% per LlamaRisk'
    );
    assertEq(adapter.MATURITY(), 1791417600, 'maturity should be 8 October 2026 UTC');
    assertEq(
      adapter.PENDLE_PRINCIPAL_TOKEN(),
      proposal.PT_AUSD_8OCT2026(),
      'oracle should price the listed PT'
    );
    assertEq(
      adapter.ASSET_TO_USD_AGGREGATOR(),
      AaveV3MonadAssets.AUSD_ORACLE,
      'underlying aggregator should be the Capped AUSD/USD feed'
    );
  }

  function _expectedListings() internal pure override returns (ExpectedListing[] memory listings) {
    listings = new ExpectedListing[](1);

    listings[0] = ExpectedListing({
      listing: IAaveV3ConfigEngine.Listing({
        asset: 0x9FC74f8Ed616B5BaF52a170caa97d6d3898602d1,
        assetSymbol: 'PT-AUSD-8OCT2026',
        priceFeed: 0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127,
        enabledToBorrow: EngineFlags.DISABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 0,
        liqThreshold: 0,
        liqBonus: 0,
        reserveFactor: 20_00,
        supplyCap: 20_000_000,
        borrowCap: 1,
        liqProtocolFee: 10_00,
        rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
          optimalUsageRatio: 45_00,
          baseVariableBorrowRate: 0,
          variableRateSlope1: 10_00,
          variableRateSlope2: 300_00
        })
      }),
      decimals: 6
    });
  }

  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint8 eMode_PTAgoraStablecoins = _findEModeCategoryId('PT_Agora__Stablecoins');
    _assertEModeCollateralConfig({
      id: eMode_PTAgoraStablecoins,
      ltv: 93_00,
      liquidationThreshold: 95_00,
      liquidationBonus: 100_00 + 2_44,
      isolated: true
    });

    address[] memory collaterals_PTAgoraStablecoins = new address[](1);
    collaterals_PTAgoraStablecoins[0] = proposal.PT_AUSD_8OCT2026();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_PTAgoraStablecoins),
      _toBitmap(collaterals_PTAgoraStablecoins),
      'eMode collateral bitmap should contain exactly PT-AUSD'
    );

    address[] memory borrowables_PTAgoraStablecoins = new address[](4);
    borrowables_PTAgoraStablecoins[0] = AaveV3MonadAssets.USDT0_UNDERLYING;
    borrowables_PTAgoraStablecoins[1] = AaveV3MonadAssets.USDC_UNDERLYING;
    borrowables_PTAgoraStablecoins[2] = AaveV3MonadAssets.GHO_UNDERLYING;
    borrowables_PTAgoraStablecoins[3] = AaveV3MonadAssets.USDe_UNDERLYING;
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_PTAgoraStablecoins),
      _toBitmap(borrowables_PTAgoraStablecoins),
      'eMode borrowable bitmap should contain exactly USDT0, USDC, GHO and USDe'
    );
  }

  function test_eMode_PTAgoraStablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode(
      'PT_Agora__Stablecoins',
      proposal.PT_AUSD_8OCT2026(),
      AaveV3MonadAssets.USDT0_UNDERLYING
    );
  }

  function test_PT_AUSD_8OCT2026BorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.PT_AUSD_8OCT2026()).decimals();
    deal(proposal.PT_AUSD_8OCT2026(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.PT_AUSD_8OCT2026()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.PT_AUSD_8OCT2026(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    vm.expectRevert(Errors.LtvValidationFailed.selector);
    AaveV3Monad.POOL.borrow(AaveV3MonadAssets.USDT0_UNDERLYING, 1, 2, 0, user);

    vm.stopPrank();
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3Monad.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
        return i;
      }
    }
    revert('eMode category not found');
  }

  function _assertEModeCollateralConfig(
    uint8 id,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus,
    bool isolated
  ) internal view {
    DataTypes.CollateralConfig memory cfg = AaveV3Monad.POOL.getEModeCategoryCollateralConfig(id);
    assertEq(cfg.ltv, ltv, 'unexpected eMode ltv');
    assertEq(
      cfg.liquidationThreshold,
      liquidationThreshold,
      'unexpected eMode liquidation threshold'
    );
    assertEq(cfg.liquidationBonus, liquidationBonus, 'unexpected eMode liquidation bonus');
    assertEq(
      AaveV3Monad.POOL.getIsEModeCategoryIsolated(id),
      isolated,
      'unexpected eMode isolation flag'
    );
  }

  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3Monad.POOL.getReserveData(assets[i]).id;
    }
  }

  function _supplyAndBorrowInEMode(
    string memory label,
    address collateral,
    address borrowAsset
  ) internal {
    uint8 eModeId = _findEModeCategoryId(label);

    address user = makeAddr('eModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(collateral).decimals();
    deal(collateral, user, supplyAmount);

    vm.startPrank(user);

    AaveV3Monad.POOL.setUserEMode(eModeId);

    IERC20(collateral).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(collateral, supplyAmount, user, 0);

    uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
    AaveV3Monad.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    address vToken = AaveV3Monad.POOL.getReserveVariableDebtToken(borrowAsset);
    assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 1, 'borrowed amount mismatch');

    IERC20(borrowAsset).approve(address(AaveV3Monad.POOL), borrowAmount);
    AaveV3Monad.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3Monad.POOL.withdraw(collateral, supplyAmount / 2, user);

    vm.stopPrank();
  }
}
