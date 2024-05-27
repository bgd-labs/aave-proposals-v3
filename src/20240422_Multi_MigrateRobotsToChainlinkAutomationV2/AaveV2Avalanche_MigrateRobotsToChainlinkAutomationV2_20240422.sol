// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Migrate Robots to Chainlink Automation v2
 * @author BGD Labs (@bgdlabs)
 * @notice This payload should be executed before the payload for registering new robots.
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/36
 */
contract AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  address public constant OLD_ROBOT_OPERATOR = 0x7A9ff54A6eE4a21223036890bB8c4ea2D62c686b;
  uint256 public constant OLD_EXECUTION_CHAIN_ROBOT_ID =
    42967470609923359998605990815360926273002411113492386351801017384824248835129;
  uint256 public constant OLD_VOTING_CHAIN_ROBOT_ID =
    23105234861606727783784560473737793446534476931507704105643023042466416318991;

  function execute() external {
    // cancel previous robots
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_EXECUTION_CHAIN_ROBOT_ID);
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_VOTING_CHAIN_ROBOT_ID);
  }
}
