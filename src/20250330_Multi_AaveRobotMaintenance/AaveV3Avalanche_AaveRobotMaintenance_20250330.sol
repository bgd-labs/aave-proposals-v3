// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IRescuable} from 'solidity-utils/contracts/utils/interfaces/IRescuable.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/96
 */
contract AaveV3Avalanche_AaveRobotMaintenance_20250330 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  uint256 public constant OLD_STATA_ROBOT_ID =
    107904947592579568918971700174194140052238704341893786027145543179921746685644;
  uint256 public constant OLD_VOTING_CHAIN_ROBOT_ID =
    104320456798630048380384063932231049722318769494907106359951948679643359625916;

  address public constant STATA_ROBOT = 0x43C6b39669355AF93DdEdc70e8eB44c226f09BFB;
  address public constant VOTING_CHAIN_ROBOT = 0x2cf0fA5b36F0f89a5EA18F835d1375974a7720B8;

  address public constant OLD_ROOTS_CONSUMER = 0x6264E51782D739caf515a1Bd4F9ae6881B58621b;
  address public constant ROOTS_CONSUMER = 0xcCeb5996cF9976168fdbE6fF88B1d89e1180A0EA;

  uint96 public constant STATA_ROBOT_LINK_AMOUNT = 10e18;
  uint96 public constant VOTING_CHAIN_ROBOT_LINK_AMOUNT = 32e18;

  function execute() external {
    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_STATA_ROBOT_ID);
    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_VOTING_CHAIN_ROBOT_ID);
    uint256 totalLinkAmount = STATA_ROBOT_LINK_AMOUNT + VOTING_CHAIN_ROBOT_LINK_AMOUNT;

    AaveV3Avalanche.COLLECTOR.transfer(
      IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING),
      address(this),
      totalLinkAmount
    );
    IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).forceApprove(
      MiscAvalanche.AAVE_CL_ROBOT_OPERATOR,
      totalLinkAmount
    );

    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).register(
      'Gas Capped StataToken Rewards Robot',
      STATA_ROBOT,
      '', // check data
      1_000_000, // gas limit
      STATA_ROBOT_LINK_AMOUNT,
      0,
      ''
    );
    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).register(
      'Gas Capped Voting Chain Robot',
      VOTING_CHAIN_ROBOT,
      '', // check data
      5_000_000, // gas limit
      VOTING_CHAIN_ROBOT_LINK_AMOUNT,
      0,
      ''
    );

    // transfer link from old roots consumer to new one
    IRescuable(OLD_ROOTS_CONSUMER).emergencyTokenTransfer(
      AaveV3AvalancheAssets.LINKe_UNDERLYING,
      ROOTS_CONSUMER,
      IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).balanceOf(OLD_ROOTS_CONSUMER)
    );
  }
}
