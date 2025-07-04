// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IRescuable} from 'solidity-utils/contracts/utils/interfaces/IRescuable.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * @notice This payload should be executed after the payload for cancelling old robots has been executed and link tokens
 *         have been transferred to the collector by calling the `withdrawLink()` method on the old operator contract.
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/96
 */
contract AaveV3Polygon_AaveRobotMaintenance_Part2_20250330 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  uint256 public constant OLD_STATA_ROBOT_ID =
    40024828054511361476927715751368398172548974984337853100296298603463129247002;
  uint256 public constant OLD_VOTING_CHAIN_ROBOT_ID =
    21142580545291648991688096849537169930383384259812834220265169526777978092869;

  address public constant STATA_ROBOT = 0x1d8347B427964fad8a742e7f9442a4E89346400a;
  address public constant VOTING_CHAIN_ROBOT = 0x1180eE41eC15Dd0accC13a1e646B3152bECFf8F6;

  address public constant OLD_ROOTS_CONSUMER = 0xE77aF99210AC55939e1ba0bFC6A9a20E1Da73b25;
  address public constant ROOTS_CONSUMER = 0x2BdC5C640EB17Ad55f7Dc7a9aE2987C0974B60fc;

  uint96 public constant STATA_ROBOT_LINK_AMOUNT = 25e18;
  uint96 public constant VOTING_CHAIN_ROBOT_LINK_AMOUNT = 40e18;

  address public constant LINK_TOKEN = 0xb0897686c545045aFc77CF20eC7A532E3120E0F1;

  function execute() external {
    uint256 totalLinkAmount = STATA_ROBOT_LINK_AMOUNT + VOTING_CHAIN_ROBOT_LINK_AMOUNT;
    AaveV3Polygon.COLLECTOR.transfer(IERC20(LINK_TOKEN), address(this), totalLinkAmount);
    IERC20(LINK_TOKEN).forceApprove(MiscPolygon.AAVE_CL_ROBOT_OPERATOR, totalLinkAmount);

    IAaveCLRobotOperator(MiscPolygon.AAVE_CL_ROBOT_OPERATOR).register(
      'Gas Capped StataToken Rewards Robot',
      STATA_ROBOT,
      '', // check data
      1_000_000, // gas limit
      STATA_ROBOT_LINK_AMOUNT,
      0,
      ''
    );
    IAaveCLRobotOperator(MiscPolygon.AAVE_CL_ROBOT_OPERATOR).register(
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
      LINK_TOKEN,
      ROOTS_CONSUMER,
      IERC20(LINK_TOKEN).balanceOf(OLD_ROOTS_CONSUMER)
    );
  }
}
