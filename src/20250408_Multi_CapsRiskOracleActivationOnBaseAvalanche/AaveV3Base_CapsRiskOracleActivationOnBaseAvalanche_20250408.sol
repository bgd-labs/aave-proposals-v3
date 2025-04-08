// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Caps Risk Oracle Activation on Base, Avalanche
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant EDGE_RISK_STEWARD = 0x0BC79137bc7788f0c2D49dF77B9C9BeC870Edef9;
  address public constant AAVE_STEWARD_INJECTOR = 0x54714FAc85b0bf627288CC3a186dE81A42f1D635;

  address public constant LINK_TOKEN = 0x88Fb150BDc53A65fe94Dea0c9BA0a6dAf8C6e196;
  uint96 public constant LINK_AMOUNT = 30 ether;

  function execute() external {
    AaveV3Base.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

    IERC20(LINK_TOKEN).forceApprove(MiscBase.AAVE_CL_ROBOT_OPERATOR, LINK_AMOUNT);
    IAaveCLRobotOperator(MiscBase.AAVE_CL_ROBOT_OPERATOR).register(
      'Caps AGRS Injector',
      AAVE_STEWARD_INJECTOR,
      '',
      5_000_000,
      LINK_AMOUNT,
      0,
      ''
    );
  }
}
