// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * @notice This payload should be executed after the payload for cancelling old robots has been executed and link tokens
 *         have been transferred to the collector by calling the `withdrawLink()` method on the old operator contract.
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/96
 */
contract AaveV3Base_AaveRobotMaintenance_Part2_20250330 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant LINK_TOKEN = 0x88Fb150BDc53A65fe94Dea0c9BA0a6dAf8C6e196;
  address public constant STATA_ROBOT = 0x97CB9e81d480A2AB03299760654C1DDC0C16bE07;
  uint96 public constant STATA_ROBOT_LINK_AMOUNT = 14e18;

  function execute() external {
    AaveV3Base.COLLECTOR.transfer(IERC20(LINK_TOKEN), address(this), STATA_ROBOT_LINK_AMOUNT);
    IERC20(LINK_TOKEN).forceApprove(MiscBase.AAVE_CL_ROBOT_OPERATOR, STATA_ROBOT_LINK_AMOUNT);

    IAaveCLRobotOperator(MiscBase.AAVE_CL_ROBOT_OPERATOR).register(
      'StataToken Rewards Robot',
      STATA_ROBOT,
      '', // check data
      1_000_000, // gas limit
      STATA_ROBOT_LINK_AMOUNT,
      0,
      ''
    );
  }
}
