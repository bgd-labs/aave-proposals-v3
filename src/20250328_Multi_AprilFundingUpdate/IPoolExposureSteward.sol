// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ICollector} from 'aave-helpers/src/CollectorUtils.sol';

interface IPoolExposureSteward {
  /// @dev Provided address cannot be the zero-address
  error InvalidZeroAddress();

  /// @dev Provided arrays do not have the same length
  error MismatchingArrayLength();

  /// @dev Aave Pool must have been previously approved
  error UnrecognizedPool();

  /// @notice Emitted when a new V2 Pool gets listed
  /// @param pool The address of the new pool
  event ApprovedV2Pool(address indexed pool);

  /// @notice Emitted when a new V3 Pool gets listed
  /// @param pool The address of the new pool
  event ApprovedV3Pool(address indexed pool);

  /// @notice Emitted when a V2 Pool gets removed
  /// @param pool The address of the revoked pool
  event RevokedV2Pool(address indexed pool);

  /// @notice Emitted when a V3 Pool gets removed
  /// @param pool The address of the revoked pool
  event RevokedV3Pool(address indexed pool);

  /// @notice Returns instance of Aave V3 Collector
  function COLLECTOR() external view returns (ICollector);

  /// @notice Returns whether pool is approved to be used
  /// @param poolV2 Address of the Aave V3 Pool
  function approvedV2Pools(address poolV2) external view returns (bool);

  /// @notice Returns whether pool is approved to be used
  /// @param poolV3 Address of the Aave V3 Pool
  function approvedV3Pools(address poolV3) external view returns (bool);

  /// @notice Deposits a specified amount of a reserve token into Aave V3
  /// @param pool The address of the V3 Pool to deposit into
  /// @param reserve The address of the reserve token
  /// @param amount The amount of the reserve token to deposit
  function depositV3(address pool, address reserve, uint256 amount) external;

  /// @notice Withdraws a specified amount of a reserve token from Aave V2
  /// @param pool The address of the V2 Pool to withdraw from
  /// @param reserve The address of the reserve token to withdraw
  /// @param amount The amount of the reserve token to withdraw
  function withdrawV2(address pool, address reserve, uint256 amount) external;

  /// @notice Withdraws a specified amount of a reserve token from Aave V3
  /// @param V3Pool The address of the V3 pool to withdraw from
  /// @param underlying The address of the reserve token to withdraw
  /// @param amount The amount of the reserve token to withdraw
  function withdrawV3(address V3Pool, address underlying, uint256 amount) external;

  /// @notice Migrates a specified amount of a reserve token from Aave V2 to Aave V3
  /// @param v2Pool The address of the origin V2 Pool
  /// @param v3Pool The address of the destination V3 Pool
  /// @param underlying The address of the reserve token
  /// @param amount The amount of the reserve token to migrate
  function migrateV2toV3(
    address v2Pool,
    address v3Pool,
    address underlying,
    uint256 amount
  ) external;

  /// @notice Migrates a specified amount of a reserve token from an Aave V3 instance to another
  /// @param fromPool The address of the origin V3 Pool
  /// @param toPool The address of the destination V3 Pool
  /// @param underlying The address of the reserve token
  /// @param amount The amount of the reserve token to migrate
  function migrateBetweenV3(
    address fromPool,
    address toPool,
    address underlying,
    uint256 amount
  ) external;

  /// @notice Approves the permission to use a new pool
  /// @param pool Address of the new Pool
  /// @param version3 True if new pool is a V3 instance
  function approvePool(address pool, bool version3) external;

  /// @notice Revokes the permission to use a pool
  /// @param pool Address of the Pool to remove
  /// @param version3 True if new pool is a V3 instance
  function revokePool(address pool, bool version3) external;

  /// @notice Rescues the specified token back to the Collector
  /// @param token The address of the ERC20 token to rescue
  function rescueToken(address token) external;

  /// @notice Rescues ETH from the contract back to the Collector
  function rescueEth() external;
}
