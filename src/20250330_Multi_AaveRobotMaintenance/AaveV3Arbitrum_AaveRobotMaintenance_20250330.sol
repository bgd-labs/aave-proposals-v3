// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/96
 */
contract AaveV3Arbitrum_AaveRobotMaintenance_20250330 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  uint256 public constant OLD_STATA_ROBOT_ID =
    34319054624776880603638802606735174345615741182444121775448759524700600678014;
  address public constant STATA_ROBOT = 0xF01281a6DfDe5506C5049c9BBf8C7E087b9bD4bF;
  uint96 public constant STATA_ROBOT_LINK_AMOUNT = 34e18;

  function execute() external {
    IAaveCLRobotOperator(MiscArbitrum.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_STATA_ROBOT_ID);

    AaveV3Arbitrum.COLLECTOR.transfer(
      IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING),
      address(this),
      STATA_ROBOT_LINK_AMOUNT
    );
    IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).forceApprove(
      MiscArbitrum.AAVE_CL_ROBOT_OPERATOR,
      STATA_ROBOT_LINK_AMOUNT
    );

    IAaveCLRobotOperator(MiscArbitrum.AAVE_CL_ROBOT_OPERATOR).register(
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
