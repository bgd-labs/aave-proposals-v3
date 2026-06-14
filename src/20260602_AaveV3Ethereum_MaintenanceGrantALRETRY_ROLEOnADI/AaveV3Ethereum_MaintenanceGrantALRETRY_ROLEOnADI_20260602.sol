// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGranularGuardianAccessControl} from 'src/interfaces/IGranularGuardian.sol';
/**
 * @title Maintenance: Grant AL RETRY_ROLE on a.DI
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020
 */
contract AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602 is IProposalGenericExecutor {
  // https://etherscan.io/address/0x4Ab2Bed1d667260dB34244Ba412817651C2dD52b
  address public constant AAVE_LABS_GUARDIAN = 0x4Ab2Bed1d667260dB34244Ba412817651C2dD52b;

  function execute() external {
    IGranularGuardianAccessControl(GovernanceV3Ethereum.GRANULAR_GUARDIAN).grantRole(
      IGranularGuardianAccessControl(GovernanceV3Ethereum.GRANULAR_GUARDIAN).RETRY_ROLE(),
      AAVE_LABS_GUARDIAN
    );
  }
}
