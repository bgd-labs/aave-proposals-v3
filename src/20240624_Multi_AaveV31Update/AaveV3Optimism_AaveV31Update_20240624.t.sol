// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {Payloads} from './AaveV31Update_20240624.s.sol';

/**
 * @dev Test for AaveV3Optimism_AaveV31Update_20240624
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240624_Multi_AaveV31Update/AaveV3Optimism_AaveV31Update_20240624.t.sol -vv
 */
contract AaveV3Optimism_AaveV31Update_20240624_Test is ProtocolV3TestBase {
  address internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 121808033);
    proposal = Payloads.AaveV3Optimism;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Optimism_AaveV31Update_20240624', AaveV3Optimism.POOL, address(proposal));
  }
}
