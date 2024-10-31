// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon_UpdateLegacyGuardian_20241016} from './AaveV3Polygon_UpdateLegacyGuardian_20241016.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';
/**
 * @dev Test for AaveV3Polygon_UpdateLegacyGuardian_20241016
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20241016_Multi_UpdateLegacyGuardian/AaveV3Polygon_UpdateLegacyGuardian_20241016.t.sol -vv
 */
contract AaveV3Polygon_UpdateLegacyGuardian_20241016_Test is RenewalV3BaseTest {
  AaveV3Polygon_UpdateLegacyGuardian_20241016 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 63104988);
    proposal = new AaveV3Polygon_UpdateLegacyGuardian_20241016();
  }
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_UpdateLegacyGuardian_20241016',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
  /**
   * @dev executes the test to check the guardian is updated correctly
   */
  function test_guardianUpdate() public {
    _checkGuardianUpdate(
      GuardianUpdateTestParams({
        proposal: address(proposal),
        oldGuardian: MiscPolygon.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Polygon.ACL_MANAGER,
        poolConfigurator: AaveV3Polygon.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Polygon.PAYLOADS_CONTROLLER)
      })
    );
  }
}
