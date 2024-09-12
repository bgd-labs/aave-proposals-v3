// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

/**
 * @title Minimal IBaseParaSwapAdapter
 * @notice Defines the minimal basic interface of ParaSwap adapter
 * @dev Implement this interface to provide functionality of swapping one asset to another asset
 **/
interface IBaseParaSwapAdapter {
  /**
   * @notice Emergency rescue for token stucked on this contract, as failsafe mechanism
   * @dev Funds should never remain in this contract more time than during transactions
   * @dev Only callable by the owner
   * @param token The address of the stucked token to rescue
   */
  function rescueTokens(IERC20 token) external;
}
