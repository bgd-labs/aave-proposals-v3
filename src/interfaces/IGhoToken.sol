// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGhoToken {
  struct Facilitator {
    uint128 bucketCapacity;
    uint128 bucketLevel;
    string label;
  }

  function balanceOf(address user) external returns (uint256);

  /**
   * @notice Set the bucket capacity of the facilitator.
   * @dev Only accounts with `BUCKET_MANAGER_ROLE` role can call this function
   * @param facilitator The address of the facilitator
   * @param newCapacity The new capacity of the bucket
   */
  function setFacilitatorBucketCapacity(address facilitator, uint128 newCapacity) external;

  /**
   * @notice Returns the facilitator data
   * @param facilitator The address of the facilitator
   * @return The facilitator configuration
   */
  function getFacilitator(address facilitator) external view returns (Facilitator memory);

  /**
   * @notice Returns the bucket configuration of the facilitator
   * @param facilitator The address of the facilitator
   * @return The capacity of the facilitator's bucket
   * @return The level of the facilitator's bucket
   */
  function getFacilitatorBucket(address facilitator) external view returns (uint256, uint256);

  /**
   * @notice Returns the identifier of the Bucket Manager Role
   * @return The bytes32 id hash of the BucketManager role
   */
  function BUCKET_MANAGER_ROLE() external view returns (bytes32);

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
