// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IPoolConfigurator} from 'aave-v3-origin/contracts/interfaces/IPoolConfigurator.sol';

interface IGhoDirectMinter {
  error InvalidAToken();

  /**
   * @return Returns the pool address managed by the facilitator
   */
  function POOL() external view returns (IPool);

  /**
   * @return Returns the pool address managed by the facilitator
   */
  function POOL_CONFIGURATOR() external view returns (IPoolConfigurator);

  /**
   * @return Returns the collector address that receives the GHO interest
   */
  function COLLECTOR() external view returns (address);

  /**
   * @return Returns the GHO token address
   */
  function GHO() external view returns (address);

  /**
   * @return Returns the GHO a token address
   */
  function GHO_A_TOKEN() external view returns (address);

  /**
   * @dev Mints GHO and supplies it to the pool
   * @param amount Amount of GHO to mint and supply to the pool
   * @notice Due to aave rounding based on the index there might be a small rounding error, which can result in:
   * - receiving slightly more aTokens
   * This error is neglectable and should not have any impact on the system.
   * This method avoid supply cap limitations on the pool, by:
   * memoizing the current supply cap -> setting it to zero(disable) -> supplying -> setting it back to the memoized value.
   */
  function mintAndSupply(uint256 amount) external;

  /**
   * @dev withdraws GHO from the pool and burns it
   * @param amount Amount of GHO to withdraw and burn from the pool
   * @notice Due to aave rounding based on the index there might be a small rounding error, which can result in:
   * - withdrawing slightly less and thus burning slightly less
   * This error is neglectable and should not have any impact on the system.
   */
  function withdrawAndBurn(uint256 amount) external;

  /**
   * @dev Transfers GHO interest to the treasury
   * @notice Due to aave rounding based on the index there might be a small rounding error, which can result in:
   * - transfering slightly more
   * - transfering slightly less
   * This error is neglectable and should not have any impact on the system.
   */
  function transferExcessToTreasury() external;
}
