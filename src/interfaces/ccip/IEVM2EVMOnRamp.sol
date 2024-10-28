// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IInternal} from './IInternal.sol';
interface IEVM2EVMOnRamp {
  /// @notice Gets the next sequence number to be used in the onRamp
  /// @return the next sequence number to be used
  function getExpectedNextSequenceNumber() external view returns (uint64);

  /// @notice Get the next nonce for a given sender
  /// @param sender The sender to get the nonce for
  /// @return nonce The next nonce for the sender
  function getSenderNonce(address sender) external view returns (uint64 nonce);

  /// @notice Adds and removed token pools.
  /// @param removes The tokens and pools to be removed
  /// @param adds The tokens and pools to be added.
  function applyPoolUpdates(
    IInternal.PoolUpdate[] memory removes,
    IInternal.PoolUpdate[] memory adds
  ) external;

  /// @notice Get the pool for a specific token
  /// @param destChainSelector The destination chain selector
  /// @param sourceToken The source chain token to get the pool for
  /// @return pool Token pool
  function getPoolBySourceToken(
    uint64 destChainSelector,
    address sourceToken
  ) external view returns (address);
}
