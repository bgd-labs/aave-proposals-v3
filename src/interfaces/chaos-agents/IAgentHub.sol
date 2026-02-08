// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAgentConfigurator} from './IAgentConfigurator.sol';

/**
 * @title IAgentHub
 * @author BGD labs
 * @notice Defines the interface for the AgentHub contract
 */
interface IAgentHub is IAgentConfigurator {
  /**
   * @notice There must be at least one action performed per execution
   */
  error NoActionCanBePerformed();

  /**
   * @notice Struct storing data passed from check to execute to perform actions
   */
  struct ActionData {
    uint256 agentId;
    address[] markets;
  }

  /**
   * @notice run off-chain, checks if updates from the riskOracle could be injected or not
   * @param agentIds contains the list of agentIds for which updates should be checked
   * @return shouldExecute true if perform should be run, false otherwise
   * @return actions contains the list of ActionData struct containing the agentId and markets
   *         for which updates could be injected
   */
  function check(
    uint256[] memory agentIds
  ) external view returns (bool shouldExecute, ActionData[] memory actions);

  /**
   * @notice method to inject updates for agents, should be run when check() returns true
   * @param actions contains the list of ActionData for which updates can be injected
   */
  function execute(ActionData[] memory actions) external;
}
