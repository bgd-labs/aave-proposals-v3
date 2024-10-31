// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {ProtocolV3TestBase} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_RiskStewardPhase2_20240805} from './AaveV3ZkSync_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3ZkSync_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20240805_Multi_RiskStewardPhase2/AaveV3ZkSync_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3ZkSync_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3ZkSync_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 47823875);
    proposal = new AaveV3ZkSync_RiskStewardPhase2_20240805();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite like config snapshots, e2e tests are disabled due to pool not being activated
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_RiskStewardPhase2_20240805',
      AaveV3ZkSync.POOL,
      address(proposal),
      false
    );
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3ZkSync.ACL_MANAGER.isRiskAdmin(AaveV3ZkSync.RISK_STEWARD), true);
  }
}
