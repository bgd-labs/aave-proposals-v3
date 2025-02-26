// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Caps Risk Oracle Activation on Arbitrum
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x1d8d0d25f3b705bf207a130308658d15256e2cebc58d123e4ad9e7e3a177ac11
 * - Discussion: https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834
 */
contract AaveV3Arbitrum_CapsRiskOracleActivationOnArbitrum_20250218 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant EDGE_RISK_STEWARD = 0x085E34722e04567Df9E6d2c32e82fd74f3342e79;
  address public constant AAVE_STEWARD_INJECTOR = 0x35d53dEB2F6f40Ea7af32B6F8BEd88eA966DF1D9;

  uint96 public constant LINK_AMOUNT = 50 ether;

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);
    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.LINK_UNDERLYING,
      address(this),
      LINK_AMOUNT
    );

    IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).forceApprove(
      MiscArbitrum.AAVE_CL_ROBOT_OPERATOR,
      LINK_AMOUNT
    );
    IAaveCLRobotOperator(MiscArbitrum.AAVE_CL_ROBOT_OPERATOR).register(
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
