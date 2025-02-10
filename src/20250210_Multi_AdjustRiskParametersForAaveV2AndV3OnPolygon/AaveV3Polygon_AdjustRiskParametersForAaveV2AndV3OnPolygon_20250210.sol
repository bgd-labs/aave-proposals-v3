// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Adjust Risk Parameters for Aave V2 and V3 on Polygon
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x48cb2ca277c9cfa0855e8561878836eea182e45dea0e140c03786e533519c2dc
 * - Discussion: https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211
 */
contract AaveV3Polygon_AdjustRiskParametersForAaveV2AndV3OnPolygon_20250210 is
  AaveV3PayloadPolygon
{
  function _postExecute() internal override {
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.DAI_UNDERLYING, true);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.USDC_UNDERLYING, true);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.USDT_UNDERLYING, true);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.USDCn_UNDERLYING, true);
  }

  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](3);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3PolygonAssets.USDC_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 60_00
    });
    borrowUpdates[1] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3PolygonAssets.USDT_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 25_00
    });
    borrowUpdates[2] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3PolygonAssets.USDCn_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 20_00
    });

    return borrowUpdates;
  }
}
