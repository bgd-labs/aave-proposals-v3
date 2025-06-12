// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320} from './AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320.sol';

/**
 * @dev Test for AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320.t.sol -vv
 */
contract AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320_Test is ProtocolV3TestBase {
  AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 57957473);
    proposal = new AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }
}
