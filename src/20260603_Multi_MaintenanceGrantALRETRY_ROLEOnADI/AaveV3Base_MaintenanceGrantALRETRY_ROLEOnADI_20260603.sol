// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGranularGuardianAccessControl} from 'src/interfaces/IGranularGuardian.sol';
/**
 * @title Maintenance: Grant AL RETRY_ROLE on a.DI (Part 1)
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020
 */
contract AaveV3Base_MaintenanceGrantALRETRY_ROLEOnADI_20260603 is IProposalGenericExecutor {
  // https://basescan.org/address/0x2B99790c35a401be873FA7Eb514D9220736BB1cA
  address public constant AAVE_LABS_GUARDIAN = 0x2B99790c35a401be873FA7Eb514D9220736BB1cA;

  function execute() external {
    IGranularGuardianAccessControl(GovernanceV3Base.GRANULAR_GUARDIAN).grantRole(
      IGranularGuardianAccessControl(GovernanceV3Base.GRANULAR_GUARDIAN).RETRY_ROLE(),
      AAVE_LABS_GUARDIAN
    );
  }
}
