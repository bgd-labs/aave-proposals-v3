// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Base_LRTAndWstETHUnification_20250430} from './AaveV3Base_LRTAndWstETHUnification_20250430.sol';

/**
 * @dev Test for AaveV3Base_LRTAndWstETHUnification_20250430
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250430_Multi_LRTAndWstETHUnification/AaveV3Base_LRTAndWstETHUnification_20250430.t.sol -vv
 */
contract AaveV3Base_LRTAndWstETHUnification_20250430_Test is ProtocolV3TestBase {
  AaveV3Base_LRTAndWstETHUnification_20250430 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 29587769);
    proposal = new AaveV3Base_LRTAndWstETHUnification_20250430();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_LRTAndWstETHUnification_20250430', AaveV3Base.POOL, address(proposal));
  }
}
