// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {DelistAllAgents} from './DelistAllAgents.sol';
import {CancelAgentRobots} from './CancelAgentRobots.sol';
/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410 is
  IProposalGenericExecutor
{
  function execute() external {
    DelistAllAgents.delist(MiscAvalanche.AGENT_HUB, address(AaveV3Avalanche.ACL_MANAGER));
    CancelAgentRobots.cancel(
      MiscAvalanche.AAVE_CL_ROBOT_OPERATOR,
      MiscAvalanche.AGENT_HUB_AUTOMATION
    );
  }
}
