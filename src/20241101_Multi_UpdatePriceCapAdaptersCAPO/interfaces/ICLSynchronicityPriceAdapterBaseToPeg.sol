// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICLSynchronicityPriceAdapterBaseToPeg {
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

  /**
   * @notice Price feed for (Base / Peg) pair
   */
  function BASE_TO_PEG() external view returns (address);

  /**
   * @notice Price feed for (Asset / Peg) pair
   */
  function ASSET_TO_PEG() external view returns (address);
}
