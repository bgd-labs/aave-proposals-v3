// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Arbitrum_LRTAndWstETHUnification_20250430} from './AaveV3Arbitrum_LRTAndWstETHUnification_20250430.sol';

/**
 * @dev Test for AaveV3Arbitrum_LRTAndWstETHUnification_20250430
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250430_Multi_LRTAndWstETHUnification/AaveV3Arbitrum_LRTAndWstETHUnification_20250430.t.sol -vv
 */
contract AaveV3Arbitrum_LRTAndWstETHUnification_20250430_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_LRTAndWstETHUnification_20250430 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 331579415);
    proposal = new AaveV3Arbitrum_LRTAndWstETHUnification_20250430();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_LRTAndWstETHUnification_20250430',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
