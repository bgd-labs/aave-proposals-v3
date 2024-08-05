// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708} from './AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV2BaseTest, GuardianUpdateTestParams} from './RenewalV2BaseTest.sol';

/**
 * @dev Test for AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708_Test is RenewalV2BaseTest {
  AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 48662670);
    proposal = new AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_RenewalOfAaveGuardian2024_20240708',
      AaveV2Avalanche.POOL,
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
        newGuardian: proposal.GUARDIAN(),
        addressesProvider: AaveV2Avalanche.POOL_ADDRESSES_PROVIDER,
        poolConfigurator: AaveV2Avalanche.POOL_CONFIGURATOR
      })
    );
  }
}
