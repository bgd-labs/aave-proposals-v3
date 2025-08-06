// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

interface IPegSwap {
  /**
   * @notice exchanges the source token for target token
   * @param amount count of tokens being swapped
   * @param source the token that is being given
   * @param target the token that is being taken
   */
  function swap(uint256 amount, address source, address target) external;

  /**
   * @notice returns the amount of tokens for a pair that are available to swap
   * @param source the token that is being given
   * @param target the token that is being taken
   * @return amount count of tokens available to swap
   */
  function getSwappableAmount(address source, address target) external view returns (uint);
}
