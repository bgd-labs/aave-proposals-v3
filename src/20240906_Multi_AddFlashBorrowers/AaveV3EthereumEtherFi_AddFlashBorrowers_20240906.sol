// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumEtherFi} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title add flash borrowers
 * @author Karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-add-cian-protocol-to-flashborrowers/18731
 */
contract AaveV3EthereumEtherFi_AddFlashBorrowers_20240906 is IProposalGenericExecutor {
  address public constant CIAN_FLASH_LOAN_HELPER = 0x49d9409111a6363d82C4371fFa43fAEA660C917B;
  address public constant INDEX_COOP_FLASH_MINT_LEVERAGED =
    0x45c00508C14601fd1C1e296eB3C0e3eEEdCa45D0;
  address public constant CONTANGO_PERMISSIONED_AAVE_WRAPPER =
    0xab515542d621574f9b5212d50593cD0C07e641bD;

  function execute() external {
    AaveV3EthereumEtherFi.ACL_MANAGER.addFlashBorrower(CIAN_FLASH_LOAN_HELPER);
    AaveV3EthereumEtherFi.ACL_MANAGER.addFlashBorrower(INDEX_COOP_FLASH_MINT_LEVERAGED);
    AaveV3EthereumEtherFi.ACL_MANAGER.addFlashBorrower(CONTANGO_PERMISSIONED_AAVE_WRAPPER);
  }
}
