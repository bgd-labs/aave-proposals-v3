// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @notice Minimal IHub interface for FeeSharesMinterBase usage.
interface IHub {
  function mintFeeShares(uint256 assetId) external returns (uint256);
  function getAssetCount() external view returns (uint256);
  function getAssetAccruedFees(uint256 assetId) external view returns (uint256);
  function getAddedAssets(uint256 assetId) external view returns (uint256);
  function getAddedShares(uint256 assetId) external view returns (uint256);
  function previewAddByAssets(uint256 assetId, uint256 assets) external view returns (uint256);
}
