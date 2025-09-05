// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title CCIPChainRouters
 * @author Aave Labs
 * @notice CCIP Routers for each chain
 * @dev Find all CCIP networks in the CCIP Directory at https://docs.chain.link/ccip/directory/mainnet
 */
library CCIPChainRouters {
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-arbitrum-1
  address constant ARBITRUM = 0x141fa059441E0ca23ce184B6A78bafD2A517DdE8;

  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-base-1
  address constant BASE = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;

  // https://docs.chain.link/ccip/directory/mainnet/chain/mainnet
  address constant ETHEREUM = 0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D;

  // https://docs.chain.link/ccip/directory/mainnet/chain/avalanche-mainnet
  address constant AVALANCHE = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;

  // https://docs.chain.link/ccip/directory/mainnet/chain/xdai-mainnet
  address constant GNOSIS = 0x4aAD6071085df840abD9Baf1697d5D5992bDadce;

  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-ink-1
  address constant INK = 0xca7c90A52B44E301AC01Cb5EB99b2fD99339433A;
}
