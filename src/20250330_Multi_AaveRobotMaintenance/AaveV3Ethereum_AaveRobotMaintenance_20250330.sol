// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IRescuable} from 'solidity-utils/contracts/utils/interfaces/IRescuable.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Aave Robot Maintenance
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3Ethereum_AaveRobotMaintenance_20250330 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  uint256 public constant OLD_STATA_ROBOT_ID =
    4988169448756852094961305595918821552734559788548770336163498615236667618831;
  uint256 public constant OLD_VOTING_CHAIN_ROBOT_ID =
    82833167426690131327156306619804835187993096599645268046153072625511131069340;

  address public constant STATA_ROBOT = 0x892B74CD3703B427CD90e7f140F358A1DE1EA703;
  address public constant VOTING_CHAIN_ROBOT = 0xbC3210bfff692a5bbDBB068D42Ab4eAF28b01Ee0;

  address public constant OLD_ROOTS_CONSUMER = 0x2fA6F0A65886123AFD24A575aE4554d0FCe8B577;
  address public constant ROOTS_CONSUMER = 0x2601FF9ac41ca7331e512d6C603c659400e0fC4E;

  uint96 public constant STATA_ROBOT_LINK_AMOUNT = 150e18;
  uint96 public constant VOTING_CHAIN_ROBOT_LINK_AMOUNT = 350e18;

  function execute() external {
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_STATA_ROBOT_ID);
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).cancel(OLD_VOTING_CHAIN_ROBOT_ID);
    uint256 totalLinkAmount = STATA_ROBOT_LINK_AMOUNT + VOTING_CHAIN_ROBOT_LINK_AMOUNT;

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.LINK_UNDERLYING),
      address(this),
      totalLinkAmount
    );
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      totalLinkAmount
    );

    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'Gas Capped StataToken Rewards Robot',
      STATA_ROBOT,
      '', // check data
      1_000_000, // gas limit
      STATA_ROBOT_LINK_AMOUNT,
      0,
      ''
    );
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
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
      AaveV3EthereumAssets.LINK_UNDERLYING,
      ROOTS_CONSUMER,
      IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(OLD_ROOTS_CONSUMER)
    );
  }
}
