// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Freeze and set LTV to 0 for DPI, BAL, CRV, and SUSHI on Aave v3 Polygon, 2024.01.19
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x8a190af80cffafcbca70727c807ef86933b2e08b5212b447eafab976a9612e75
 * - Discussion: https://governance.aave.com/t/arfc-recommendation-to-freeze-and-set-ltv-to-0-on-low-cap-aave-v3-polygon-collateral-assets/16311
 */
contract AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130 is
  AaveV3PayloadPolygon
{
  function _postExecute() internal override {
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.BAL_UNDERLYING, true);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.CRV_UNDERLYING, true);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.DPI_UNDERLYING, true);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.SUSHI_UNDERLYING, true);
  }

  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](4);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.BAL_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.CRV_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[2] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.DPI_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[3] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.SUSHI_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
