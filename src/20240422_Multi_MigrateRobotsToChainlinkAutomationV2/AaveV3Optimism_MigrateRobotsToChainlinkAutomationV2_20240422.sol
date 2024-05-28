// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';

/**
 * @title Migrate Robots to Chainlink Automation v2
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/36
 */
contract AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant OLD_ROBOT_OPERATOR = 0x4f830bc2DdaC99307a3709c85F7533842BdA7c63;
  uint256 public constant OLD_EXECUTION_CHAIN_ROBOT_ID =
    98991846084053478582099013231511635776224064505474556907242977329597039975307;

  address public constant ROBOT_OPERATOR = 0x55Cf9583D7D30DC4936bAee1f747591dBECe5df7;
  address public constant EXECUTION_CHAIN_ROBOT_ADDRESS =
    0xa0195539e21A6553243344A3BE6b874B5d3EC7b9;
  address public constant STATIC_A_TOKEN_ROBOT_ADDRESS = 0x861Be72d464b6F1C99880B9bE476D40e8F9b5Bce;

  uint256 public constant STATIC_A_TOKEN_ROBOT_LINK_AMOUNT = 30 ether;
  uint256 public constant EXECUTION_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;

  function execute() external {
    // cancel previous robot
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_EXECUTION_CHAIN_ROBOT_ID);

    AaveV3Optimism.COLLECTOR.transfer(
      AaveV3OptimismAssets.LINK_A_TOKEN,
      address(this),
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT + STATIC_A_TOKEN_ROBOT_LINK_AMOUNT
    );

    AaveV3Optimism.POOL.withdraw(
      AaveV3OptimismAssets.LINK_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 linkBalance = IERC20(AaveV3OptimismAssets.LINK_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV3OptimismAssets.LINK_UNDERLYING).forceApprove(ROBOT_OPERATOR, linkBalance);

    // register new robot
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Execution Chain Robot',
      EXECUTION_CHAIN_ROBOT_ADDRESS,
      '',
      5_000_000,
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'StaticAToken Rewards Robot',
      STATIC_A_TOKEN_ROBOT_ADDRESS,
      '',
      1_000_000,
      STATIC_A_TOKEN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
  }
}
