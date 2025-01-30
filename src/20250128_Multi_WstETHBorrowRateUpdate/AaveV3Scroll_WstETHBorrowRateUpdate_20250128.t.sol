// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_WstETHBorrowRateUpdate_20250128} from './AaveV3Scroll_WstETHBorrowRateUpdate_20250128.sol';

/**
 * @dev Test for AaveV3Scroll_WstETHBorrowRateUpdate_20250128
 * command: FOUNDRY_PROFILE=scroll forge test --match-path=src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3Scroll_WstETHBorrowRateUpdate_20250128.t.sol -vv
 */
contract AaveV3Scroll_WstETHBorrowRateUpdate_20250128_Test is ProtocolV3TestBase {
  AaveV3Scroll_WstETHBorrowRateUpdate_20250128 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 13028907);
    proposal = new AaveV3Scroll_WstETHBorrowRateUpdate_20250128();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_WstETHBorrowRateUpdate_20250128',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }
}
