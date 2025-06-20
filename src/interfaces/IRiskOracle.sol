// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRiskOracle {
  /**
   * @notice Adds a new type of update to the list of authorized update types.
   * @param newUpdateType New type of update to allow.
   */
  function addUpdateType(string memory newUpdateType) external;

  /**
   * @notice Publishes a new risk parameter update.
   * @param referenceId An external reference ID associated with the update.
   * @param newValue The new value of the risk parameter being updated.
   * @param updateType Type of update performed, must be previously authorized.
   * @param market Address for market of the parameter update
   * @param additionalData Additional data for the update
   */
  function publishRiskParameterUpdate(
    string memory referenceId,
    bytes memory newValue,
    string memory updateType,
    address market,
    bytes memory additionalData
  ) external;
}
