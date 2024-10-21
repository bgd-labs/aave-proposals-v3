// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {AaveV2Ethereum_UpdateLegacyGuardian_20241016} from './AaveV2Ethereum_UpdateLegacyGuardian_20241016.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {RenewalV2BaseTest, GuardianUpdateTestParams} from './RenewalV2BaseTest.sol';

/**
 * @dev Test for AaveV2Ethereum_UpdateLegacyGuardian_20241016
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241016_Multi_UpdateLegacyGuardian/AaveV2Ethereum_UpdateLegacyGuardian_20241016.t.sol -vv
 */
contract AaveV2Ethereum_UpdateLegacyGuardian_20241016_Test is RenewalV2BaseTest {
  AaveV2Ethereum_UpdateLegacyGuardian_20241016 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20977507);
    proposal = new AaveV2Ethereum_UpdateLegacyGuardian_20241016();
  }
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_UpdateLegacyGuardian_20241016',
      AaveV2Ethereum.POOL,
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
        oldGuardian: MiscEthereum.PROTOCOL_GUARDIAN,
        newGuardian: proposal.GUARDIAN(),
        addressesProvider: AaveV2Ethereum.POOL_ADDRESSES_PROVIDER,
        poolConfigurator: AaveV2Ethereum.POOL_CONFIGURATOR
      })
    );
  }
}
