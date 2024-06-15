// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title V4 AL Service Provider Proposal
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xbf901f4be94a4661dce8217b3b037a8607ea8953cbe32e7dbde6a882819d64b3
 * - Discussion: https://governance.aave.com/t/temp-check-service-provider-proposal/17866
 */
contract AaveV3Ethereum_V4ALServiceProviderProposal_20240614 is IProposalGenericExecutor {
  // TODO: Find the appropriate recipient address for AAVE Labs
  address public constant AAVE_LABS = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  // 3 million GHO upfront
  uint256 public constant GHO_UPFRONT_AMOUNT = 3_000_000 ether;

  // 9 million GHO streamed over the year
  uint256 public constant GHO_STREAM_AMOUNT = 9_000_000 ether;
  uint256 public constant GHO_STREAM_DURATION = 365 days;

  uint256 public constant ACTUAL_STREAM =
    (GHO_STREAM_AMOUNT / GHO_STREAM_DURATION) * GHO_STREAM_DURATION;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.createStream(
      AAVE_LABS,
      ACTUAL_STREAM,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + GHO_STREAM_DURATION
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AAVE_LABS,
      GHO_UPFRONT_AMOUNT
    );
  }
}
