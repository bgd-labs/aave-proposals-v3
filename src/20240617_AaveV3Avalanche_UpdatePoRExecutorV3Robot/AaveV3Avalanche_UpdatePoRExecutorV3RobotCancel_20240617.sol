// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
/**
 * @title Update PoR Executor V3 Robot
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617 is IProposalGenericExecutor {
  address public constant ROBOT_OPERATOR = 0x06d958772304e7220fc3E463756CE01Ed0D24db2;
  uint256 public constant OLD_POR_ROBOT_ID =
    26365172985027002678612464504385127359853428975895609819521748772469113961166;

  function execute() external {
    IAaveCLRobotOperator(ROBOT_OPERATOR).cancel(OLD_POR_ROBOT_ID);
  }
}
