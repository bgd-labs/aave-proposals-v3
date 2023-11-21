// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Gauntlet recommendation to lower stMATIC, MaticX non-emode LT, pt 2
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc59f0e1bd1463285d1fca9c3771d92dc227915615e475b84e6e4033f281ff079
 * - Discussion: https://governance.aave.com/t/arfc-gauntlet-recommendation-to-lower-stmatic-maticx-non-emode-lt-pt-2/15314
 */
contract AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117 is
  AaveV3PayloadPolygon
{
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
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 56_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 58_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
