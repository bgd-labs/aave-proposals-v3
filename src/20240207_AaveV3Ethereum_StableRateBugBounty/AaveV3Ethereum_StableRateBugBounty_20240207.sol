// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Stable Rate Bug Bounty
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473
 */
contract AaveV3Ethereum_StableRateBugBounty_20240207 is IProposalGenericExecutor {
  address public constant WHITEHAT_RECIPIENT = 0x501eE2A368f1E58C736dd7cE3b494B33c3158c68;
  address public constant IMMUNEFI_RECIPIENT = 0x2BC5fFc5De1a83a9e4cDDfA138bAEd516D70414b;

  // Considering the 30 day avg price of 1 AAVE: $89.56 recommended by financial SPs
  // https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473/8
  uint256 public constant AAVE_WHITEHAT_AMOUNT = 5_583 ether;
  uint256 public constant USDT_WHITEHAT_AMOUNT = 500_000e6;
  uint256 public constant USDT_IMMUNEFI_AMOUNT = 100_000e6;

  function execute() external {
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      WHITEHAT_RECIPIENT,
      AAVE_WHITEHAT_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      WHITEHAT_RECIPIENT,
      USDT_WHITEHAT_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      IMMUNEFI_RECIPIENT,
      USDT_IMMUNEFI_AMOUNT
    );
  }
}
