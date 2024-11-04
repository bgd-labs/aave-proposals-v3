// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_RiskStewardPhase2_20240805} from './AaveV3Gnosis_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3Gnosis_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Gnosis_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Gnosis_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Gnosis_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 36783528);
    proposal = new AaveV3Gnosis_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Gnosis_RiskStewardPhase2_20240805', AaveV3Gnosis.POOL, address(proposal));
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Gnosis.ACL_MANAGER.isRiskAdmin(AaveV3Gnosis.RISK_STEWARD), true);
  }
}
