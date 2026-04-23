// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_AprilFundingUpdate_20260423} from './AaveV3Scroll_AprilFundingUpdate_20260423.sol';

/**
 * @dev Test for AaveV3Scroll_AprilFundingUpdate_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_AprilFundingUpdate/AaveV3Scroll_AprilFundingUpdate_20260423.t.sol -vv
 */
contract AaveV3Scroll_AprilFundingUpdate_20260423_Test is ProtocolV3TestBase {
  AaveV3Scroll_AprilFundingUpdate_20260423 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 33459607);
    proposal = new AaveV3Scroll_AprilFundingUpdate_20260423();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_AprilFundingUpdate_20260423',
      AaveV3Scroll.POOL,
      address(proposal),
      false,
      false
    );
  }

  function test_approvals_weth() public {
    uint256 allowanceBefore = IERC20(AaveV3ScrollAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Scroll.COLLECTOR),
      MiscScroll.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3ScrollAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Scroll.COLLECTOR),
      MiscScroll.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.WETH_ALLOWANCE());
  }

  function test_approvals_usdc() public {
    uint256 allowanceBefore = IERC20(AaveV3ScrollAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Scroll.COLLECTOR),
      MiscScroll.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3ScrollAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Scroll.COLLECTOR),
      MiscScroll.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.USDC_ALLOWANCE());
  }
}
