// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IHubConfigurator {
  function updateSpokeActive(address hub, uint256 assetId, address spoke, bool active) external;
  function deactivateSpoke(address hub, address spoke) external;
}
