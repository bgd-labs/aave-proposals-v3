// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MantleAssets} from 'aave-address-book/AaveV3Mantle.sol';
import {CAPOUpdateBasePayload} from 'src/helpers/capo/CAPOUpdateBasePayload.sol';

/**
 * @title CAPO SnapshotRatio Update Across Aave V3
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854
 */
contract AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 is CAPOUpdateBasePayload {
  uint104 public constant sUSDe_SNAPSHOT_RATIO = 1227013966208500235;
  uint48 public constant sUSDe_SNAPSHOT_TIMESTAMP = 1776095860;

  function execute() external {
    _updateCapParameters(
      AaveV3MantleAssets.sUSDe_ORACLE,
      sUSDe_SNAPSHOT_RATIO,
      sUSDe_SNAPSHOT_TIMESTAMP
    );
  }
}
