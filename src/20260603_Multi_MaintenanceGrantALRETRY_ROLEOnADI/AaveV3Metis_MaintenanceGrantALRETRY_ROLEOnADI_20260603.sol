// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGranularGuardianAccessControl} from 'src/interfaces/IGranularGuardian.sol';
import {IWithGuardian} from 'solidity-utils/contracts/access-control/interfaces/IWithGuardian.sol';
/**
 * @title Maintenance: Grant AL RETRY_ROLE on a.DI (Part 1)
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020
 */
contract AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603 is IProposalGenericExecutor {
  // https://explorer.metis.io/address/0x2B99790c35a401be873FA7Eb514D9220736BB1cA
  address public constant AAVE_LABS_GUARDIAN = 0x2B99790c35a401be873FA7Eb514D9220736BB1cA;

  function execute() external {
    IGranularGuardianAccessControl(GovernanceV3Metis.GRANULAR_GUARDIAN).grantRole(
      IGranularGuardianAccessControl(GovernanceV3Metis.GRANULAR_GUARDIAN).RETRY_ROLE(),
      AAVE_LABS_GUARDIAN
    );

    // on Metis the CrossChainController guardian is still an external multisig, so the
    // GranularGuardian cannot forward retries; every other a.DI network already points to it
    IWithGuardian(GovernanceV3Metis.CROSS_CHAIN_CONTROLLER).updateGuardian(
      GovernanceV3Metis.GRANULAR_GUARDIAN
    );
  }
}
