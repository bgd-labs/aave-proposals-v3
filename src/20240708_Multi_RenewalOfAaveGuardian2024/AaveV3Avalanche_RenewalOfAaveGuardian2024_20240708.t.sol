// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';

import 'forge-std/Test.sol';
import {AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708} from './AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';
/**
 * @dev Test for AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708_Test is RenewalV3BaseTest {
  AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 48662670);
    proposal = new AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_RenewalOfAaveGuardian2024_20240708',
      AaveV3Avalanche.POOL,
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
        oldGuardian: MiscAvalanche.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Avalanche.ACL_MANAGER,
        poolConfigurator: AaveV3Avalanche.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Avalanche.PAYLOADS_CONTROLLER)
      })
    );
  }
}
