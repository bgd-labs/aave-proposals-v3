// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Gho Steward CCIP Extension
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-extend-gho-stewards-to-arbitrum/18298
 */
contract AaveV3Ethereum_GhoStewardCCIPExtension_20240726 is IProposalGenericExecutor {
  function execute() external {
    // TODO: Assume existing stewards
    // TODO: Revoke roles of other stewards
    // TODO: Grant roles to new stewards
  }
}
