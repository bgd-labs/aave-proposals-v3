// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

/**
 * @title Offboarding Plan for Chaos Labs part 3: Cancel stream 100073
 * @author ChaosLabs (performed by Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513 is
  IProposalGenericExecutor
{
  uint256 public constant PREVIOUS_STREAM = 100073;

  function execute() external {
    AaveV3EthereumLido.COLLECTOR.cancelStream(PREVIOUS_STREAM);
  }
}
