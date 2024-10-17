// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {AaveV2EthereumAMM_UpdateLegacyGuardian_20241016} from './AaveV2EthereumAMM_UpdateLegacyGuardian_20241016.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {RenewalV2BaseTest, GuardianUpdateTestParams} from './RenewalV2BaseTest.sol';

/**
 * @dev Test for AaveV2EthereumAMM_UpdateLegacyGuardian_20241016
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241016_Multi_UpdateLegacyGuardian/AaveV2EthereumAMM_UpdateLegacyGuardian_20241016.t.sol -vv
 */
contract AaveV2EthereumAMM_UpdateLegacyGuardian_20241016_Test is RenewalV2BaseTest {
  AaveV2EthereumAMM_UpdateLegacyGuardian_20241016 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20977507);
    proposal = new AaveV2EthereumAMM_UpdateLegacyGuardian_20241016();
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
        addressesProvider: AaveV2EthereumAMM.POOL_ADDRESSES_PROVIDER,
        poolConfigurator: AaveV2EthereumAMM.POOL_CONFIGURATOR
      })
    );
  }
}
