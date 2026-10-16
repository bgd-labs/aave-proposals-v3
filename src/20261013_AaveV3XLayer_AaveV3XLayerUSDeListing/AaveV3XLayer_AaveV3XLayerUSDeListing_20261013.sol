// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3XLayer, AaveV3XLayerAssets, AaveV3XLayerEModes} from 'aave-address-book/AaveV3XLayer.sol';
import {AaveV3PayloadXLayer} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadXLayer.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Onboard USDe to Aave V3 X Layer
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688
 */
contract AaveV3XLayer_AaveV3XLayerUSDeListing_20261013 is AaveV3PayloadXLayer {
  using SafeERC20 for IERC20;

  // https://www.oklink.com/xlayer/address/0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34
  address public constant USDe = 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34;
  uint256 public constant USDe_SEED_AMOUNT = 100e18;
  address public constant USDe_PRICE_FEED = AaveV3XLayerAssets.USDT_ORACLE;

  function _postExecute() internal override {
    IERC20(USDe).forceApprove(address(AaveV3XLayer.POOL), USDe_SEED_AMOUNT);
    AaveV3XLayer.POOL.supply(USDe, USDe_SEED_AMOUNT, address(AaveV3XLayer.DUST_BIN), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDe,
      assetSymbol: 'USDe',
      priceFeed: USDe_PRICE_FEED,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 25_00,
      supplyCap: 100_000_000,
      borrowCap: 20_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 85_00,
        baseVariableBorrowRate: 6_30,
        variableRateSlope1: 25,
        variableRateSlope2: 45_00
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
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_USDe__Stablecoins = new address[](1);
    address[] memory borrowableAssets_USDe__Stablecoins = new address[](4);

    collateralAssets_USDe__Stablecoins[0] = USDe;
    borrowableAssets_USDe__Stablecoins[0] = AaveV3XLayerAssets.USDT_UNDERLYING;
    borrowableAssets_USDe__Stablecoins[1] = AaveV3XLayerAssets.USDG_UNDERLYING;
    borrowableAssets_USDe__Stablecoins[2] = AaveV3XLayerAssets.USDC_UNDERLYING;
    borrowableAssets_USDe__Stablecoins[3] = AaveV3XLayerAssets.GHO_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 91_00,
      liqThreshold: 93_00,
      liqBonus: 2_00,
      label: 'USDe__Stablecoins',
      isolated: false,
      collaterals: collateralAssets_USDe__Stablecoins,
      borrowables: borrowableAssets_USDe__Stablecoins
    });

    return eModeCreations;
  }

  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](4);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: USDe,
      eModeCategory: AaveV3XLayerEModes.xBTC__USDT_USDG_GHO_USDC,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.KEEP_CURRENT,
      ltvzero: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: USDe,
      eModeCategory: AaveV3XLayerEModes.xETH__USDT_USDG_GHO_USDC,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.KEEP_CURRENT,
      ltvzero: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: USDe,
      eModeCategory: AaveV3XLayerEModes.xSOL__USDT_USDG_GHO_USDC,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.KEEP_CURRENT,
      ltvzero: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: USDe,
      eModeCategory: AaveV3XLayerEModes.WOKB__USDT_USDG_GHO_USDC,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.KEEP_CURRENT,
      ltvzero: EngineFlags.KEEP_CURRENT
    });

    return assetEModeUpdates;
  }
}
