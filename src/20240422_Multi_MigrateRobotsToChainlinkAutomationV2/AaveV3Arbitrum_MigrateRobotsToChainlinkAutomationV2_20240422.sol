// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';

/**
 * @title Migrate Robots to Chainlink Automation v2
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant OLD_ROBOT_OPERATOR = 0xb0A73671C97BAC9Ba899CD1a23604Fd2278cD02A;
  uint256 public constant OLD_EXECUTION_CHAIN_ROBOT_ID =
    78329451080216164099529400539433108989111820950862041749656351555695961643082;

  address public constant ROBOT_OPERATOR = 0xAa589e4c7539e8D7465c36578098499F0b2BBd12;
  address public constant EXECUTION_CHAIN_ROBOT_ADDRESS =
    0x64093fe5f8Cf62aFb4377cf7EF4373537fe9155B;
  uint256 public constant EXECUTION_CHAIN_ROBOT_LINK_AMOUNT = 45 ether;

  function execute() external {
    // cancel previous robot
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_EXECUTION_CHAIN_ROBOT_ID);

    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.LINK_A_TOKEN,
      address(this),
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT
    );
    AaveV3Arbitrum.POOL.withdraw(
      AaveV3ArbitrumAssets.LINK_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 linkBalance = IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).forceApprove(ROBOT_OPERATOR, linkBalance);

    // register new robot
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Execution Chain Robot',
      EXECUTION_CHAIN_ROBOT_ADDRESS,
      5_000_000,
      linkBalance.toUint96(),
      0,
      ''
    );
  }
}
