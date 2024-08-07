// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';

import 'forge-std/Test.sol';
import {AaveV3Scroll_RenewalOfAaveGuardian2024_20240708} from './AaveV3Scroll_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';

/**
 * @dev Test for AaveV3Scroll_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=scroll forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Scroll_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV3Scroll_RenewalOfAaveGuardian2024_20240708_Test is RenewalV3BaseTest {
  AaveV3Scroll_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 7937778);
    proposal = new AaveV3Scroll_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_RenewalOfAaveGuardian2024_20240708',
      AaveV3Scroll.POOL,
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
        oldGuardian: MiscScroll.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Scroll.ACL_MANAGER,
        poolConfigurator: AaveV3Scroll.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Scroll.PAYLOADS_CONTROLLER)
      })
    );
  }
}
