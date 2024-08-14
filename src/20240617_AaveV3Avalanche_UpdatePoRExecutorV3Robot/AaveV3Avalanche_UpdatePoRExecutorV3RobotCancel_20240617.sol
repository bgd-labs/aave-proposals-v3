// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
/**
 * @title Update PoR Executor V3 Robot
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/42
 */
contract AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617 is IProposalGenericExecutor {
  uint256 public constant OLD_POR_ROBOT_ID =
    26365172985027002678612464504385127359853428975895609819521748772469113961166;

  function execute() external {
    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_POR_ROBOT_ID);
  }
}
