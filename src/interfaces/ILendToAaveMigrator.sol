// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILendToAaveMigrator {
  event LendMigrated(address indexed sender, uint256 indexed amount);
  event AaveTokensRescued(address from, address indexed to, uint256 amount);

  error MigrationClosed();
  error ZeroAddress();

  function initialize() external;
  function migrationStarted() external view returns (bool);
  function migrationEnded() external view returns (bool);
  function migrateFromLEND(uint256) external;
}
