// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs part2
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3EthereumLido_OrderlyTransitionAndOffboardingPlanForChaosLabsPart2_20260507 is
  IProposalGenericExecutor
{
  address public constant CHAOS_LABS = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0; // stream 100073 recipient
  uint256 public constant PREVIOUS_STREAM = 100073;
  uint256 public constant AMOUNT_PER_SECOND = 80859969558599695; // from stream 100073
  uint256 public constant FORUM_POST_TIMESTAMP = 1775606400;
  function execute() external {
    try AaveV3EthereumLido.COLLECTOR.cancelStream(PREVIOUS_STREAM) {} catch {}

    // Payment only if executed within the 30-day transition window (ends 2026-05-08)
    if (FORUM_POST_TIMESTAMP + 30 days > block.timestamp) {
      uint256 second_left = (FORUM_POST_TIMESTAMP + 30 days) - block.timestamp;
      // bulk transfer
      AaveV3EthereumLido.COLLECTOR.transfer(
        IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
        CHAOS_LABS,
        AMOUNT_PER_SECOND * second_left
      );
    }
  }
}
