// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IPausable
 * @notice Interface for the Pausable contract
 */
interface IPausable {
  /**
   * @dev Emitted when the pause is triggered by `account`.
   */
  event Paused(address account);

  /**
   * @dev Emitted when the pause is lifted by `account`.
   */
  event Unpaused(address account);

  /**
   * @dev The operation failed because the contract is paused.
   */
  error EnforcedPause();

  /**
   * @dev The operation failed because the contract is not paused.
   */
  error ExpectedPause();

  /**
   * @dev Returns true if the contract is paused, and false otherwise.
   */
  function paused() external view returns (bool);
}
