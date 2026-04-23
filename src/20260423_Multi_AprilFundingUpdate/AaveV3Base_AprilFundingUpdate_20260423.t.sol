// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_AprilFundingUpdate_20260423} from './AaveV3Base_AprilFundingUpdate_20260423.sol';

/**
 * @dev Test for AaveV3Base_AprilFundingUpdate_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_AprilFundingUpdate/AaveV3Base_AprilFundingUpdate_20260423.t.sol -vv
 */
contract AaveV3Base_AprilFundingUpdate_20260423_Test is ProtocolV3TestBase {
  AaveV3Base_AprilFundingUpdate_20260423 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 45091872);
    proposal = new AaveV3Base_AprilFundingUpdate_20260423();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_AprilFundingUpdate_20260423', AaveV3Base.POOL, address(proposal));
  }

  function test_approvals_weth() public {
    uint256 balanceEthBefore = address(AaveV3Base.COLLECTOR).balance;
    uint256 balanceWethBefore = IERC20(AaveV3BaseAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    assertGt(balanceEthBefore, 0);

    uint256 allowanceBefore = IERC20(AaveV3BaseAssets.WETH_UNDERLYING).allowance(
      address(AaveV3Base.COLLECTOR),
      MiscBase.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 balanceEthAfter = address(AaveV3Base.COLLECTOR).balance;
    uint256 balanceWethAfter = IERC20(AaveV3BaseAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    assertEq(balanceEthAfter, 0);
    assertEq(balanceWethAfter, balanceWethBefore + balanceEthBefore);

    uint256 allowanceAfter = IERC20(AaveV3BaseAssets.WETH_UNDERLYING).allowance(
      address(AaveV3Base.COLLECTOR),
      MiscBase.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.WETH_ALLOWANCE());
  }
}
