// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard PT-sUSDe-22OCT2026 to Aave v3 Plasma
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-pt-susde-22oct2026-to-aave-v3-plasma/25129
 */
contract AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615 is AaveV3PayloadPlasma {
  using SafeERC20 for IERC20;

  // https://plasmascan.to/address/0xf7fB83435F455Bd970F2D9f943f4eECE1941b3e9
  address public constant PT_sUSDE_22OCT2026 = 0xf7fB83435F455Bd970F2D9f943f4eECE1941b3e9;
  uint256 public constant PT_sUSDE_22OCT2026_SEED_AMOUNT = 1e18;
  // https://plasmascan.to/address/0x9c823f4e19Ef68347810a9C139619273b8282b7e
  address public constant PT_sUSDE_22OCT2026_PRICE_FEED =
    0x9c823f4e19Ef68347810a9C139619273b8282b7e;

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_sUSDE_22OCT2026,
      assetSymbol: 'PT_sUSDE_22OCT2026',
      priceFeed: PT_sUSDE_22OCT2026_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 45_00,
      supplyCap: 150_000_000,
      borrowCap: 1,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](2);

    address[] memory collateralAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins = new address[](2);
    address[] memory borrowableAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins = new address[](3);

    collateralAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins[0] = AaveV3PlasmaAssets.sUSDe_UNDERLYING;
    collateralAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins[1] = PT_sUSDE_22OCT2026;
    borrowableAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;
    borrowableAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins[1] = AaveV3PlasmaAssets.USDe_UNDERLYING;
    borrowableAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins[2] = AaveV3PlasmaAssets.GHO_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_71,
      liqThreshold: 89_71,
      liqBonus: 4_87,
      label: 'sUSDe_PT_sUSDe_22OCT2026__Stablecoins',
      isolated: true,
      collaterals: collateralAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins,
      borrowables: borrowableAssets_SUSDe_PT_sUSDe_22OCT2026__Stablecoins
    });

    address[] memory collateralAssets_SUSDe_PT_sUSDe_22OCT2026__USDe = new address[](2);
    address[] memory borrowableAssets_SUSDe_PT_sUSDe_22OCT2026__USDe = new address[](1);

    collateralAssets_SUSDe_PT_sUSDe_22OCT2026__USDe[0] = AaveV3PlasmaAssets.sUSDe_UNDERLYING;
    collateralAssets_SUSDe_PT_sUSDe_22OCT2026__USDe[1] = PT_sUSDE_22OCT2026;
    borrowableAssets_SUSDe_PT_sUSDe_22OCT2026__USDe[0] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_35,
      liqThreshold: 92_35,
      liqBonus: 1_87,
      label: 'sUSDe_PT_sUSDe_22OCT2026__USDe',
      isolated: true,
      collaterals: collateralAssets_SUSDe_PT_sUSDe_22OCT2026__USDe,
      borrowables: borrowableAssets_SUSDe_PT_sUSDe_22OCT2026__USDe
    });

    return eModeCreations;
  }

  function _postExecute() internal override {
    IERC20(PT_sUSDE_22OCT2026).forceApprove(
      address(AaveV3Plasma.POOL),
      PT_sUSDE_22OCT2026_SEED_AMOUNT
    );
    AaveV3Plasma.POOL.supply(
      PT_sUSDE_22OCT2026,
      PT_sUSDE_22OCT2026_SEED_AMOUNT,
      address(AaveV3Plasma.DUST_BIN),
      0
    );
  }
}
