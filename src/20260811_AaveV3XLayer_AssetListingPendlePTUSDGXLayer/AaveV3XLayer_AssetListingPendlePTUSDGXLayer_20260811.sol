// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3XLayer, AaveV3XLayerAssets} from 'aave-address-book/AaveV3XLayer.sol';
import {AaveV3PayloadXLayer} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadXLayer.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Asset Listing - Pendle PT-USDG X Layer
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-pt-usdg-x-layer/25464
 */
contract AaveV3XLayer_AssetListingPendlePTUSDGXLayer_20260811 is AaveV3PayloadXLayer {
  using SafeERC20 for IERC20;

  // https://www.oklink.com/xlayer/address/0x9a09a9E491DB3dd8Ada5B1B889991AC9Ad5fd362
  address public constant PT_USDG_29OCT2026 = 0x9a09a9E491DB3dd8Ada5B1B889991AC9Ad5fd362;
  uint256 public constant PT_USDG_29OCT2026_SEED_AMOUNT = 10e6;
  // https://www.oklink.com/x-layer/address/0x6052839E52ab454F164ee5668e5B523cF5A389Fc
  address public constant PT_USDG_29OCT2026_PRICE_FEED = 0x6052839E52ab454F164ee5668e5B523cF5A389Fc;

  function _postExecute() internal override {
    IERC20(PT_USDG_29OCT2026).forceApprove(
      address(AaveV3XLayer.POOL),
      PT_USDG_29OCT2026_SEED_AMOUNT
    );
    AaveV3XLayer.POOL.supply(
      PT_USDG_29OCT2026,
      PT_USDG_29OCT2026_SEED_AMOUNT,
      address(AaveV3XLayer.DUST_BIN),
      0
    );
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_USDG_29OCT2026,
      assetSymbol: 'PT_USDG_29OCT2026',
      priceFeed: PT_USDG_29OCT2026_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 35_000_000,
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

    address[] memory collateralAssets_PTUSDGStablecoins = new address[](1);
    address[] memory borrowableAssets_PTUSDGStablecoins = new address[](3);

    collateralAssets_PTUSDGStablecoins[0] = PT_USDG_29OCT2026;
    borrowableAssets_PTUSDGStablecoins[0] = AaveV3XLayerAssets.USDT_UNDERLYING;
    borrowableAssets_PTUSDGStablecoins[1] = AaveV3XLayerAssets.USDG_UNDERLYING;
    borrowableAssets_PTUSDGStablecoins[2] = AaveV3XLayerAssets.GHO_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 92_66,
      liqThreshold: 94_66,
      liqBonus: 2_34,
      label: 'PT_USDG__Stablecoins',
      isolated: true,
      collaterals: collateralAssets_PTUSDGStablecoins,
      borrowables: borrowableAssets_PTUSDGStablecoins
    });

    address[] memory collateralAssets_PTUSDGUSDG = new address[](1);
    address[] memory borrowableAssets_PTUSDGUSDG = new address[](1);

    collateralAssets_PTUSDGUSDG[0] = PT_USDG_29OCT2026;
    borrowableAssets_PTUSDGUSDG[0] = AaveV3XLayerAssets.USDG_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_59,
      liqThreshold: 95_59,
      liqBonus: 1_34,
      label: 'PT_USDG__USDG',
      isolated: true,
      collaterals: collateralAssets_PTUSDGUSDG,
      borrowables: borrowableAssets_PTUSDGUSDG
    });

    return eModeCreations;
  }
}
