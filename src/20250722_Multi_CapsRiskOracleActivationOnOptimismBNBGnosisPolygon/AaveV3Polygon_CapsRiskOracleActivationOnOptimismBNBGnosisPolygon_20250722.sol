// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

import {IPegSwap} from './interfaces/IPegSwap.sol';
import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Caps Risk Oracle Activation on Optimism, BNB, Gnosis, Polygon
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/98
 */
contract AaveV3Polygon_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;
  using SafeCast for uint256;

  address public constant EDGE_RISK_STEWARD = 0x35B09a414F6003346cA2E2553b3ea91Cd3524af3;
  address public constant AAVE_STEWARD_INJECTOR = 0x54714FAc85b0bf627288CC3a186dE81A42f1D635;

  address public constant ERC677_LINK = 0xb0897686c545045aFc77CF20eC7A532E3120E0F1;
  uint96 public constant LINK_AMOUNT = 30 ether;

  IPegSwap public constant PEGSWAP = IPegSwap(0xAA1DC356dc4B18f30C347798FD5379F3D77ABC5b);

  function execute() external {
    AaveV3Polygon.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

    // Withdraw aLink to the executor address
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    uint256 linkBalance = IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).balanceOf(address(this));

    // Swap ERC-20 link to ERC-677 link
    IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).forceApprove(address(PEGSWAP), linkBalance);
    PEGSWAP.swap(linkBalance, AaveV3PolygonAssets.LINK_UNDERLYING, ERC677_LINK);

    IERC20(ERC677_LINK).forceApprove(MiscPolygon.AAVE_CL_ROBOT_OPERATOR, linkBalance);
    IAaveCLRobotOperator(MiscPolygon.AAVE_CL_ROBOT_OPERATOR).register(
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
