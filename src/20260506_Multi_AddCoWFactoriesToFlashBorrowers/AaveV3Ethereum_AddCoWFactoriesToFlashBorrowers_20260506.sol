// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Add CoW Factories to flashBorrowers
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-whitelist-cow-protocol-adapters-as-flash-borrowers-on-aave-v3/24467
 */
contract AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506 is IProposalGenericExecutor {
  address public constant NEW_FLASH_BORROWER = 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192;

  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
