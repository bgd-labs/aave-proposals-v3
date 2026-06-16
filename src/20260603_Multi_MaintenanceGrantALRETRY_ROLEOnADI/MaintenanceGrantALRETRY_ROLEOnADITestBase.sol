// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGranularGuardianAccessControl} from 'src/interfaces/IGranularGuardian.sol';
import {ISafe} from 'src/interfaces/ISafe.sol';
import {IWithGuardian} from 'solidity-utils/contracts/access-control/interfaces/IWithGuardian.sol';

interface IRetryRoleProposal is IProposalGenericExecutor {
  function AAVE_LABS_GUARDIAN() external view returns (address);
}

/**
 * @dev Common base for the per-chain "Grant AL RETRY_ROLE on a.DI" proposal tests.
 *      Each chain only provides its addresses (via the internal getters below) plus the
 *      fork and proposal deployment; all assertions live here so they stay in sync.
 */
abstract contract MaintenanceGrantALRETRY_ROLEOnADITestBase is ProtocolV3TestBase {
  IRetryRoleProposal internal proposal;

  // expected owners of the Aave Labs guardian Safe (1-of-2), same on every chain
  address internal constant AAVE_LABS_GUARDIAN_OWNER_1 = 0x606dC57cd166643760E049609bfd1D8a698D3bAc;
  address internal constant AAVE_LABS_GUARDIAN_OWNER_2 = 0xbf113Fa52454A94185b65e6f2E818B7f178f937a;

  // ------------------------------------------------------------------------------------------------
  // per-chain inputs
  // ------------------------------------------------------------------------------------------------
  function _createFork() internal virtual;

  function _deployProposal() internal virtual returns (IRetryRoleProposal);

  function _POOL() internal view virtual returns (IPool);

  function _GRANULAR_GUARDIAN() internal view virtual returns (address);

  function _CROSS_CHAIN_CONTROLLER() internal view virtual returns (address);

  function _GOVERNANCE_GUARDIAN() internal view virtual returns (address);

  function _reportName() internal view virtual returns (string memory);

  function setUp() public virtual {
    _createFork();
    proposal = _deployProposal();
  }

  // ------------------------------------------------------------------------------------------------
  // shared tests
  // ------------------------------------------------------------------------------------------------

  /// @dev executes the generic test suite including e2e and config snapshots
  function test_defaultProposalExecution() public virtual {
    defaultTest(_reportName(), _POOL(), address(proposal));
  }

  /// @dev the proposal grants the RETRY_ROLE on the GranularGuardian to the Aave Labs guardian
  function test_role_grant() public {
    IGranularGuardianAccessControl granularGuardian = IGranularGuardianAccessControl(
      _GRANULAR_GUARDIAN()
    );
    bytes32 retryRole = granularGuardian.RETRY_ROLE();
    uint256 countBefore = granularGuardian.getRoleMemberCount(retryRole);
    assertFalse(granularGuardian.hasRole(retryRole, proposal.AAVE_LABS_GUARDIAN()));

    executePayload(vm, address(proposal));

    assertEq(granularGuardian.getRoleMemberCount(retryRole), countBefore + 1);
    assertTrue(granularGuardian.hasRole(retryRole, proposal.AAVE_LABS_GUARDIAN()));
  }

  /// @dev the Aave Labs guardian is the expected 1-of-2 Safe multisig
  function test_aaveLabsGuardianIs1of2Safe() public view {
    ISafe safe = ISafe(proposal.AAVE_LABS_GUARDIAN());
    assertEq(safe.getThreshold(), 1);

    address[] memory owners = safe.getOwners();
    assertEq(owners.length, 2);
    assertEq(owners[0], AAVE_LABS_GUARDIAN_OWNER_1);
    assertEq(owners[1], AAVE_LABS_GUARDIAN_OWNER_2);
  }

  /// @dev the GranularGuardian SOLVE_EMERGENCY_ROLE is held only by the governance guardian
  function test_emergencyRoleOnlyWithGovernanceGuardian() public view {
    IGranularGuardianAccessControl granularGuardian = IGranularGuardianAccessControl(
      _GRANULAR_GUARDIAN()
    );
    bytes32 emergencyRole = granularGuardian.SOLVE_EMERGENCY_ROLE();
    assertEq(granularGuardian.getRoleMemberCount(emergencyRole), 1);
    assertTrue(granularGuardian.hasRole(emergencyRole, _GOVERNANCE_GUARDIAN()));
  }

  /// @dev after the proposal, the GranularGuardian is the CrossChainController guardian
  function test_granularGuardianIsCrossChainControllerGuardian() public {
    executePayload(vm, address(proposal));
    assertEq(IWithGuardian(_CROSS_CHAIN_CONTROLLER()).guardian(), _GRANULAR_GUARDIAN());
  }
}
