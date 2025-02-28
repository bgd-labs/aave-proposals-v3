// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_ClinicStewardActivation_20250228} from './AaveV3ZkSync_ClinicStewardActivation_20250228.sol';

/**
 * @dev Test for AaveV3ZkSync_ClinicStewardActivation_20250228
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250228_Multi_ClinicStewardActivation/AaveV3ZkSync_ClinicStewardActivation_20250228.t.sol -vv
 */
contract AaveV3ZkSync_ClinicStewardActivation_20250228_Test is ProtocolV3TestBase {
  AaveV3ZkSync_ClinicStewardActivation_20250228 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 56750376);
    proposal = new AaveV3ZkSync_ClinicStewardActivation_20250228();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_ClinicStewardActivation_20250228',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }
}
