// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAaveCLRobotOperator {
  function register(
    string memory name,
    address upkeepContract,
    bytes calldata upkeepCheckData,
    uint32 gasLimit,
    uint96 amountToFund,
    uint8 triggerType,
    bytes calldata triggerConfig
  ) external returns (uint256);

  function cancel(uint256 id) external;

  function withdrawLink(uint256 id) external;
}
