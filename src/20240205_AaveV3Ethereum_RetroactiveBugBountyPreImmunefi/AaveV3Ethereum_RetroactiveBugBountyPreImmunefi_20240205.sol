// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Retroactive Bug Bounty Pre-Immunefi
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb707cff629af03eeaa44bbbb7e38def2907a53791eb16d472dac1d45fb5ec26b
 * - Discussion: https://governance.aave.com/t/bgd-retroactive-bug-bounties-proposal-pre-immunefi/15989
 */
contract AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205 is IProposalGenericExecutor {
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
        recipient: 0xFa760444A229e78A50Ca9b3779f4ce4CcE10E170,
        amount: 65_000e6
      }),
      Bounty({
        asset: AaveV2EthereumAssets.USDC_A_TOKEN,
        recipient: 0x7dF98A6e1895fd247aD4e75B8EDa59889fa7310b,
        amount: 15_000e6
      }),
      Bounty({
        asset: AaveV2EthereumAssets.USDC_A_TOKEN,
        recipient: 0x2BC5fFc5De1a83a9e4cDDfA138bAEd516D70414b,
        amount: 6_500e6
      })
    ];
  }
}
