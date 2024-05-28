// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';

/**
 * @title Migrate Robots to Chainlink Automation v2
 * @author BGD Labs (@bgdlabs)
 * @notice This payload should be executed after the payload for cancelling old robots has been executed and link tokens
 *         have been transferred to the collector by calling the `withdrawLink()` method on the old operator contract.
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/36
 */
contract AaveV3Polygon_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant LINK_TOKEN = 0xb0897686c545045aFc77CF20eC7A532E3120E0F1;
  address public constant ROBOT_OPERATOR = 0xB4C212f5cD17E200019b07e6B1fDf124d35DBCf5;
  address public constant EXECUTION_CHAIN_ROBOT_ADDRESS =
    0x249396a890F89D47F89326d7EE116b1d374Fb3A9;
  address public constant VOTING_CHAIN_ROBOT_ADDRESS = 0xbe7998712402B6A63975515A532Ce503437998b7;
  address public constant STATIC_A_TOKEN_ROBOT_ADDRESS = 0x855FbD0D57fF5B1e8263e3cCDf3384545fbaF863;

  uint256 public constant EXECUTION_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;
  uint256 public constant VOTING_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;
  uint256 public constant STATIC_A_TOKEN_ROBOT_LINK_AMOUNT = 25 ether;

  function execute() external {
    AaveV3Polygon.COLLECTOR.transfer(
      LINK_TOKEN,
      address(this),
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT +
        VOTING_CHAIN_ROBOT_LINK_AMOUNT +
        STATIC_A_TOKEN_ROBOT_LINK_AMOUNT
    );

    IERC20(LINK_TOKEN).forceApprove(
      ROBOT_OPERATOR,
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT +
        VOTING_CHAIN_ROBOT_LINK_AMOUNT +
        STATIC_A_TOKEN_ROBOT_LINK_AMOUNT
    );

    // register new robots
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Execution Chain Robot',
      EXECUTION_CHAIN_ROBOT_ADDRESS,
      '',
      5_000_000,
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Voting Chain Robot',
      VOTING_CHAIN_ROBOT_ADDRESS,
      '',
      5_000_000,
      VOTING_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'StaticAToken Rewards Robot',
      STATIC_A_TOKEN_ROBOT_ADDRESS,
      '',
      1_000_000,
      STATIC_A_TOKEN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
  }
}
