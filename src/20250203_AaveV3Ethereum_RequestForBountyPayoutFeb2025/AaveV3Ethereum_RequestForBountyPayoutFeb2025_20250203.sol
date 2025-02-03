// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Request for Bounty Payout - Feb 2025
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: TODO
 */
contract AaveV3Ethereum_RequestForBountyPayoutFeb2025_20250203 is IProposalGenericExecutor {
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

  // TODO
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
