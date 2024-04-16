// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411} from './AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411.sol';

/**
 * @dev Test for AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411
 * command: make test-contract filter=AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411
 */
contract AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411_Test is
  ProtocolV3TestBase
{
  AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 55697469);
    proposal = new AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_consistentBalances() public {
    uint256 collectorAWmaticBalanceBefore = IERC20(AaveV2PolygonAssets.WMATIC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 collectorWmaticBalanceBefore = IERC20(AaveV2PolygonAssets.WMATIC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    // Validate the Collector has enough aWMatic v2
    assertGe(collectorAWmaticBalanceBefore, proposal.A_WMATIC_AMOUNT_REIMBURSEMENT());

    // Validate the Collector has enough WMATIC
    assertGe(collectorWmaticBalanceBefore, proposal.WMATIC_AMOUNT_REIMBURSEMENT());

    uint256 recipientAWmaticBalanceBefore = IERC20(AaveV2PolygonAssets.WMATIC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientWmaticBalanceBefore = IERC20(AaveV2PolygonAssets.WMATIC_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    uint256 recipientAWmaticBalanceAfter = IERC20(AaveV2PolygonAssets.WMATIC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientWmaticBalanceAfter = IERC20(AaveV2PolygonAssets.WMATIC_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    assertApproxEqAbs(
      recipientAWmaticBalanceAfter,
      recipientAWmaticBalanceBefore + proposal.A_WMATIC_AMOUNT_REIMBURSEMENT(),
      1
    );
    assertApproxEqAbs(
      recipientWmaticBalanceAfter,
      recipientWmaticBalanceBefore + proposal.WMATIC_AMOUNT_REIMBURSEMENT(),
      1
    );

    uint256 collectorAWmaticBalanceAfter = IERC20(AaveV2PolygonAssets.WMATIC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 collectorWmaticBalanceAfter = IERC20(AaveV2PolygonAssets.WMATIC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorAWmaticBalanceAfter,
      collectorAWmaticBalanceBefore - proposal.A_WMATIC_AMOUNT_REIMBURSEMENT(),
      3
    );
    assertApproxEqAbs(
      collectorWmaticBalanceAfter,
      collectorWmaticBalanceBefore - proposal.WMATIC_AMOUNT_REIMBURSEMENT(),
      3
    );
  }
}
