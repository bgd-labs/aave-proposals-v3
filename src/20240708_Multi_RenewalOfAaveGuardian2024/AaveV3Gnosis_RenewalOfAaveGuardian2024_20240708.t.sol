// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708} from './AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';

/**
 * @dev Test for AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708_Test is RenewalV3BaseTest {
  AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 35244008);
    proposal = new AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_RenewalOfAaveGuardian2024_20240708',
      AaveV3Gnosis.POOL,
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
        oldGuardian: MiscGnosis.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Gnosis.ACL_MANAGER,
        poolConfigurator: AaveV3Gnosis.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Gnosis.PAYLOADS_CONTROLLER)
      })
    );
  }
}
