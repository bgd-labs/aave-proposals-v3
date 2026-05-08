// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 */

library CancelAgentRobots {
  function cancel(address robotOperator, address agentHubAutomation) internal {
    IAaveCLRobotOperator operator = IAaveCLRobotOperator(robotOperator);
    uint256[] memory keeperIds = operator.getKeepersList();
    for (uint256 i = 0; i < keeperIds.length; i++) {
      if (operator.getKeeperInfo(keeperIds[i]).upkeep == agentHubAutomation) {
        operator.cancel(keeperIds[i]);
      }
    }
  }
}
