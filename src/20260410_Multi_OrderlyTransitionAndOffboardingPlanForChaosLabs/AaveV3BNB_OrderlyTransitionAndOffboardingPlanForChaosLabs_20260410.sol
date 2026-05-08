// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {DelistAllAgents} from './DelistAllAgents.sol';
import {CancelAgentRobots} from './CancelAgentRobots.sol';

/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3BNB_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410 is
  IProposalGenericExecutor
{
  function execute() external {
    DelistAllAgents.delist(MiscBNB.AGENT_HUB, address(AaveV3BNB.ACL_MANAGER));
    CancelAgentRobots.cancel(MiscBNB.AAVE_CL_ROBOT_OPERATOR, MiscBNB.AGENT_HUB_AUTOMATION);
  }
}
