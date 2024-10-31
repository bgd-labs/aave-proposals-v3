// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_RiskStewardPhase2_20240805} from './AaveV3Scroll_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3Scroll_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=scroll forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Scroll_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Scroll_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Scroll_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 10688886);
    proposal = new AaveV3Scroll_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Scroll_RiskStewardPhase2_20240805', AaveV3Scroll.POOL, address(proposal));
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Scroll.ACL_MANAGER.isRiskAdmin(AaveV3Scroll.RISK_STEWARD), true);
  }
}
