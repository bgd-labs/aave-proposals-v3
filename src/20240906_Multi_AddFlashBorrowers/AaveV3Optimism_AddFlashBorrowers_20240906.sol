// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title add flash borrowers
 * @author Karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-add-cian-protocol-to-flashborrowers/18731
 */
contract AaveV3Optimism_AddFlashBorrowers_20240906 is IProposalGenericExecutor {
  address public constant CIAN_FLASH_LOAN_HELPER = 0x49d9409111a6363d82C4371fFa43fAEA660C917B;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.addFlashBorrower(CIAN_FLASH_LOAN_HELPER);
  }
}
