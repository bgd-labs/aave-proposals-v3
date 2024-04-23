// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
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
 * - Discussion: TODO
 */
contract AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant ROBOT_OPERATOR = 0x023640D7CDa2E2063546A45005393756B9b4ac9D;
  address public constant EXECUTION_CHAIN_ROBOT_ADDRESS =
    0x7B74938583Eb03e06042fcB651046BaF0bf15644;
  address public constant VOTING_CHAIN_ROBOT_ADDRESS = 0x10E49034306EaA663646773C04b7B67E81eD0D52;

  uint256 public constant EXECUTION_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;
  uint256 public constant VOTING_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;

  function execute() external {
    AaveV3Avalanche.COLLECTOR.transfer(
      AaveV3AvalancheAssets.LINKe_UNDERLYING,
      address(this),
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT + VOTING_CHAIN_ROBOT_LINK_AMOUNT
    );

    IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).forceApprove(
      ROBOT_OPERATOR,
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT + VOTING_CHAIN_ROBOT_LINK_AMOUNT
    );

    // register new robots
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Execution Chain Robot',
      EXECUTION_CHAIN_ROBOT_ADDRESS,
      5_000_000,
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Voting Chain Robot',
      VOTING_CHAIN_ROBOT_ADDRESS,
      5_000_000,
      VOTING_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
  }
}
