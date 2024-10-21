// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base_UpdateLegacyGuardian_20241016} from './AaveV3Base_UpdateLegacyGuardian_20241016.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';
/**
 * @dev Test for AaveV3Base_UpdateLegacyGuardian_20241016
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241016_Multi_UpdateLegacyGuardian/AaveV3Base_UpdateLegacyGuardian_20241016.t.sol -vv
 */
contract AaveV3Base_UpdateLegacyGuardian_20241016_Test is RenewalV3BaseTest {
  AaveV3Base_UpdateLegacyGuardian_20241016 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 21142502);
    proposal = new AaveV3Base_UpdateLegacyGuardian_20241016();
  }
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_UpdateLegacyGuardian_20241016', AaveV3Base.POOL, address(proposal));
  }
  /**
   * @dev executes the test to check the guardian is updated correctly
   */
  function test_guardianUpdate() public {
    _checkGuardianUpdate(
      GuardianUpdateTestParams({
        proposal: address(proposal),
        oldGuardian: MiscBase.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Base.ACL_MANAGER,
        poolConfigurator: AaveV3Base.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Base.PAYLOADS_CONTROLLER)
      })
    );
  }
}
