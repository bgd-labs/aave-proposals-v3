// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {DelistAllAgents} from './DelistAllAgents.sol';
import {CancelAgentRobots} from './CancelAgentRobots.sol';
/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3Arbitrum_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410 is
  IProposalGenericExecutor
{
  function execute() external {
    DelistAllAgents.delist(MiscArbitrum.AGENT_HUB, address(AaveV3Arbitrum.ACL_MANAGER));
    CancelAgentRobots.cancel(
      MiscArbitrum.AAVE_CL_ROBOT_OPERATOR,
      MiscArbitrum.AGENT_HUB_AUTOMATION
    );
  }
}
