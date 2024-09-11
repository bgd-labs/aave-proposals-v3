// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title AddAdapterAsFlashBorrowerAndRevokePrevious
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV3Ethereum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911 is
  IProposalGenericExecutor
{
  address public constant NEW_FLASH_BORROWER = 0x0000000000000000000000000000000000000001;
  address public constant OLD_FLASH_BORROWER = 0x0000000000000000000000000000000000000002;

  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
    AaveV3Ethereum.ACL_MANAGER.removeFlashBorrower(OLD_FLASH_BORROWER);
  }
}
