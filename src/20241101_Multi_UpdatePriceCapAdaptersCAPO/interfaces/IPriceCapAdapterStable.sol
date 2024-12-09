// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPriceCapAdapterStable {
  /**
   * @notice Get price cap value
   */
  function getPriceCap() external view returns (int256);

  /**
   * @notice Returns if the price is currently capped
   */
  function isCapped() external view returns (bool);

  /**
   * @notice Price feed for (ASSET / USD) pair
   */
  function ASSET_TO_USD_AGGREGATOR() external view returns (address);

  /**
   * @notice Calculates the current answer based on the aggregators.
   * @return int256 latestAnswer
   */
  function latestAnswer() external view returns (int256);

  /**
   * @notice Returns the description of the feed
   * @return string desciption
   */
  function description() external view returns (string memory);

  /**
   * @notice Returns the feed decimals
   * @return uint8 decimals
   */
  function decimals() external view returns (uint8);
}
