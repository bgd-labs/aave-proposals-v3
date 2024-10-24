// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IClient} from 'src/interfaces/ccip/IClient.sol';

interface IUpgradeableLockReleaseTokenPool {
  error BridgeLimitExceeded(uint256 bridgeLimit);

  /// @dev Initializer
  /// @dev The address passed as `owner` must accept ownership after initialization.
  /// @dev The `allowlist` is only effective if pool is set to access-controlled mode
  /// @param owner The address of the owner
  /// @param allowlist A set of addresses allowed to trigger lockOrBurn as original senders
  /// @param router The address of the router
  function initialize(address owner, address[] memory allowlist, address router) external;

  /// @dev Ownable
  function owner() external view returns (address);

  /// @notice Sets the bridge limit
  /// @param limit The new limit
  function setBridgeLimit(uint256 limit) external;

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
