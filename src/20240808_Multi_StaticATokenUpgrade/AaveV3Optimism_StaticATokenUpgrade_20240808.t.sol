// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_StaticATokenUpgrade_20240808} from './AaveV3Optimism_StaticATokenUpgrade_20240808.sol';

/**
 * @dev Test for AaveV3Optimism_StaticATokenUpgrade_20240808
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240808_Multi_StaticATokenUpgrade/AaveV3Optimism_StaticATokenUpgrade_20240808.t.sol -vv
 */
contract AaveV3Optimism_StaticATokenUpgrade_20240808_Test is ProtocolV3TestBase {
  AaveV3Optimism_StaticATokenUpgrade_20240808 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 123771299);
    proposal = new AaveV3Optimism_StaticATokenUpgrade_20240808();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_StaticATokenUpgrade_20240808',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
