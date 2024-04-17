// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Chaos Labs Engagement Amendment
 * @author Chaos Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-engagement-amendment/17324
 */
contract AaveV3Ethereum_ChaosLabsEngagementAmendment_20240415 is IProposalGenericExecutor {
  address public constant CHAOS_LABS_TREASURY = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;
  uint256 public constant STREAM_AMOUNT_GHO = 400_000 ether;
  uint256 public constant STREAM_DURATION = 200 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (STREAM_AMOUNT_GHO / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.createStream(
      CHAOS_LABS_TREASURY,
      ACTUAL_STREAM_AMOUNT_GHO,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
