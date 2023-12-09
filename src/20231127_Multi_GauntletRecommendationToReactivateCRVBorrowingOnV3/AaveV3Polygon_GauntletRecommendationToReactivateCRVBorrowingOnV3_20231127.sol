// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Gauntlet recommendation to reactivate CRV borrowing on v3
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2db7ffd336637173a5c58f6bbb3609c17bba1b16740d8b3b0ea23a694f4c7b52
 * - Discussion: https://governance.aave.com/t/arfc-gauntlet-recommendation-to-re-enable-crv-borrowing-on-v3-ethereum-polygon/15513
 */
contract AaveV3Polygon_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127 is
  AaveV3PayloadPolygon
{
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.CRV_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 300_000
    });

    return capsUpdate;
  }

  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3PolygonAssets.CRV_UNDERLYING,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 35_00
    });

    return borrowUpdates;
  }
}
