// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IAgentHub} from '../interfaces/chaos-agents/IAgentHub.sol';
/**
 * @title Chaos AgentHub Offboarding
 * @author Aave Labs
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3Plasma_ChaosAgentHubOffboarding_20260505 is IProposalGenericExecutor {
  function execute() external {
    uint256 agentCount = IAgentHub(MiscPlasma.AGENT_HUB).getAgentCount();
    for (uint256 i = 0; i < agentCount; i++) {
      IAgentHub(MiscPlasma.AGENT_HUB).setAgentEnabled(i, false);
      address agent = IAgentHub(MiscPlasma.AGENT_HUB).getAgentAddress(i);
      IACLManager(AaveV3Plasma.ACL_MANAGER).removeRiskAdmin(agent);
    }
  }
}
