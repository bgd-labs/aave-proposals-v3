// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title AddAdapterAsFlashBorrowerAndRevokePrevious
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV3Optimism_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911 is
  IProposalGenericExecutor
{
  address public constant NEW_FLASH_BORROWER = 0x0000000000000000000000000000000000000001;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
    AaveV3Optimism.ACL_MANAGER.removeFlashBorrower(AaveV3Optimism.DEBT_SWAP_ADAPTER);
  }
}
