// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets, ICollector} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Caps Risk Oracle Activation on Base, Avalanche
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/78
 */
contract AaveV3Avalanche_CapsRiskOracleActivationOnBaseAvalanche_20250408 is
  IProposalGenericExecutor
{
  using SafeCast for uint256;
  using CollectorUtils for ICollector;
  using SafeERC20 for IERC20;

  address public constant EDGE_RISK_STEWARD = 0x57218F3aB422A39115951c3Eb06881a7A719DfdD;
  address public constant AAVE_STEWARD_INJECTOR = 0x54714FAc85b0bf627288CC3a186dE81A42f1D635;
  uint96 public constant LINK_AMOUNT = 50 ether;

  function execute() external {
    AaveV3Avalanche.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

    uint256 linkAmountWithdrawn = AaveV3Avalanche.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Avalanche.POOL),
        underlying: AaveV3AvalancheAssets.LINKe_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).forceApprove(
      MiscAvalanche.AAVE_CL_ROBOT_OPERATOR,
      linkAmountWithdrawn
    );

    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).register(
      'Caps AGRS Injector',
      AAVE_STEWARD_INJECTOR,
      '',
      5_000_000,
      linkAmountWithdrawn.toUint96(),
      0,
      ''
    );
  }
}
