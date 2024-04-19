// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Chaos Labs Engagement Amendment
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x34b6cf5bc9c8a0525c5b32d4ce2ca2ccfce39d15bd0aba5cab46a4e9e78f3ea8
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-engagement-amendment/17324
 */
contract AaveV3Ethereum_ChaosLabsEngagementAmendment_20240415 is IProposalGenericExecutor {
  address public constant CHAOS_LABS_TREASURY = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;
  uint256 public constant STREAM_AMOUNT_GHO = 400_000 ether;
  uint256 public constant STREAM_END = 1731405179;

  function execute() external {
    uint256 duration = STREAM_END - block.timestamp;
    uint256 exactAmount = (STREAM_AMOUNT_GHO / duration) * duration;

    AaveV3Ethereum.COLLECTOR.createStream(
      CHAOS_LABS_TREASURY,
      exactAmount,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      STREAM_END
    );
  }
}
