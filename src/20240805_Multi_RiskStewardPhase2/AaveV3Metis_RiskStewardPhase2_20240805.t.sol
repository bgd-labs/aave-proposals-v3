// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Metis_RiskStewardPhase2_20240805} from './AaveV3Metis_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3Metis_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=metis forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Metis_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Metis_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Metis_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 18845256);
    proposal = new AaveV3Metis_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Metis_RiskStewardPhase2_20240805', AaveV3Metis.POOL, address(proposal));
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Metis.ACL_MANAGER.isRiskAdmin(AaveV3Metis.RISK_STEWARD), true);
  }
}
