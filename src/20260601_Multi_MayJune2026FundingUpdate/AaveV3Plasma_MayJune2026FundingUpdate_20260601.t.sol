// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Plasma_MayJune2026FundingUpdate_20260601} from './AaveV3Plasma_MayJune2026FundingUpdate_20260601.sol';

/**
 * @dev Test for AaveV3Plasma_MayJune2026FundingUpdate_20260601
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260601_Multi_MayJune2026FundingUpdate/AaveV3Plasma_MayJune2026FundingUpdate_20260601.t.sol -vv
 */
contract AaveV3Plasma_MayJune2026FundingUpdate_20260601_Test is ProtocolV3TestBase {
  AaveV3Plasma_MayJune2026FundingUpdate_20260601 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 23376630);
    proposal = new AaveV3Plasma_MayJune2026FundingUpdate_20260601();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_MayJune2026FundingUpdate_20260601',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_afcAUsdt0Allowance() public {
    address collector = address(AaveV3Plasma.COLLECTOR);
    address spender = MiscPlasma.AFC_SAFE;
    IERC20 token = IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN);
    uint256 allowance = proposal.AFC_SAFE_A_USDT0_ALLOWANCE();

    assertEq(token.allowance(collector, spender), 0, 'unexpected allowance before');

    executePayload(vm, address(proposal));

    assertEq(token.allowance(collector, spender), allowance, 'allowance not set');

    // Verify that funds can be pulled by the spender now.
    // Using a partial transfer because the collector does not have enough funds at the current block.
    uint256 spenderBalanceBefore = token.balanceOf(spender);
    uint256 transferAmount = allowance / 100;
    vm.prank(spender);
    token.transferFrom(collector, spender, transferAmount);

    assertEq(
      token.allowance(collector, spender),
      allowance - transferAmount,
      'allowance did not decrease'
    );
    assertEq(
      token.balanceOf(spender),
      spenderBalanceBefore + transferAmount,
      'spender did not receive tokens'
    );
  }
}
