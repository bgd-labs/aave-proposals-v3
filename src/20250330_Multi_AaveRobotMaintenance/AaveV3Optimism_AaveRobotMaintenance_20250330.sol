// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3Optimism_AaveRobotMaintenance_20250330 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  uint256 public constant OLD_STATA_ROBOT_ID =
    39066907368614325305271533987556686659130404181465565359549140029355866543783;
  address public constant STATA_ROBOT = 0x365d47ceD3D7Eb6a9bdB3814aA23cc06B2D33Ef8;
  uint96 public constant STATA_ROBOT_LINK_AMOUNT = 30e18;

  function execute() external {
    IAaveCLRobotOperator(MiscOptimism.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_STATA_ROBOT_ID);

    AaveV3Optimism.COLLECTOR.transfer(
      IERC20(AaveV3OptimismAssets.LINK_UNDERLYING),
      address(this),
      STATA_ROBOT_LINK_AMOUNT
    );
    IERC20(AaveV3OptimismAssets.LINK_UNDERLYING).forceApprove(
      MiscOptimism.AAVE_CL_ROBOT_OPERATOR,
      STATA_ROBOT_LINK_AMOUNT
    );

    IAaveCLRobotOperator(MiscOptimism.AAVE_CL_ROBOT_OPERATOR).register(
      'Gas Capped StataToken Rewards Robot',
      STATA_ROBOT,
      '', // check data
      1_000_000, // gas limit
      STATA_ROBOT_LINK_AMOUNT,
      0,
      ''
    );
  }
}
