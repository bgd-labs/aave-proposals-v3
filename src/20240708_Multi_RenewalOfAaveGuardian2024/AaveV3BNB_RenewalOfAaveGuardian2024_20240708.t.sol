// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';

import 'forge-std/Test.sol';
import {AaveV3BNB_RenewalOfAaveGuardian2024_20240708} from './AaveV3BNB_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';

/**
 * @dev Test for AaveV3BNB_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3BNB_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV3BNB_RenewalOfAaveGuardian2024_20240708_Test is RenewalV3BaseTest {
  AaveV3BNB_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 40951103);
    proposal = new AaveV3BNB_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_RenewalOfAaveGuardian2024_20240708', AaveV3BNB.POOL, address(proposal));
  }

  /**
   * @dev executes the test to check the guardian is updated correctly
   */
  function test_guardianUpdate() public {
    _checkGuardianUpdate(
      GuardianUpdateTestParams({
        proposal: address(proposal),
        oldGuardian: MiscBNB.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3BNB.ACL_MANAGER,
        poolConfigurator: AaveV3BNB.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3BNB.PAYLOADS_CONTROLLER)
      })
    );
  }
}
