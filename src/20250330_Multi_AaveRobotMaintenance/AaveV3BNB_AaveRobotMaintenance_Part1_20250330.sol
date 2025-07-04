// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/96
 */
contract AaveV3BNB_AaveRobotMaintenance_Part1_20250330 is IProposalGenericExecutor {
  uint256 public constant OLD_STATA_ROBOT_ID =
    19667273976260471602440681713888837603574569719242374712497587743748914505207;

  function execute() external {
    IAaveCLRobotOperator(MiscBNB.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_STATA_ROBOT_ID);
  }
}
