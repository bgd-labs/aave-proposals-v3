// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Caps Risk Oracle Activation on Optimism, BNB, Gnosis, Polygon
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/98
 */
contract AaveV3Optimism_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;
  using SafeCast for uint256;

  address public constant EDGE_RISK_STEWARD = 0x14a6801DBEBbd6CBE009c10eCFDA98C1c7B89012;
  address public constant AAVE_STEWARD_INJECTOR = 0x54714FAc85b0bf627288CC3a186dE81A42f1D635;

  address public constant LINK_TOKEN = 0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6;
  uint96 public constant LINK_AMOUNT = 30 ether;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

    // Withdraw aLink to the executor address
    AaveV3Optimism.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    uint256 linkBalance = IERC20(AaveV3OptimismAssets.LINK_UNDERLYING).balanceOf(address(this));

    IERC20(LINK_TOKEN).forceApprove(MiscOptimism.AAVE_CL_ROBOT_OPERATOR, linkBalance);
    IAaveCLRobotOperator(MiscOptimism.AAVE_CL_ROBOT_OPERATOR).register(
      'Caps AGRS Injector',
      AAVE_STEWARD_INJECTOR,
      '',
      5_000_000,
      linkBalance.toUint96(),
      0,
      ''
    );
  }
}
