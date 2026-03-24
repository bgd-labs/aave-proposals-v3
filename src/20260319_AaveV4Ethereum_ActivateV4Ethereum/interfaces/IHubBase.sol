// SPDX-License-Identifier: LicenseRef-BUSL
pragma solidity ^0.8.0;

interface IHubBase {
  struct PremiumDelta {
    int256 sharesDelta;
    int256 offsetRayDelta;
    uint256 restoredPremiumRay;
  }

  function getAssetId(address underlying) external view returns (uint256);
  function getAssetUnderlyingAndDecimals(uint256 assetId) external view returns (address, uint8);
  function getAssetDrawnIndex(uint256 assetId) external view returns (uint256);
  function getAddedAssets(uint256 assetId) external view returns (uint256);
  function getAddedShares(uint256 assetId) external view returns (uint256);
  function getAssetOwed(uint256 assetId) external view returns (uint256, uint256);
  function getAssetTotalOwed(uint256 assetId) external view returns (uint256);
  function getAssetLiquidity(uint256 assetId) external view returns (uint256);
  function getSpokeAddedAssets(uint256 assetId, address spoke) external view returns (uint256);
  function getSpokeAddedShares(uint256 assetId, address spoke) external view returns (uint256);
  function getSpokeDrawnShares(uint256 assetId, address spoke) external view returns (uint256);
  function getSpokeTotalOwed(uint256 assetId, address spoke) external view returns (uint256);
  function getSpokeOwed(
    uint256 assetId,
    address spoke
  ) external view returns (uint256 drawn, uint256 premium);
  function getSpokePremiumRay(uint256 assetId, address spoke) external view returns (uint256);
  function getSpokePremiumData(
    uint256 assetId,
    address spoke
  ) external view returns (uint256 premiumShares, int256 premiumOffset);
  function getAssetPremiumRay(uint256 assetId) external view returns (uint256);
  function getAssetPremiumData(
    uint256 assetId
  ) external view returns (uint256 premiumShares, int256 premiumOffset);
  function getAssetDrawnShares(uint256 assetId) external view returns (uint256);

  function previewAddByAssets(uint256 assetId, uint256 assets) external view returns (uint256);
  function previewRemoveByAssets(uint256 assetId, uint256 assets) external view returns (uint256);
  function previewDrawByAssets(uint256 assetId, uint256 assets) external view returns (uint256);
  function previewRestoreByAssets(uint256 assetId, uint256 assets) external view returns (uint256);
}
