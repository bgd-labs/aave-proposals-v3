// SPDX-License-Identifier: LicenseRef-BUSL
pragma solidity ^0.8.0;

interface IAssetInterestRateStrategy {
  struct InterestRateData {
    uint16 optimalUsageRatio;
    uint32 baseDrawnRate;
    uint32 rateGrowthBeforeOptimal;
    uint32 rateGrowthAfterOptimal;
  }

  function getInterestRateData(uint256 assetId) external view returns (InterestRateData memory);
  function getOptimalUsageRatio(uint256 assetId) external view returns (uint256);
  function getBaseDrawnRate(uint256 assetId) external view returns (uint256);
  function getMaxDrawnRate(uint256 assetId) external view returns (uint256);
  function HUB() external view returns (address);
}
