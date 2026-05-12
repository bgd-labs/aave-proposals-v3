// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {CAPOUpdateBasePayload} from 'src/helpers/capo/CAPOUpdateBasePayload.sol';

/**
 * @title CAPO SnapshotRatio Update Across Aave V3
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854
 */
contract AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 is CAPOUpdateBasePayload {
  uint104 public constant MaticX_SNAPSHOT_RATIO = 1184553336304744130;
  uint48 public constant MaticX_SNAPSHOT_TIMESTAMP = 1776095251;

  uint104 public constant wstETH_SNAPSHOT_RATIO = 1231787423404290591;
  uint48 public constant wstETH_SNAPSHOT_TIMESTAMP = 1776095275;

  function execute() external {
    _updateCapParameters(
      AaveV3PolygonAssets.MaticX_ORACLE,
      MaticX_SNAPSHOT_RATIO,
      MaticX_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3PolygonAssets.wstETH_ORACLE,
      wstETH_SNAPSHOT_RATIO,
      wstETH_SNAPSHOT_TIMESTAMP
    );
  }
}
