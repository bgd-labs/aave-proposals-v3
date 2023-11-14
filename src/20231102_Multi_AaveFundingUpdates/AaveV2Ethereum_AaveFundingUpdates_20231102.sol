// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2EthereumArc} from 'aave-address-book/AaveV2EthereumArc.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

import {WithdrawAndSwapPayload} from './WithdrawAndSwapPayload.sol';

/**
 * @title Aave Funding Updates
 * @author efecarranza.eth
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x099f88e1728760952be26fcb8fc99b26c29336e6a109820b391751b108399ee5
 * - Discussion: https://governance.aave.com/t/arfc-aave-funding-update/15194
 */
contract AaveV2Ethereum_AaveFundingUpdates_20231102 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant ARC_USDC = 0xd35f648C3C7f17cd1Ba92e5eac991E3EfcD4566d;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(
      ARC_USDC,
      address(this),
      IERC20(ARC_USDC).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    AaveV2EthereumArc.POOL.withdraw(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(AaveV3Ethereum.COLLECTOR)
    );
  }
}
