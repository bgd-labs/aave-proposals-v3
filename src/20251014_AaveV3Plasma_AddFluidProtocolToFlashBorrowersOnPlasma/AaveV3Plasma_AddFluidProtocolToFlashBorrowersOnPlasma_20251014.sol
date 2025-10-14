// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Add Fluid Protocol to flashBorrowers on Plasma
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-add-fluid-protocol-to-flashborrowers-on-plasma/23252
 */
contract AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma_20251014 is
  IProposalGenericExecutor
{
  //https://plasmascan.to/address/0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7
  address public constant NEW_FLASH_BORROWER = 0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7;

  function execute() external {
    AaveV3Plasma.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
