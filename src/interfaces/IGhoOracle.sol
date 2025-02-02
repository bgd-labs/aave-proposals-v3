// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

/**
 * @title IGhoOracle
 * @notice Price feed for GHO (USD denominated)
 * @dev Price fixed at 1 USD, Chainlink format with 8 decimals
 * @author Aave
 */
interface IGhoOracle {
  /**
   * @notice Returns the price of a unit of GHO (USD denominated)
   * @dev GHO price is fixed at 1 USD
   * @return The price of a unit of GHO (with 8 decimals)
   */
  function latestAnswer() external view returns (int256);

  /**
   * @notice Returns the number of decimals the price is formatted with
   * @return The number of decimals
   */
  function decimals() external view returns (uint8);
}
