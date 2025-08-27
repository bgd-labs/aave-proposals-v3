// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title CCIPChainSelectors
 * @author Aave Labs
 * @notice CCIP Chain Selectors for each chain
 * @dev Find all CCIP networks in the CCIP Directory at https://docs.chain.link/ccip/directory/mainnet
 */
library CCIPChainSelectors {
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-arbitrum-1
  uint64 constant ARBITRUM = 4949039107694359620;

  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-base-1
  uint64 constant BASE = 15971525489660198786;

  // https://docs.chain.link/ccip/directory/mainnet/chain/mainnet
  uint64 constant ETHEREUM = 5009297550715157269;

  // https://docs.chain.link/ccip/directory/mainnet/chain/avalanche-mainnet
  uint64 constant AVALANCHE = 6433500567565415381;

  // https://docs.chain.link/ccip/directory/mainnet/chain/xdai-mainnet
  uint64 constant GNOSIS = 465200170687744372;

  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-ink-1
  uint64 constant INK = 3461204551265785888;
}
