// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';

import 'forge-std/Test.sol';
import {AaveV3Optimism_RenewalOfAaveGuardian2024_20240708} from './AaveV3Optimism_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';

/**
 * @dev Test for AaveV3Optimism_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Optimism_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV3Optimism_RenewalOfAaveGuardian2024_20240708_Test is RenewalV3BaseTest {
  AaveV3Optimism_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 123410917);
    proposal = new AaveV3Optimism_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_RenewalOfAaveGuardian2024_20240708',
      AaveV3Optimism.POOL,
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
        oldGuardian: MiscOptimism.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Optimism.ACL_MANAGER,
        poolConfigurator: AaveV3Optimism.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Optimism.PAYLOADS_CONTROLLER)
      })
    );
  }
}
