// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603} from './AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol';
import {GovernanceV3Celo} from 'aave-address-book/GovernanceV3Celo.sol';
import {IGranularGuardianAccessControl} from 'src/interfaces/IGranularGuardian.sol';

/**
 * @dev Test for AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol -vv
 */
contract AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Test is ProtocolV3TestBase {
  AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603 internal proposal;
  IGranularGuardianAccessControl internal GRANULAR_GUARDIAN =
    IGranularGuardianAccessControl(GovernanceV3Celo.GRANULAR_GUARDIAN);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('celo'), 68588965);
    proposal = new AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603',
      AaveV3Celo.POOL,
      address(proposal)
    );
  }

  function test_role_grant() public {
    bytes32 retryRole = GRANULAR_GUARDIAN.RETRY_ROLE();
    uint256 countBefore = GRANULAR_GUARDIAN.getRoleMemberCount(retryRole);
    assertFalse(GRANULAR_GUARDIAN.hasRole(retryRole, proposal.AAVE_LABS_GUARDIAN()));

    executePayload(vm, address(proposal));

    assertEq(GRANULAR_GUARDIAN.getRoleMemberCount(retryRole), countBefore + 1);
    assertTrue(GRANULAR_GUARDIAN.hasRole(retryRole, proposal.AAVE_LABS_GUARDIAN()));
  }
}
