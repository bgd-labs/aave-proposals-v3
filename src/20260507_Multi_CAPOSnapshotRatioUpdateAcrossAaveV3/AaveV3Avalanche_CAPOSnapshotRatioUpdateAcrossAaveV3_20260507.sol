// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {CAPOUpdateBasePayload} from 'src/helpers/capo/CAPOUpdateBasePayload.sol';
/**
 * @title CAPO SnapshotRatio Update Across Aave V3
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854
 */
contract AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 is CAPOUpdateBasePayload {
  uint104 public constant sAVAX_SNAPSHOT_RATIO = 1258004893989529449;
  uint48 public constant sAVAX_SNAPSHOT_TIMESTAMP = 1776080367;

  uint104 public constant sUSDe_SNAPSHOT_RATIO = 1227006247957361173;
  uint48 public constant sUSDe_SNAPSHOT_TIMESTAMP = 1776080378;

  function execute() external {
    _updateCapParameters(
      AaveV3AvalancheAssets.sAVAX_ORACLE,
      sAVAX_SNAPSHOT_RATIO,
      sAVAX_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3AvalancheAssets.sUSDe_ORACLE,
      sUSDe_SNAPSHOT_RATIO,
      sUSDe_SNAPSHOT_TIMESTAMP
    );
  }
}
