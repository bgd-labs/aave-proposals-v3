// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/96
 */
contract AaveV3Base_AaveRobotMaintenance_Part1_20250330 is IProposalGenericExecutor {
  uint256 public constant OLD_STATA_ROBOT_ID =
    70341990226573255197293586524462899204513258321978410065970265066726099049727;

  function execute() external {
    IAaveCLRobotOperator(MiscBase.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_STATA_ROBOT_ID);
  }
}
