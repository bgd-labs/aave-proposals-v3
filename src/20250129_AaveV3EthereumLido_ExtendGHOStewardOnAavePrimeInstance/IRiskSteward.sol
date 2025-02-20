// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IRiskSteward
 * @author BGD labs
 * @notice Defines the interface for the contract to manage the risk params updates on aave v3 pool
 */
interface IRiskSteward {
  /**
   * @notice method to check if an asset/oracle is restricted to be used by the risk stewards
   * @param contractAddress address of the underlying asset or oracle
   * @return bool if asset is restricted or not
   */
  function isAddressRestricted(address contractAddress) external view returns (bool);

  /**
   * @notice method called by the owner to set an asset/oracle as restricted
   * @param contractAddress address of the underlying asset or oracle
   * @param isRestricted true if asset needs to be restricted, false otherwise
   */
  function setAddressRestricted(address contractAddress, bool isRestricted) external;
}
