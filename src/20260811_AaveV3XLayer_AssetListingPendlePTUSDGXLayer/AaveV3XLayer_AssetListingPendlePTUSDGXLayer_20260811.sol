// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3XLayer, AaveV3XLayerAssets} from 'aave-address-book/AaveV3XLayer.sol';
import {AaveV3PayloadXLayer} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadXLayer.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

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
  uint256 public constant PT_USDG_29OCT2026_SEED_AMOUNT = 1e6;
  // TODO: replace with the PT-USDG linear discount rate oracle once deployed
  address public constant PT_USDG_29OCT2026_PRICE_FEED = 0x0000000000000000000000000000000000000001;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(PT_USDG_29OCT2026, PT_USDG_29OCT2026_SEED_AMOUNT, address(0));
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

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3XLayer.POOL), seedAmount);
    AaveV3XLayer.POOL.supply(asset, seedAmount, address(AaveV3XLayer.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3XLayer.POOL.getReserveAToken(asset);
      address vToken = AaveV3XLayer.POOL.getReserveVariableDebtToken(asset);
      IEmissionManager(AaveV3XLayer.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3XLayer.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
      IEmissionManager(AaveV3XLayer.EMISSION_MANAGER).setEmissionAdmin(vToken, lmAdmin);
    }
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_PTUSDGStablecoins = new address[](1);
    address[] memory borrowableAssets_PTUSDGStablecoins = new address[](3);

    collateralAssets_PTUSDGStablecoins[0] = PT_USDG_29OCT2026;
    borrowableAssets_PTUSDGStablecoins[0] = AaveV3XLayerAssets.USDT_UNDERLYING;
    borrowableAssets_PTUSDGStablecoins[1] = AaveV3XLayerAssets.USDG_UNDERLYING;
    borrowableAssets_PTUSDGStablecoins[2] = AaveV3XLayerAssets.GHO_UNDERLYING;

    // Indicative target per the forum post, subject to Risk Service Provider assessment.
    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 2_44,
      label: 'PT USDG Stablecoins',
      isolated: false,
      collaterals: collateralAssets_PTUSDGStablecoins,
      borrowables: borrowableAssets_PTUSDGStablecoins
    });

    return eModeCreations;
  }
}
