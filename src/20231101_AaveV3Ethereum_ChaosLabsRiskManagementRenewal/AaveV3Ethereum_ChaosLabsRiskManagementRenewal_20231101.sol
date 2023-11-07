// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Chaos Labs Risk Management Renewal
 * @author Chaos Labs (@yonikesel)
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0x6fc4b8ece3d4ac789e043d6aace9ffa77a886a7ea4e0bfe4a55b7a8cdada065e
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-aave-risk-management-renewal/15234
 */
contract AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101 is IProposalGenericExecutor {
  address public constant CHAOS_LABS_TREASURY = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;
  uint256 public constant STREAM_AMOUNT_GHO = 800_000 ether;
  uint256 public constant STREAM_AMOUNT_AUSDT = 800_000e6;
  uint256 public constant STREAM_DURATION = 365 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (STREAM_AMOUNT_GHO / STREAM_DURATION) * STREAM_DURATION;
  uint256 public constant ACTUAL_STREAM_AMOUNT_AUSDT =
    (STREAM_AMOUNT_AUSDT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.createStream(
      CHAOS_LABS_TREASURY,
      ACTUAL_STREAM_AMOUNT_GHO,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    AaveV3Ethereum.COLLECTOR.createStream(
      CHAOS_LABS_TREASURY,
      ACTUAL_STREAM_AMOUNT_AUSDT,
      AaveV2EthereumAssets.USDT_A_TOKEN,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
