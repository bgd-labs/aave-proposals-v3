// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

interface IGhoToken {
  function addFacilitator(address, string memory, uint128) external;
  function getFacilitatorBucket(address) external returns (uint256, uint256);
}

/**
 * @title GHO Flash Minter Facilitator Arbitrum
 * @author karpatkey_TokenLogic
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727 is IProposalGenericExecutor {
  uint128 public constant BUCKET_CAPACITY = 2_000_000e18;
  address public constant GHO_FLASH_MINTER = 0x0b6DCf7aeD612128bEc9a61BD5c29b57a7d12795;

  function execute() external {
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).addFacilitator(
      GHO_FLASH_MINTER,
      'FlashMinter Facilitator',
      BUCKET_CAPACITY
    );
  }
}
