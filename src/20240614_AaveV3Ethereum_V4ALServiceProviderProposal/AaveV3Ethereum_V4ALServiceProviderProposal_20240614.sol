// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title V4 AL Service Provider Proposal
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x70dfd865b78c4c391e2b0729b907d152e6e8a0da683416d617d8f84782036349
 * - Discussion: https://governance.aave.com/t/arfc-al-service-provider-proposal/17974
 */
contract AaveV3Ethereum_V4ALServiceProviderProposal_20240614 is IProposalGenericExecutor {
  address public constant AAVE_LABS = 0x1c037b3C22240048807cC9d7111be5d455F640bd;

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
