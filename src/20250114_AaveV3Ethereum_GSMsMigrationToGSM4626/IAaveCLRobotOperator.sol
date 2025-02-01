// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAaveCLRobotOperator {
  function register(
    string memory name,
    address upkeepContract,
    uint32 gasLimit,
    uint96 amountToFund
  ) external returns (uint256);

  function cancel(uint256 id) external;

  function withdrawLink(uint256 id) external;
}
