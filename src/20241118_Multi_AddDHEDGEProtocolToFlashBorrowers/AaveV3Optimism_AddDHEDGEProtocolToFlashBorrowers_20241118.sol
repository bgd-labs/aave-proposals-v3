// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {FlashBorrowersDataOptimism} from './FlashBorrowersData.sol';
/**
 * @title Add dHEDGE Protocol to flashBorrowers
 * @author Aave Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-add-dhedge-protocol-to-flashborrowers/19547
 */
contract AaveV3Optimism_AddDHEDGEProtocolToFlashBorrowers_20241118 is IProposalGenericExecutor {
  function execute() external {
    address[] memory flashBorrowers = FlashBorrowersDataOptimism.getFlashBorrowers();
    for (uint i = 0; i < flashBorrowers.length; i++) {
      AaveV3Optimism.ACL_MANAGER.addFlashBorrower(flashBorrowers[i]);
    }
  }
}
