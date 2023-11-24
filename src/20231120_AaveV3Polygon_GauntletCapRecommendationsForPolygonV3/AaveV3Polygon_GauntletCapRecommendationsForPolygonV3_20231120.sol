// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Gauntlet Cap Recommendations for Polygon v3
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xcab97d0cf0f484f3604f790234ca26b559b6c38c0b33ed1f7821b3d3340c9354
 * - Discussion: https://governance.aave.com/t/arfc-gauntlet-cap-recommendations-for-polygon-v3-2023-11-03/15327
 */
contract AaveV3Polygon_GauntletCapRecommendationsForPolygonV3_20231120 is AaveV3PayloadPolygon {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](2);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.jEUR_UNDERLYING,
      supplyCap: 120_000,
      borrowCap: 100_000
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.agEUR_UNDERLYING,
      supplyCap: 300_000,
      borrowCap: 250_000
    });

    return capsUpdate;
  }
}
