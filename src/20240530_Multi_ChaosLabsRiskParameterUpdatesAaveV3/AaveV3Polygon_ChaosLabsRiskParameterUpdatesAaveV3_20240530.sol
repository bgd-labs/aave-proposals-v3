// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Chaos Labs Risk Parameter Updates AaveV3
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9674191acdb3cae244e010069df7637d6b7b3e30849f91570f0349323c5330d9
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-05-24-2024/17788
 */
contract AaveV3Polygon_ChaosLabsRiskParameterUpdatesAaveV3_20240530 is AaveV3PayloadPolygon {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](2);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
      ltv: 48_00,
      liqThreshold: 58_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      ltv: 50_00,
      liqThreshold: 60_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
