// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_RiskStewardPhase2_20240805} from './AaveV3Optimism_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3Optimism_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Optimism_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Optimism_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Optimism_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 127387217);
    proposal = new AaveV3Optimism_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_RiskStewardPhase2_20240805',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Optimism.ACL_MANAGER.isRiskAdmin(AaveV3Optimism.RISK_STEWARD), true);
  }
}
