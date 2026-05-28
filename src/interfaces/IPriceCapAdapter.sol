// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorInterface} from 'aave-v3-origin/contracts/dependencies/chainlink/AggregatorInterface.sol';
import {BasicIACLManager} from 'aave-address-book/AaveV3.sol';

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

  /**
   * @notice Returns the capped LST/USD price
   */
  function latestAnswer() external view returns (int256);

  /**
   * @notice Returns whether the current ratio exceeds the snapshot-bounded max ratio
   */
  function isCapped() external view returns (bool);

  function ACL_MANAGER() external view returns (BasicIACLManager);

  function description() external view returns (string memory);

  function decimals() external view returns (uint8);

  function BASE_TO_USD_AGGREGATOR() external view returns (AggregatorInterface);

  function MINIMUM_SNAPSHOT_DELAY() external view returns (uint48);

  function RATIO_DECIMALS() external view returns (uint8);
}
