// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @notice Contract interface that allows managing sender nonces.
interface INonceManager {
  /// @notice Increments the outbound nonce for a given sender on a given destination chain.
  /// @param destChainSelector The destination chain selector.
  /// @param sender The sender address.
  /// @return incrementedOutboundNonce The new outbound nonce.
  function getOutboundNonce(
    uint64 destChainSelector,
    address sender
  ) external view returns (uint64);
}
