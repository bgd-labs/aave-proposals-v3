// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IClient} from 'src/interfaces/ccip/IClient.sol';

interface IUpgradeableLockReleaseTokenPool {
  error BridgeLimitExceeded(uint256 bridgeLimit);

  /// @notice Gets the bridge limit
  /// @return The maximum amount of tokens that can be transferred out to other chains
  function getBridgeLimit() external view returns (uint256);

  /// @notice Sets the bridge limit
  /// @param limit The new limit
  function setBridgeLimit(uint256 limit) external;

  /// @notice Gets the current bridged amount to other chains
  /// @return The amount of tokens transferred out to other chains
  function getCurrentBridgedAmount() external view returns (uint256);

  /// @notice Sets the bridge limit admin address.
  /// @dev Only callable by the owner.
  /// @param bridgeLimitAdmin The new bridge limit admin address.
  function setBridgeLimitAdmin(address bridgeLimitAdmin) external;

  /// @notice Sets the rate limiter admin address.
  /// @dev Only callable by the owner.
  /// @param rateLimitAdmin The new rate limiter admin address.
  function setRateLimitAdmin(address rateLimitAdmin) external;

  /// @notice Gets the bridge limiter admin address.
  function getBridgeLimitAdmin() external view returns (address);

  /// @notice Gets the rate limiter admin address.
  function getRateLimitAdmin() external view returns (address);
}
