// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_RiskStewardPhase2_20240805} from './AaveV3Polygon_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3Polygon_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Polygon_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Polygon_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Polygon_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 63655296);
    proposal = new AaveV3Polygon_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Polygon_RiskStewardPhase2_20240805', AaveV3Polygon.POOL, address(proposal));
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Polygon.ACL_MANAGER.isRiskAdmin(AaveV3Polygon.RISK_STEWARD), true);
  }
}
