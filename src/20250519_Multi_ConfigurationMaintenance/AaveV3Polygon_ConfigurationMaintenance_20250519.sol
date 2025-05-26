// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets, AaveV3PolygonEModes} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Configuration maintenance
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/86
 */
contract AaveV3Polygon_ConfigurationMaintenance_20250519 is AaveV3PayloadPolygon {
  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](1);
    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });
    return borrowUpdates;
  }

  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](3);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.MATIC_CORRELATED,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.MATIC_CORRELATED,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3PolygonAssets.wstETH_UNDERLYING,
      eModeCategory: AaveV3PolygonEModes.ETH_CORRELATED,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });

    return assetEModeUpdates;
  }
}
