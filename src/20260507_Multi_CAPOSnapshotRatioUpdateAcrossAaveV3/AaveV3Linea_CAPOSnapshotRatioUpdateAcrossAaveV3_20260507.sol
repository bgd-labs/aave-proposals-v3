// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';
import {CAPOUpdateBasePayload} from 'src/helpers/capo/CAPOUpdateBasePayload.sol';

/**
 * @title CAPO SnapshotRatio Update Across Aave V3
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854
 */
contract AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 is CAPOUpdateBasePayload {
  uint104 public constant wstETH_SNAPSHOT_RATIO = 1231706743820320505;
  uint48 public constant wstETH_SNAPSHOT_TIMESTAMP = 1776040336;

  uint104 public constant ezETH_SNAPSHOT_RATIO = 1076090972297786741;
  uint48 public constant ezETH_SNAPSHOT_TIMESTAMP = 1776040248;

  uint104 public constant weETH_SNAPSHOT_RATIO = 1092447295285287694;
  uint48 public constant weETH_SNAPSHOT_TIMESTAMP = 1776040278;

  function execute() external {
    _updateCapParameters(
      AaveV3LineaAssets.wstETH_ORACLE,
      wstETH_SNAPSHOT_RATIO,
      wstETH_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3LineaAssets.ezETH_ORACLE,
      ezETH_SNAPSHOT_RATIO,
      ezETH_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3LineaAssets.weETH_ORACLE,
      weETH_SNAPSHOT_RATIO,
      weETH_SNAPSHOT_TIMESTAMP
    );
  }
}
