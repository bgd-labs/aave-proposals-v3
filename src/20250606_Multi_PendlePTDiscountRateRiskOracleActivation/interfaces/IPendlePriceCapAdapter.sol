// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPendlePriceCapAdapter {
  /**
   * @notice Returns the current discount rate set for a given asset (should be greater than zero and less than `MAX_DISCOUNT_RATE_PER_YEAR`)
   * @dev The value may exceed 100%, but only if the period to maturity is less than an year
   * @dev The parameter should be set based on the maximum possible APY value of the underlying asset
   * @return discountRatePerYear The discount rate for the asset pricing
   */
  function discountRatePerYear() external view returns (uint64 discountRatePerYear);
}
