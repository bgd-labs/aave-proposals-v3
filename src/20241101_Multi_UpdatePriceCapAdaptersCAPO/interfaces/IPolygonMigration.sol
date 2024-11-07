// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPolygonMigration {
  /// @notice this function allows for migrating MATIC tokens to POL tokens
  /// @param amount amount of MATIC to migrate
  /// @dev the function does not do any validation since the migration is a one-way process
  function migrate(uint256 amount) external;
}
