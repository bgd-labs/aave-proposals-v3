// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGuardianEnabledFlag {
  /// @notice Emitted when `setEnabled()` is called.
  event SetEnabled(address indexed by, bool enable);

  /// @notice Guardian-only, sets `enabled`.
  function setEnabled(bool newEnabled) external;

  /// @notice Whether the AIP is currently authorized to execute.
  function enabled() external view returns (bool);

  /// @notice Address authorized to flip `enabled`.
  function GUARDIAN() external view returns (address);
}
