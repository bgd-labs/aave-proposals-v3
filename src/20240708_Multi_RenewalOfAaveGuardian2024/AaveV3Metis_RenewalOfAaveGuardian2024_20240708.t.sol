// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';

import 'forge-std/Test.sol';
import {AaveV3Metis_RenewalOfAaveGuardian2024_20240708} from './AaveV3Metis_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';

/**
 * @dev Test for AaveV3Metis_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=metis forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Metis_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV3Metis_RenewalOfAaveGuardian2024_20240708_Test is RenewalV3BaseTest {
  AaveV3Metis_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 17882779);
    proposal = new AaveV3Metis_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_RenewalOfAaveGuardian2024_20240708',
      AaveV3Metis.POOL,
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
        oldGuardian: MiscMetis.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Metis.ACL_MANAGER,
        poolConfigurator: AaveV3Metis.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Metis.PAYLOADS_CONTROLLER)
      })
    );
  }
}
