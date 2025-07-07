// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/96
 */
contract AaveV3Optimism_AaveRobotMaintenance_20250330 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  uint256 public constant OLD_STATA_ROBOT_ID =
    39066907368614325305271533987556686659130404181465565359549140029355866543783;
  address public constant STATA_ROBOT = 0x365d47ceD3D7Eb6a9bdB3814aA23cc06B2D33Ef8;
  uint96 public constant STATA_ROBOT_LINK_AMOUNT = 30e18;

  function execute() external {
    IAaveCLRobotOperator(MiscOptimism.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_STATA_ROBOT_ID);

    AaveV3Optimism.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.LINK_UNDERLYING,
        amount: STATA_ROBOT_LINK_AMOUNT
      }),
      address(this)
    );
    uint256 linkBalance = IERC20(AaveV3OptimismAssets.LINK_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV3OptimismAssets.LINK_UNDERLYING).forceApprove(
      MiscOptimism.AAVE_CL_ROBOT_OPERATOR,
      linkBalance
    );

    IAaveCLRobotOperator(MiscOptimism.AAVE_CL_ROBOT_OPERATOR).register(
      'StataToken Rewards Robot',
      STATA_ROBOT,
      '', // check data
      1_000_000, // gas limit
      linkBalance.toUint96(),
      0,
      ''
    );
  }
}
