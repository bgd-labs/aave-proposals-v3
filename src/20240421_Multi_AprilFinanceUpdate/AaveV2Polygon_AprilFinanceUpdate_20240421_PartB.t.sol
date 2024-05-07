// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

import {AaveV2Polygon_AprilFinanceUpdate_20240421_PartB} from './AaveV2Polygon_AprilFinanceUpdate_20240421_PartB.sol';
import {AaveV2Polygon_AprilFinanceUpdate_20240421} from './AaveV2Polygon_AprilFinanceUpdate_20240421.sol';

/**
 * @dev Test for AaveV2Polygon_AprilFinanceUpdate_20240421_PartB
 * command: make test-contract filter=AaveV2Polygon_AprilFinanceUpdate_20240421_PartB
 */
contract AaveV2Polygon_AprilFinanceUpdate_20240421_PartB_Test is ProtocolV2TestBase {
  event Bridge(address token, uint256 amount);

  AaveV2Polygon_AprilFinanceUpdate_20240421_PartB internal proposal;
  AaveV2Polygon_AprilFinanceUpdate_20240421 internal proposalBefore;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 56654280);
    proposal = new AaveV2Polygon_AprilFinanceUpdate_20240421_PartB();
    proposalBefore = new AaveV2Polygon_AprilFinanceUpdate_20240421();
  }

  function test_canWithdraw() public {
    executePayload(vm, address(proposalBefore));

    vm.expectEmit(true, true, true, true, address(proposal.plasmaBridge()));
    emit Bridge(proposal.NATIVE_MATIC(), 575125293824820370250891);

    executePayload(vm, address(proposal));

    assertEq(IERC20(proposal.NATIVE_MATIC()).balanceOf(address(proposal.plasmaBridge())), 0);
  }

  function test_revertsIf_insufficientBalance() public {
    vm.startPrank(GovernanceV3Polygon.EXECUTOR_LVL_1);
    vm.expectRevert(AaveV2Polygon_AprilFinanceUpdate_20240421_PartB.InsufficientBalance.selector);
    proposal.execute();
  }
}
