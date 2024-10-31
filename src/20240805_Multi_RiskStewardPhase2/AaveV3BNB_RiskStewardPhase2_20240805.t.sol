// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3BNB_RiskStewardPhase2_20240805} from './AaveV3BNB_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3BNB_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3BNB_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3BNB_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3BNB_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 43597598);
    proposal = new AaveV3BNB_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_RiskStewardPhase2_20240805', AaveV3BNB.POOL, address(proposal));
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3BNB.ACL_MANAGER.isRiskAdmin(AaveV3BNB.RISK_STEWARD), true);
  }
}
