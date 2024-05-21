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
contract AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  address public constant OLD_ROBOT_OPERATOR = 0x4e8984D11A47Ff89CD67c7651eCaB6C00a74B4A9;
  uint256 public constant OLD_EXECUTION_CHAIN_ROBOT_ID =
    82990232394810788826748981965753730350133859818029683929136401112559915179430;
  uint256 public constant OLD_VOTING_CHAIN_ROBOT_ID =
    5475326125853957331243818268970211605617607736278808003229011576358255850220;

  function execute() external {
    // cancel previous robots
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_EXECUTION_CHAIN_ROBOT_ID);
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_VOTING_CHAIN_ROBOT_ID);
  }
}
