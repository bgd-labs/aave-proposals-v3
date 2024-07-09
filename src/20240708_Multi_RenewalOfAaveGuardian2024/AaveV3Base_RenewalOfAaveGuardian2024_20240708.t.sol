// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';

import 'forge-std/Test.sol';
import {AaveV3Base_RenewalOfAaveGuardian2024_20240708} from './AaveV3Base_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';

/**
 * @dev Test for AaveV3Base_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Base_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV3Base_RenewalOfAaveGuardian2024_20240708_Test is RenewalV3BaseTest {
  AaveV3Base_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 16837004);
    proposal = new AaveV3Base_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_RenewalOfAaveGuardian2024_20240708',
      AaveV3Base.POOL,
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
        oldGuardian: MiscBase.PROTOCOL_GUARDIAN,
        newGuardian: proposal.NEW_GUARDIAN(),
        aclManager: AaveV3Base.ACL_MANAGER,
        poolConfigurator: AaveV3Base.POOL_CONFIGURATOR
      })
    );
  }
}
