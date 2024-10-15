// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGhoBucketSteward {
  /**
   * @notice Checks if a facilitator is controlled by this steward
   * @param facilitator The facilitator address to check
   * @return True if the facilitator is controlled by this steward
   */
  function isControlledFacilitator(address facilitator) external view returns (bool);

  /**
   * @notice Returns the list of controlled facilitators by this steward.
   * @return An array of facilitator addresses
   */
  function getControlledFacilitators() external view returns (address[] memory);

  /**
   * @notice Adds/Removes controlled facilitators
   * @dev Only callable by owner
   * @param facilitatorList A list of facilitators addresses to add to control
   * @param approve True to add as controlled facilitators, false to remove
   */
  function setControlledFacilitator(address[] memory facilitatorList, bool approve) external;
}
