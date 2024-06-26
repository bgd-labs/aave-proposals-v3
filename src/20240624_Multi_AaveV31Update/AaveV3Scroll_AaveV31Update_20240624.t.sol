// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {Payloads} from './AaveV31Update_20240624.s.sol';

/**
 * @dev Test for AaveV3Scroll_AaveV31Update_20240624
 * command: FOUNDRY_PROFILE=scroll forge test --match-path=src/20240624_Multi_AaveV31Update/AaveV3Scroll_AaveV31Update_20240624.t.sol -vv
 */
contract AaveV3Scroll_AaveV31Update_20240624_Test is ProtocolV3TestBase {
  address internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 6837096);
    proposal = Payloads.AaveV3Scroll;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Scroll_AaveV31Update_20240624', AaveV3Scroll.POOL, address(proposal));
  }
}
