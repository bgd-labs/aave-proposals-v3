// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets, AaveV3PolygonEModes} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Adjust Aave Polygon V3 Risk Parameters
 * @author ACI
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211/60
 */
contract AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228 is AaveV3PayloadPolygon {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](2);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.USDT_UNDERLYING,
      ltv: 70_00,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.USDCn_UNDERLYING,
      ltv: 70_00,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      ltv: 91_25,
      liqThreshold: 94_25,
      liqBonus: EngineFlags.KEEP_CURRENT,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    return eModeUpdates;
  }
  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](8);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.DAI_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.USDC_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.USDT_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.EURS_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[4] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.jEUR_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[5] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.EURA_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[6] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.miMATIC_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[7] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.USDCn_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.STABLECOINS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });

    return assetEModeUpdates;
  }
}
