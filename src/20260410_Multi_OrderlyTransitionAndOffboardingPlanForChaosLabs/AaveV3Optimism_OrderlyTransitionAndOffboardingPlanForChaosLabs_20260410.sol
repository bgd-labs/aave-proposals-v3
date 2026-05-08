// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {DelistAllAgents} from './DelistAllAgents.sol';
import {CancelAgentRobots} from './CancelAgentRobots.sol';
/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3Optimism_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410 is
  IProposalGenericExecutor
{
  function execute() external {
    DelistAllAgents.delist(MiscOptimism.AGENT_HUB, address(AaveV3Optimism.ACL_MANAGER));
    CancelAgentRobots.cancel(
      MiscOptimism.AAVE_CL_ROBOT_OPERATOR,
      MiscOptimism.AGENT_HUB_AUTOMATION
    );
  }
}
