// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {CAPOUpdateBasePayload} from 'src/helpers/capo/CAPOUpdateBasePayload.sol';

/**
 * @title CAPO SnapshotRatio Update Across Aave V3
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854
 */
contract AaveV3Plasma_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 is CAPOUpdateBasePayload {
  uint104 public constant sUSDe_SNAPSHOT_RATIO = 1227017473582880624;
  uint48 public constant sUSDe_SNAPSHOT_TIMESTAMP = 1776095930;

  uint104 public constant weETH_SNAPSHOT_RATIO = 1092447295285287694;
  uint48 public constant weETH_SNAPSHOT_TIMESTAMP = 1776095953;

  function execute() external {
    _updateCapParameters(
      AaveV3PlasmaAssets.sUSDe_ORACLE,
      sUSDe_SNAPSHOT_RATIO,
      sUSDe_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3PlasmaAssets.weETH_ORACLE,
      weETH_SNAPSHOT_RATIO,
      weETH_SNAPSHOT_TIMESTAMP
    );
  }
}
