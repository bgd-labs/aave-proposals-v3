// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Request for Bounty Payout - Feb 2025
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/bgd-request-for-bounty-payout-january-2025/20947
 */
contract AaveV3Ethereum_RequestForBountyPayoutFeb2025_20250203 is IProposalGenericExecutor {
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

  // TODO
  function getBounties() public pure returns (Bounty[4] memory) {
    return [
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0x75a1151D38885461CfA27f8f66927D4fCAD25b55,
        amount: 10_000e18
      }),
      // Receiving one of 10'000 plus another of 40'000
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0x0Dca0FDC170baA4CA9c1dCd37Ffe01f97bCfD504,
        amount: 50_000e18
      }),
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0x299e532172cce5230192d413D47C6739DB9338fE,
        amount: 1_000e18
      }),
      // Immunefi fee
      Bounty({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        recipient: 0x7119f398b6C06095c6E8964C1f58e7C1BAa79E18,
        amount: 6_100e18
      })
    ];
  }
}
