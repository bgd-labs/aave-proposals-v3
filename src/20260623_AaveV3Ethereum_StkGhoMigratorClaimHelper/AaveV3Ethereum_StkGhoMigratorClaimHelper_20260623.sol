// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IStkGhoMigrator} from '../interfaces/IStkGhoMigrator.sol';

/**
 * @title StkGhoMigratorClaimHelper
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623 is IProposalGenericExecutor {
  uint256 public constant CLAIM_HELPER_ROLE = 2;
  address public constant STK_GHO_MIGRATOR = 0xC836143e39201698e7d543bCf21AfF3415aE4697;

  function execute() external {
    IStakeToken(AaveSafetyModule.STK_GHO).setPendingAdmin(CLAIM_HELPER_ROLE, STK_GHO_MIGRATOR);
    IStkGhoMigrator(STK_GHO_MIGRATOR).claimHelperRole();
  }
}
