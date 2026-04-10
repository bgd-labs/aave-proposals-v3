// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFeeSharesMinterBase {
  event ConfigUpdated(address indexed hub, uint256 indexed assetId, uint16 minAccruedFeesPercent);

  error InvalidConfig();
  error ConditionsNotMet();

  function setConfig(address hub, uint256 assetId, uint16 minAccruedFeesPercent) external;

  function performUpkeep(bytes calldata performData) external;

  function checkUpkeep(
    bytes calldata checkData
  ) external view returns (bool upkeepNeeded, bytes memory performData);

  function getConfig(address hub, uint256 assetId) external view returns (uint16);
}
