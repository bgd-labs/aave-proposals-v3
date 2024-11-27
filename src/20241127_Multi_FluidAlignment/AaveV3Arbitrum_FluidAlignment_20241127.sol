// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Fluid Alignment
 * @author ACI
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-fluid-alignment-with-inst-purchase/19921
 */
contract AaveV3Arbitrum_FluidAlignment_20241127 is IProposalGenericExecutor {
  address public constant NEW_FLASH_BORROWER = 0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7;

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
