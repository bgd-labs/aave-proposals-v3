// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/96
 */
contract AaveV3Polygon_AaveRobotMaintenance_Part1_20250330 is IProposalGenericExecutor {
  uint256 public constant OLD_STATA_ROBOT_ID =
    40024828054511361476927715751368398172548974984337853100296298603463129247002;
  uint256 public constant OLD_VOTING_CHAIN_ROBOT_ID =
    21142580545291648991688096849537169930383384259812834220265169526777978092869;

  function execute() external {
    IAaveCLRobotOperator(MiscPolygon.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_STATA_ROBOT_ID);
    IAaveCLRobotOperator(MiscPolygon.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_VOTING_CHAIN_ROBOT_ID);
  }
}
