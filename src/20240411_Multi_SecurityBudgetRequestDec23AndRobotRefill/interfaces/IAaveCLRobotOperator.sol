// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAaveCLRobotOperator {
  event KeeperRefilled(uint256 indexed id, address indexed from, uint96 indexed amount);

  function refillKeeper(uint256 id, uint96 amount) external;

  function LINK_TOKEN() external returns (address);
}
