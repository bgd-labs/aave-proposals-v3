// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {Payloads} from './SetPriceCapAdapters_20240227.s.sol';

/**
 * @dev Test for Base payload
 * command: make test-contract filter=AaveV3Base_SetPriceCapAdapters_20240227
 */
contract AaveV3Base_SetPriceCapAdapters_20240227_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 11389477);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_SetPriceCapAdapters_20240227', AaveV3Base.POOL, Payloads.BASE);
  }
}
