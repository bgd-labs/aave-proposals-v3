// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Continuous Security Proposal Aave <> Certora
 * @author @Shelly - Certora, Powered by ACI Skywards
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x3f379dfb0bebc149756997aeccb5e5b916c63e84c1236c0825d09211603a002d
 * - Discussion: https://governance.aave.com/t/arfc-continuous-security-proposal-aave-certora/15732
 */
contract AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart1_20231212 is
  IProposalGenericExecutor
{
  address public constant CERTORA_TREASURY = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;
  uint256 public constant GHO_STREAM_AMOUNT = 1_000_000 ether;
  uint256 public constant STREAM_DURATION = 270 days;
  uint256 public constant ACTUAL_AMOUNT_GHO =
    (GHO_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    // create GHO stream for Certora
    AaveV3Ethereum.COLLECTOR.createStream(
      CERTORA_TREASURY,
      ACTUAL_AMOUNT_GHO,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
