// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {DelistAllAgents} from './DelistAllAgents.sol';
import {CancelAgentRobots} from './CancelAgentRobots.sol';
/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3Base_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410 is
  IProposalGenericExecutor
{
  function execute() external {
    DelistAllAgents.delist(MiscBase.AGENT_HUB, address(AaveV3Base.ACL_MANAGER));
    CancelAgentRobots.cancel(MiscBase.AAVE_CL_ROBOT_OPERATOR, MiscBase.AGENT_HUB_AUTOMATION);
  }
}
