// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Caps Risk Oracle Activation on Optimism, BNB, Gnosis, Polygon
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/98
 */
contract AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;

  address public constant EDGE_RISK_STEWARD = 0x655252250f4A453854040A49E8280951A76f3033;
  address public constant AAVE_STEWARD_INJECTOR = 0x54714FAc85b0bf627288CC3a186dE81A42f1D635;

  address public constant LINK_TOKEN = 0x404460C6A5EdE2D891e8297795264fDe62ADBB75;
  uint96 public constant LINK_AMOUNT = 30 ether;

  function execute() external {
    AaveV3BNB.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

    IERC20(LINK_TOKEN).forceApprove(MiscBNB.AAVE_CL_ROBOT_OPERATOR, LINK_AMOUNT);
    IAaveCLRobotOperator(MiscBNB.AAVE_CL_ROBOT_OPERATOR).register(
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
