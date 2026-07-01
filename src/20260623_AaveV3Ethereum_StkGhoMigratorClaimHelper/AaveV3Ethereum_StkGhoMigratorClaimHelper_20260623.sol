// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IStkGhoMigrator} from '../interfaces/IStkGhoMigrator.sol';

/**
 * @title StkGhoMigratorClaimHelper
 * @author Aave Labs
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-stkgho-sgho-migration-tool/25250
 */
contract AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623 is IProposalGenericExecutor {
  // https://etherscan.io/address/0xC836143e39201698e7d543bCf21AfF3415aE4697
  address public constant STK_GHO_MIGRATOR = 0xC836143e39201698e7d543bCf21AfF3415aE4697;

  function execute() external {
    IStakeToken stkGho = IStakeToken(AaveSafetyModule.STK_GHO);
    stkGho.setPendingAdmin(stkGho.CLAIM_HELPER_ROLE(), STK_GHO_MIGRATOR);
    IStkGhoMigrator(STK_GHO_MIGRATOR).claimHelperRole();
  }
}
