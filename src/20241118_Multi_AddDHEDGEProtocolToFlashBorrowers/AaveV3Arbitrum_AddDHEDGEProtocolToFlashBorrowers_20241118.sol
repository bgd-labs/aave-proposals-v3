// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {FlashBorrowersDataArbitrum} from './FlashBorrowersData.sol';
/**
 * @title Add dHEDGE Protocol to flashBorrowers
 * @author Aave Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-add-dhedge-protocol-to-flashborrowers/19547
 */
contract AaveV3Arbitrum_AddDHEDGEProtocolToFlashBorrowers_20241118 is IProposalGenericExecutor {
  function execute() external {
    address[] memory flashBorrowers = FlashBorrowersDataArbitrum.getFlashBorrowers();
    for (uint i = 0; i < flashBorrowers.length; i++) {
      AaveV3Arbitrum.ACL_MANAGER.addFlashBorrower(flashBorrowers[i]);
    }
  }
}
