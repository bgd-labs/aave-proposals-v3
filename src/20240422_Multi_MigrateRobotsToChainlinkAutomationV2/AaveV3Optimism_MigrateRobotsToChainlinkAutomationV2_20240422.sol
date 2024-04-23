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
 * - Snapshot: TODO
 */
contract AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant OLD_ROBOT_OPERATOR = 0x4f830bc2DdaC99307a3709c85F7533842BdA7c63;
  uint256 public constant OLD_EXECUTION_CHAIN_ROBOT_ID =
    98991846084053478582099013231511635776224064505474556907242977329597039975307;

  address public constant ROBOT_OPERATOR = 0x34F098B9B67B147d8a679476bc89982DdE525F8c;
  address public constant EXECUTION_CHAIN_ROBOT_ADDRESS =
    0xa0195539e21A6553243344A3BE6b874B5d3EC7b9;
  uint256 public constant EXECUTION_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;

  function execute() external {
    // cancel previous robot
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_EXECUTION_CHAIN_ROBOT_ID);

    AaveV3Optimism.COLLECTOR.transfer(
      AaveV3OptimismAssets.LINK_UNDERLYING,
      address(this),
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT
    );

    IERC20(AaveV3OptimismAssets.LINK_UNDERLYING).forceApprove(
      ROBOT_OPERATOR,
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT
    );

    // register new robot
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Execution Chain Robot',
      EXECUTION_CHAIN_ROBOT_ADDRESS,
      5_000_000,
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
  }
}
