// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title CCIPChainTokenAdminRegistries
 * @author Aave Labs
 * @notice CCIP Token Admin Registry for each chain
 * @dev Find all CCIP networks in the CCIP Directory at https://docs.chain.link/ccip/directory/mainnet
 */
library CCIPChainTokenAdminRegistries {
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-arbitrum-1
  address constant ARBITRUM = 0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E;

  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-base-1
  address constant BASE = 0x6f6C373d09C07425BaAE72317863d7F6bb731e37;

  // https://docs.chain.link/ccip/directory/mainnet/chain/mainnet
  address constant ETHEREUM = 0xb22764f98dD05c789929716D677382Df22C05Cb6;

  // https://docs.chain.link/ccip/directory/mainnet/chain/avalanche-mainnet
  address constant AVALANCHE = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;

  // https://docs.chain.link/ccip/directory/mainnet/chain/xdai-mainnet
  address constant GNOSIS = 0x73BC11423CBF14914998C23B0aFC9BE0cb5B2229;

  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-ink-1
  address constant INK = 0xEb062d21c713A3d940BB0FaECFdC387d6Ea23697;
}
