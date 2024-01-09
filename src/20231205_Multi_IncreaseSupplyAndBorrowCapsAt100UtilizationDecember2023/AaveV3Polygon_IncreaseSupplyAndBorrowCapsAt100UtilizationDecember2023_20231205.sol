// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Increase Supply and Borrow Caps at 100% Utilization - December 2023
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: No snapshot for direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-increase-supply-and-borrow-caps-at-100-utilization-december-2023/15754
 */
contract AaveV3Polygon_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205 is
  AaveV3PayloadPolygon
{
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.wstETH_UNDERLYING,
      supplyCap: 4_370,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
