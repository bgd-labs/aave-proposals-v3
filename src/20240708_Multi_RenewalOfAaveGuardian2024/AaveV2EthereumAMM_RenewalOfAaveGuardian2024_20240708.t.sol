// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';

import 'forge-std/Test.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708} from './AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV2BaseTest, GuardianUpdateTestParams} from './RenewalV2BaseTest.sol';
/**
 * @dev Test for AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708_Test is RenewalV2BaseTest {
  AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20425824);
    proposal = new AaveV2EthereumAMM_RenewalOfAaveGuardian2024_20240708();
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
