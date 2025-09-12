// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Request for Bounty Payout - August 2025
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/bgd-request-for-bounty-payout-august-2025/23096
 */
contract AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911 is IProposalGenericExecutor {
  struct Bounty {
    address asset;
    address recipient;
    uint256 amount;
  }

  function execute() external {
    Bounty[3] memory bounties = getBounties();
    for (uint256 i = 0; i < bounties.length; i++) {
      AaveV3Ethereum.COLLECTOR.transfer(
        IERC20(bounties[i].asset),
        bounties[i].recipient,
        bounties[i].amount
      );
    }
  }

  function getBounties() public pure returns (Bounty[3] memory) {
    return [
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0xbD5895f2855C3d0B7f366Bd946D56c4D9Ef03a25,
        amount: 8_000e18
      }),
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0x2770cC972a7666C974B1b1269F4F31b97f99f898,
        amount: 5_000e18
      }),
      // Immunefi fee
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18,
        amount: 1_300e18
      })
    ];
  }
}
