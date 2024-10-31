// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_RiskStewardPhase2_20240805} from './AaveV3Avalanche_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3Avalanche_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Avalanche_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Avalanche_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Avalanche_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 52476941);
    proposal = new AaveV3Avalanche_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_RiskStewardPhase2_20240805',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Avalanche.ACL_MANAGER.isRiskAdmin(AaveV3Avalanche.RISK_STEWARD), true);
  }
}
