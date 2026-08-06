// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMainnetSwapSteward {
  /// @notice Returns the budget remaining for a given token
  /// @param token The address of the token to query the budget for
  function tokenBudget(address token) external view returns (uint256);

  /// @notice Increases a token's budget (the maximum that can be swapped from)
  /// @param token The address of the token to increase the budget for
  /// @param budget The extra amount of token that can be swapped from
  function increaseTokenBudget(address token, uint256 budget) external;
}
