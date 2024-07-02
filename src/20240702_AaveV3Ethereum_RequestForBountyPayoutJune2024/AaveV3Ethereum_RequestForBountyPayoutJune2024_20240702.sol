// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Request for Bounty Payout - June 2024
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-request-for-bounty-payout-june-2024/18119
 */
contract AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702 is IProposalGenericExecutor {
  // Used for both bounties and Immunefi fees
  struct Bounty {
    address asset;
    address recipient;
    uint256 amount;
  }

  function execute() external {
    Bounty[2] memory bounties = getBounties();
    for (uint256 i = 0; i < bounties.length; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(
        bounties[i].asset,
        bounties[i].recipient,
        bounties[i].amount
      );
    }
  }

  function getBounties() public pure returns (Bounty[2] memory) {
    return [
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0xeD656e42612177D9c747A16604E07D5C5B031d30,
        amount: 1_000e18
      }),
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18,
        amount: 100e18
      })
    ];
  }
}
