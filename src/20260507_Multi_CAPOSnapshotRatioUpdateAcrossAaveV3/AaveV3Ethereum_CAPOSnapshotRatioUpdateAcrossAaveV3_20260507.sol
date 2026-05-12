// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CAPOUpdateBasePayload} from 'src/helpers/capo/CAPOUpdateBasePayload.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title CAPO SnapshotRatio Update Across Aave V3
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854
 */
contract AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 is CAPOUpdateBasePayload {
  uint104 public constant sUSDe_SNAPSHOT_RATIO = 1227131992751411096;
  uint48 public constant sUSDe_SNAPSHOT_TIMESTAMP = 1776098039;
  uint16 public constant sUSDe_MAX_YEARLY_RATIO_GROWTH_PERCENT = 11_17;

  uint104 public constant rETH_SNAPSHOT_RATIO = 1161297025018026367;
  uint48 public constant rETH_SNAPSHOT_TIMESTAMP = 1776100271;

  uint104 public constant weETH_SNAPSHOT_RATIO = 1092511275951548029;
  uint48 public constant weETH_SNAPSHOT_TIMESTAMP = 1776098051;

  uint104 public constant ETHx_SNAPSHOT_RATIO = 1086803171399918543;
  uint48 public constant ETHx_SNAPSHOT_TIMESTAMP = 1776097967;

  uint104 public constant osETH_SNAPSHOT_RATIO = 1069243791626177773;
  uint48 public constant osETH_SNAPSHOT_TIMESTAMP = 1776100271;

  uint104 public constant ezETH_SNAPSHOT_RATIO = 1076159265830748846;
  uint48 public constant ezETH_SNAPSHOT_TIMESTAMP = 1776100259;

  uint104 public constant cbETH_SNAPSHOT_RATIO = 1127672723490107311;
  uint48 public constant cbETH_SNAPSHOT_TIMESTAMP = 1776097967;

  function execute() external {
    _updateCapParameters(
      AaveV3EthereumAssets.sUSDe_ORACLE, // prime uses the same feed
      sUSDe_SNAPSHOT_RATIO,
      sUSDe_SNAPSHOT_TIMESTAMP,
      sUSDe_MAX_YEARLY_RATIO_GROWTH_PERCENT
    );

    _updateCapParameters(
      AaveV3EthereumAssets.rETH_ORACLE,
      rETH_SNAPSHOT_RATIO,
      rETH_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3EthereumAssets.weETH_ORACLE,
      weETH_SNAPSHOT_RATIO,
      weETH_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3EthereumAssets.ETHx_ORACLE,
      ETHx_SNAPSHOT_RATIO,
      ETHx_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3EthereumAssets.osETH_ORACLE,
      osETH_SNAPSHOT_RATIO,
      osETH_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3EthereumAssets.ezETH_ORACLE, // prime uses the same feed
      ezETH_SNAPSHOT_RATIO,
      ezETH_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3EthereumAssets.cbETH_ORACLE,
      cbETH_SNAPSHOT_RATIO,
      cbETH_SNAPSHOT_TIMESTAMP
    );
  }
}
