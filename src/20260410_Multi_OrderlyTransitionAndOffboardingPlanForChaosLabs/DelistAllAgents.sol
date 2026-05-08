// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAgentHub} from '../interfaces/chaos-agents/IAgentHub.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';

/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 */

library DelistAllAgents {
  function delist(address agentHub, address aclManager) internal {
    uint256 agentCount = IAgentHub(agentHub).getAgentCount();
    for (uint256 i = 0; i < agentCount; i++) {
      IAgentHub(agentHub).setAgentEnabled(i, false);
      IACLManager(aclManager).removeRiskAdmin(IAgentHub(agentHub).getAgentAddress(i));
    }
  }

  function delist(address agentHub, address aclManager1, address aclManager2) internal {
    uint256 agentCount = IAgentHub(agentHub).getAgentCount();
    for (uint256 i = 0; i < agentCount; i++) {
      IAgentHub(agentHub).setAgentEnabled(i, false);
      address agent = IAgentHub(agentHub).getAgentAddress(i);
      IACLManager(aclManager1).removeRiskAdmin(agent);
      IACLManager(aclManager2).removeRiskAdmin(agent);
    }
  }
}
