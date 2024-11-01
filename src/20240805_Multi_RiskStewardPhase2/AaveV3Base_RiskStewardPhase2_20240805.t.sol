// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_RiskStewardPhase2_20240805} from './AaveV3Base_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3Base_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Base_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Base_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Base_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 21791615);
    proposal = new AaveV3Base_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_RiskStewardPhase2_20240805', AaveV3Base.POOL, address(proposal));
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Base.ACL_MANAGER.isRiskAdmin(AaveV3Base.RISK_STEWARD), true);
  }
}
