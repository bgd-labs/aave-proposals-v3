// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602} from './AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IGranularGuardianAccessControl} from 'src/interfaces/IGranularGuardian.sol';

/**
 * @dev Test for AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260602_AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602.t.sol -vv
 */
contract AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602 internal proposal;
  IGranularGuardianAccessControl internal GRANULAR_GUARDIAN =
    IGranularGuardianAccessControl(GovernanceV3Ethereum.GRANULAR_GUARDIAN);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25230340);
    proposal = new AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_role_grant() public {
    assertEq(GRANULAR_GUARDIAN.getRoleMemberCount(GRANULAR_GUARDIAN.RETRY_ROLE()), 1);
    assertFalse(
      GRANULAR_GUARDIAN.hasRole(GRANULAR_GUARDIAN.RETRY_ROLE(), proposal.AAVE_LABS_GUARDIAN())
    );

    executePayload(vm, address(proposal));

    assertEq(GRANULAR_GUARDIAN.getRoleMemberCount(GRANULAR_GUARDIAN.RETRY_ROLE()), 2);
    assertTrue(
      GRANULAR_GUARDIAN.hasRole(GRANULAR_GUARDIAN.RETRY_ROLE(), proposal.AAVE_LABS_GUARDIAN())
    );
  }
}
