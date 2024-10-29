// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGsm {
  /**
   * @notice Returns the identifier of the Configurator Role
   * @return The bytes32 id hash of the Configurator role
   */
  function CONFIGURATOR_ROLE() external view returns (bytes32);

  /**
   * @notice Returns the exposure limit to the underlying asset
   * @return The maximum amount of underlying asset that can be sold to the GSM
   */
  function getExposureCap() external view returns (uint128);

  /**
   * @notice Returns the Fee Strategy for the GSM
   * @dev It returns 0x0 in case of no fee strategy
   * @return The address of the FeeStrategy
   */
  function getFeeStrategy() external view returns (address);

  /**
   * @dev Grants `role` to `account`.
   *
   * If `account` had not been already granted `role`, emits a {RoleGranted}
   * event.
   *
   * Requirements:
   *
   * - the caller must have ``role``'s admin role.
   */
  function grantRole(bytes32 role, address account) external;

  /**
   * @dev Returns `true` if `account` has been granted `role`.
   */
  function hasRole(bytes32 role, address account) external view returns (bool);

  /**
   * @dev Revokes `role` from `account`.
   *
   * If `account` had been granted `role`, emits a {RoleRevoked} event.
   *
   * Requirements:
   *
   * - the caller must have ``role``'s admin role.
   */
  function revokeRole(bytes32 role, address account) external;
}
