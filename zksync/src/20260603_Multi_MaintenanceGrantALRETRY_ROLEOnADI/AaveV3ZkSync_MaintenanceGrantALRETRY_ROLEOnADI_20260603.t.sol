// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_MaintenanceGrantALRETRY_ROLEOnADI_20260603} from './AaveV3ZkSync_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {IGranularGuardianAccessControl} from 'src/interfaces/IGranularGuardian.sol';
import {ISafe} from 'src/interfaces/ISafe.sol';
import {IWithGuardian} from 'solidity-utils/contracts/access-control/interfaces/IWithGuardian.sol';

/**
 * @dev Test for AaveV3ZkSync_MaintenanceGrantALRETRY_ROLEOnADI_20260603
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3ZkSync_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol -vv
 */
contract AaveV3ZkSync_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Test is ProtocolV3TestBase {
  AaveV3ZkSync_MaintenanceGrantALRETRY_ROLEOnADI_20260603 internal proposal;
  IGranularGuardianAccessControl internal GRANULAR_GUARDIAN =
    IGranularGuardianAccessControl(GovernanceV3ZkSync.GRANULAR_GUARDIAN);

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 70419537);
    proposal = new AaveV3ZkSync_MaintenanceGrantALRETRY_ROLEOnADI_20260603();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_MaintenanceGrantALRETRY_ROLEOnADI_20260603',
      AaveV3ZkSync.POOL,
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

  function test_aaveLabsGuardianIs1of2Safe() public view {
    ISafe safe = ISafe(proposal.AAVE_LABS_GUARDIAN());
    assertEq(safe.getThreshold(), 1);

    address[] memory owners = safe.getOwners();
    assertEq(owners.length, 2);
    assertEq(owners[0], 0x606dC57cd166643760E049609bfd1D8a698D3bAc);
    assertEq(owners[1], 0xbf113Fa52454A94185b65e6f2E818B7f178f937a);
  }

  function test_emergencyRoleOnlyWithGovernanceGuardian() public view {
    bytes32 emergencyRole = GRANULAR_GUARDIAN.SOLVE_EMERGENCY_ROLE();
    assertEq(GRANULAR_GUARDIAN.getRoleMemberCount(emergencyRole), 1);
    assertTrue(GRANULAR_GUARDIAN.hasRole(emergencyRole, GovernanceV3ZkSync.GOVERNANCE_GUARDIAN));
  }

  function test_granularGuardianIsCrossChainControllerGuardian() public {
    executePayload(vm, address(proposal));
    assertEq(
      IWithGuardian(GovernanceV3ZkSync.CROSS_CHAIN_CONTROLLER).guardian(),
      address(GRANULAR_GUARDIAN)
    );
  }
}
