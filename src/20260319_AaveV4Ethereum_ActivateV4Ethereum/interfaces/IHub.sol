// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IHub {
  struct SpokeConfig {
    uint40 addCap;
    uint40 drawCap;
    uint24 riskPremiumThreshold;
    bool active;
    bool halted;
  }

  function getAssetCount() external view returns (uint256);
  function getAssetId(address underlying) external view returns (uint256);
  function isSpokeListed(uint256 assetId, address spoke) external view returns (bool);
  function getSpokeCount(uint256 assetId) external view returns (uint256);
  function getSpokeAddress(uint256 assetId, uint256 index) external view returns (address);
  function getSpokeConfig(
    uint256 assetId,
    address spoke
  ) external view returns (SpokeConfig memory);
}
