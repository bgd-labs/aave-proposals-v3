// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Used only by test files in this AIP folder to interact with the Chainlink Automation v2.1
// registry deployed on each chain. Source:
// https://github.com/smartcontractkit/chainlink/blob/contracts-v1.3.0/contracts/src/v0.8/automation/v2_1/KeeperRegistryBase2_1.sol
interface IKeeperRegistry {
  function getCancellationDelay() external view returns (uint256);

  function getLinkAddress() external view returns (address);
}
