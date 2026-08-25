// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3XLayer} from 'aave-address-book/AaveV3XLayer.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Whitelist X Layer Flash Borrower
 * @author @TokenLogic
 * - Snapshot: direct-to-aip
 * - Discussion: TODO
 */
contract AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821 is IProposalGenericExecutor {
  // https://www.oklink.com/xlayer/address/0xAF1Fe8819F8e953391447A3fD3f27Db5b13b9f4d
  address public constant NEW_FLASH_BORROWER_A = 0xAF1Fe8819F8e953391447A3fD3f27Db5b13b9f4d;
  // https://www.oklink.com/xlayer/address/0x714A871d3B471FF7Ee6A1896B16c5f55884fd910
  address public constant NEW_FLASH_BORROWER_B = 0x714A871d3B471FF7Ee6A1896B16c5f55884fd910;

  function execute() external {
    AaveV3XLayer.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER_A);
    AaveV3XLayer.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER_B);
  }
}
