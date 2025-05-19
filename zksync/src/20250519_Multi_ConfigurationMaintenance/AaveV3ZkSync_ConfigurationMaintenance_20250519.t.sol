// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_ConfigurationMaintenance_20250519} from './AaveV3ZkSync_ConfigurationMaintenance_20250519.sol';

/**
 * @dev Test for AaveV3ZkSync_ConfigurationMaintenance_20250519
 * command: FOUNDRY_PROFILE=test forge test --zksync --match-path=zksync/src/20250519_Multi_ConfigurationMaintenance/AaveV3ZkSync_ConfigurationMaintenance_20250519.t.sol -vv
 */
contract AaveV3ZkSync_ConfigurationMaintenance_20250519_Test is ProtocolV3TestBase {
  AaveV3ZkSync_ConfigurationMaintenance_20250519 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 60633796);
    proposal = new AaveV3ZkSync_ConfigurationMaintenance_20250519();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_ConfigurationMaintenance_20250519',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }
}
