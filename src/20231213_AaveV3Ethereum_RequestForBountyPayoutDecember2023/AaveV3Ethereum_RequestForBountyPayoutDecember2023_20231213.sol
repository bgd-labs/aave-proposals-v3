// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Request for Bounty Payout - December 2023
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/bgd-request-for-bounty-payout-december-2023/15826
 */
contract AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213 is IProposalGenericExecutor {
  // Used for both bounties and Immunefi fees
  struct Bounty {
    address asset;
    address recipient;
    uint256 amount;
  }

  function execute() external {
    Bounty[4] memory bounties = getBounties();
    for (uint256 i = 0; i < bounties.length; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(
        bounties[i].asset,
        bounties[i].recipient,
        bounties[i].amount
      );
    }
  }

  function getBounties() public pure returns (Bounty[4] memory) {
    return [
      Bounty({
        asset: AaveV3EthereumAssets.DAI_A_TOKEN,
        recipient: 0x2af2144429a7eAe5fB3999B2059f246ffab6c90A,
        amount: 1_000 ether
      }),
      Bounty({
        asset: AaveV3EthereumAssets.DAI_A_TOKEN,
        recipient: 0xEb8b275F05423566C95AbCCdD92d860B758cF08a,
        amount: 10_000 ether
      }),
      Bounty({
        asset: AaveV3EthereumAssets.DAI_A_TOKEN,
        recipient: 0x6248E2481c3d80C05F49a185D9BAEE515f0E7F2C,
        amount: 10_000 ether
      }),
      Bounty({
        asset: AaveV3EthereumAssets.DAI_A_TOKEN,
        recipient: 0x2BC5fFc5De1a83a9e4cDDfA138bAEd516D70414b,
        amount: 2_600 ether
      })
    ];
  }
}
