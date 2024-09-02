// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRiskSteward {
  /**
   * @notice method called by the owner to set an asset as restricted
   * @param contractAddress address of the underlying asset
   * @param isRestricted true if asset needs to be restricted, false otherwise
   */
  function setAddressRestricted(address contractAddress, bool isRestricted) external;

  /**
   * @notice method to check if an asset is restricted to be used by the risk stewards
   * @param contractAddress address of the underlying asset
   * @return bool if asset is restricted or not
   */
  function isAddressRestricted(address contractAddress) external view returns (bool);
}
