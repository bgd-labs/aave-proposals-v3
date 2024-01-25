// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Request for Bounty Payout - January 2024
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/bgd-request-for-bounty-payout-january-2024/16378
 */
contract AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125 is IProposalGenericExecutor {
  // Used for both bounties and Immunefi fees
  struct Bounty {
    address asset;
    address recipient;
    uint256 amount;
  }

  function execute() external {
    Bounty[3] memory bounties = getBounties();
    for (uint256 i = 0; i < bounties.length; i++) {
      AaveV2Ethereum.COLLECTOR.transfer(
        bounties[i].asset,
        bounties[i].recipient,
        bounties[i].amount
      );
    }
  }

  function getBounties() public pure returns (Bounty[3] memory) {
    return [
      Bounty({
        asset: AaveV2EthereumAssets.USDC_A_TOKEN,
        recipient: 0x8689e84af34A18Bc461928aa554a71C649beED89,
        amount: 5_000e6
      }),
      Bounty({
        asset: AaveV2EthereumAssets.USDC_A_TOKEN,
        recipient: 0xD122c282499Cb6A76197db2D6ba5170D81C4895f,
        amount: 10_000e6
      }),
      Bounty({
        asset: AaveV2EthereumAssets.USDC_A_TOKEN,
        recipient: 0x2BC5fFc5De1a83a9e4cDDfA138bAEd516D70414b,
        amount: 1_000e6
      })
    ];
  }
}
