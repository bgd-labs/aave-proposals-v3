// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title test
 * @author test
 * - Snapshot: test
 * - Discussion: test
 */
contract AaveV3Polygon_Test_20231115 is AaveV3PayloadPolygon {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.DAI_UNDERLYING,
      ltv: 99_20,
      liqThreshold: 2_03,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: 100_000,
      liqProtocolFee: 21_00
    });

    return collateralUpdate;
  }
}
