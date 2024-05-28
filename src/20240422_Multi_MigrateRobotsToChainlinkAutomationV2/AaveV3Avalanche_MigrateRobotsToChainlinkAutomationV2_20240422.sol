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
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/36
 */
contract AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant ROBOT_OPERATOR = 0x06d958772304e7220fc3E463756CE01Ed0D24db2;
  address public constant EXECUTION_CHAIN_ROBOT_ADDRESS =
    0x7B74938583Eb03e06042fcB651046BaF0bf15644;
  address public constant VOTING_CHAIN_ROBOT_ADDRESS = 0x10E49034306EaA663646773C04b7B67E81eD0D52;
  address public constant STATIC_A_TOKEN_ROBOT_ADDRESS = 0x8aD3f00e91F0a3Ad8b0dF897c19EC345EaB761c4;

  address public constant PROOF_OF_RESERVE_ROBOT_ADDRESS =
    0x7aE2930B50CFEbc99FE6DB16CE5B9C7D8d09332C;
  address public constant PROOF_OF_RESERVE_EXECUTOR_V2 = 0x7fc3FCb14eF04A48Bb0c12f0c39CD74C249c37d8;
  address public constant PROOF_OF_RESERVE_EXECUTOR_V3 = 0xab22988D93d5F942fC6B6c6Ea285744809D1d9Cc;

  uint256 public constant EXECUTION_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;
  uint256 public constant VOTING_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;
  uint256 public constant PROOF_OF_RESERVE_ROBOT_LINK_AMOUNT = 15 ether;
  uint256 public constant STATIC_A_TOKEN_ROBOT_LINK_AMOUNT = 20 ether;

  function execute() external {
    uint256 totalLinkAmount = EXECUTION_CHAIN_ROBOT_LINK_AMOUNT +
      VOTING_CHAIN_ROBOT_LINK_AMOUNT +
      (PROOF_OF_RESERVE_ROBOT_LINK_AMOUNT * 2) +
      STATIC_A_TOKEN_ROBOT_LINK_AMOUNT;

    AaveV3Avalanche.COLLECTOR.transfer(
      AaveV3AvalancheAssets.LINKe_UNDERLYING,
      address(this),
      totalLinkAmount
    );

    IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).forceApprove(ROBOT_OPERATOR, totalLinkAmount);

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
      'Proof Of Reserve Robot V2',
      PROOF_OF_RESERVE_ROBOT_ADDRESS,
      abi.encode(PROOF_OF_RESERVE_EXECUTOR_V2),
      2_500_000,
      PROOF_OF_RESERVE_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Proof Of Reserve Robot V3',
      PROOF_OF_RESERVE_ROBOT_ADDRESS,
      abi.encode(PROOF_OF_RESERVE_EXECUTOR_V3),
      2_500_000,
      PROOF_OF_RESERVE_ROBOT_LINK_AMOUNT.toUint96(),
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
