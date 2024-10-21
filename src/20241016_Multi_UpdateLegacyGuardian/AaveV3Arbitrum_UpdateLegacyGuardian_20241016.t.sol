// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import {AaveV3Arbitrum_UpdateLegacyGuardian_20241016} from './AaveV3Arbitrum_UpdateLegacyGuardian_20241016.sol';

import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';

/**
 * @dev Test for AaveV3Arbitrum_UpdateLegacyGuardian_20241016
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241016_Multi_UpdateLegacyGuardian/AaveV3Arbitrum_UpdateLegacyGuardian_20241016.t.sol -vv
 */
contract AaveV3Arbitrum_UpdateLegacyGuardian_20241016_Test is RenewalV3BaseTest {
  AaveV3Arbitrum_UpdateLegacyGuardian_20241016 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 264381013);
    proposal = new AaveV3Arbitrum_UpdateLegacyGuardian_20241016();
  }
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_UpdateLegacyGuardian_20241016',
      AaveV3Arbitrum.POOL,
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
        oldGuardian: MiscArbitrum.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Arbitrum.ACL_MANAGER,
        poolConfigurator: AaveV3Arbitrum.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Arbitrum.PAYLOADS_CONTROLLER)
      })
    );
  }
}
