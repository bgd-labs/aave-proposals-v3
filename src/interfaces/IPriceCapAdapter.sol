// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPriceCapAdapter {
  /**
   * @notice Parameters to update price cap
   * @param priceCapParams parameters to set price cap
   */
  struct PriceCapUpdateParams {
    uint104 snapshotRatio;
    uint48 snapshotTimestamp;
    uint16 maxYearlyRatioGrowthPercent;
  }

  /**
   * @notice Updates price cap parameters
   * @param priceCapParams parameters to set price cap
   */
  function setCapParameters(PriceCapUpdateParams memory priceCapParams) external;

  /**
   * @notice Returns the current exchange ratio of lst to the underlying(base) asset
   */
  function getRatio() external view returns (int256);

  /**
   * @notice Returns the latest snapshot ratio
   */
  function getSnapshotRatio() external view returns (uint256);

  /**
   * @notice Returns the latest snapshot timestamp
   */
  function getSnapshotTimestamp() external view returns (uint256);

  /**
   * @notice Returns the max ratio growth per second
   */
  function getMaxRatioGrowthPerSecond() external view returns (uint256);

  /**
   * @notice Returns the max yearly ratio growth
   */
  function getMaxYearlyGrowthRatePercent() external view returns (uint256);
}
