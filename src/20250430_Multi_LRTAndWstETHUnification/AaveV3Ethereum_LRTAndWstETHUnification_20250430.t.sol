// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_LRTAndWstETHUnification_20250430} from './AaveV3Ethereum_LRTAndWstETHUnification_20250430.sol';

/**
 * @dev Test for AaveV3Ethereum_LRTAndWstETHUnification_20250430
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250430_Multi_LRTAndWstETHUnification/AaveV3Ethereum_LRTAndWstETHUnification_20250430.t.sol -vv
 */
contract AaveV3Ethereum_LRTAndWstETHUnification_20250430_Test is ProtocolV3TestBase {
  AaveV3Ethereum_LRTAndWstETHUnification_20250430 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22446550);
    proposal = new AaveV3Ethereum_LRTAndWstETHUnification_20250430();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_LRTAndWstETHUnification_20250430',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
