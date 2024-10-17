// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche_UpdateLegacyGuardian_20241016} from './AaveV2Avalanche_UpdateLegacyGuardian_20241016.sol';
import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';
import {RenewalV2BaseTest, GuardianUpdateTestParams} from './RenewalV2BaseTest.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';

/**
 * @dev Test for AaveV2Avalanche_UpdateLegacyGuardian_20241016
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20241016_Multi_UpdateLegacyGuardian/AaveV2Avalanche_UpdateLegacyGuardian_20241016.t.sol -vv
 */
contract AaveV2Avalanche_UpdateLegacyGuardian_20241016_Test is RenewalV2BaseTest {
  AaveV2Avalanche_UpdateLegacyGuardian_20241016 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 51847849);
    proposal = new AaveV2Avalanche_UpdateLegacyGuardian_20241016();
  }
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_UpdateLegacyGuardian_20241016',
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
