// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title MaticX Supply Cap Increase in Polygon V3
 * @author Aave Chan Initiative (ACI)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x73b2f1d14eb6710deabe84639ea8b06929738ef1973fee21c26945d17bf57a5b
 * - Discussion: https://governance.aave.com/t/arfc-maticx-supply-cap-increase-in-polygon-v3/16449
 */
contract AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3_20240206 is AaveV3PayloadPolygon {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      supplyCap: 75_000_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
