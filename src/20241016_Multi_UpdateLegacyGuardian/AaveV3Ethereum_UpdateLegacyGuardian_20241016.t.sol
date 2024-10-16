// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum_UpdateLegacyGuardian_20241016} from './AaveV3Ethereum_UpdateLegacyGuardian_20241016.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';
/**
 * @dev Test for AaveV3Ethereum_UpdateLegacyGuardian_20241016
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241016_Multi_UpdateLegacyGuardian/AaveV3Ethereum_UpdateLegacyGuardian_20241016.t.sol -vv
 */
contract AaveV3Ethereum_UpdateLegacyGuardian_20241016_Test is RenewalV3BaseTest {
  AaveV3Ethereum_UpdateLegacyGuardian_20241016 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20977507);
    proposal = new AaveV3Ethereum_UpdateLegacyGuardian_20241016();
  }
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UpdateLegacyGuardian_20241016',
      AaveV3Ethereum.POOL,
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
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Ethereum.ACL_MANAGER,
        poolConfigurator: AaveV3Ethereum.POOL_CONFIGURATOR,
        governance: address(GovernanceV3Ethereum.GOVERNANCE),
        payloadsController: address(GovernanceV3Ethereum.PAYLOADS_CONTROLLER)
      })
    );
  }
}
