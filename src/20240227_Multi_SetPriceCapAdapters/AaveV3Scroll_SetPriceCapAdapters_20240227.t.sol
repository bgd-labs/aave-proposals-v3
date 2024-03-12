// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {Payloads} from './SetPriceCapAdapters_20240227.s.sol';

/**
 * @dev Test for Scroll payload
 * command: make test-contract filter=AaveV3Scroll_SetPriceCapAdapters_20240227
 */
contract AaveV3Scroll_SetPriceCapAdapters_20240227_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 4064118);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Scroll_SetPriceCapAdapters_20240227', AaveV3Scroll.POOL, Payloads.SCROLL);
  }
}
