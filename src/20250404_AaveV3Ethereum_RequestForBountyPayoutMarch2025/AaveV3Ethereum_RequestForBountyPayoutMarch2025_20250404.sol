// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Request for Bounty Payout - March 2025
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/bgd-request-for-bounty-payout-march-2025/21656
 */
contract AaveV3Ethereum_RequestForBountyPayoutMarch2025_20250404 is IProposalGenericExecutor {
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
        recipient: 0x62566e81CcDFF9407E840d5ec3056e7354D44012,
        amount: 20_000e18
      }),
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0xF5BED21BD285CBe352737F686766cCC19BeE7acC,
        amount: 1_000e18
      }),
      // Immunefi fee
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18,
        amount: 2_100e18
      })
    ];
  }
}
