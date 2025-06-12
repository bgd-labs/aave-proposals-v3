// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRiskOracle {
  struct RiskParameterUpdate {
    uint256 timestamp; // Timestamp of the update
    bytes newValue; // Encoded parameters, flexible for various data types
    string referenceId; // External reference, potentially linking to a document or off-chain data
    bytes previousValue; // Previous value of the parameter for historical comparison
    string updateType; // Classification of the update for validation purposes
    uint256 updateId; // Unique identifier for this specific update
    address market; // Address for market of the parameter update
    bytes additionalData; // Additional data for the update
  }

  event ParameterUpdated(
    string referenceId,
    bytes newValue,
    bytes previousValue,
    uint256 timestamp,
    string indexed updateType,
    uint256 indexed updateId,
    address indexed market,
    bytes additionalData
  );

  event AuthorizedSenderAdded(address indexed sender);
  event AuthorizedSenderRemoved(address indexed sender);
  event UpdateTypeAdded(string indexed updateType);

  /**
   * @notice Adds a new sender to the list of addresses authorized to perform updates.
   * @param sender Address to be authorized.
   */
  function addAuthorizedSender(address sender) external;

  /**
   * @notice Removes an address from the list of authorized senders.
   * @param sender Address to be unauthorized.
   */
  function removeAuthorizedSender(address sender) external;

  /**
   * @notice Method to fetch the counter which tracks of the total number of updates.
   * @return The latest update counter.
   */
  function updateCounter() external view returns (uint256);

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

  /**
   * @notice Publishes multiple risk parameter updates in a single transaction.
   * @param referenceIds Array of external reference IDs.
   * @param newValues Array of new values for each update.
   * @param updateTypes Array of types for each update, all must be authorized.
   * @param markets Array of addresses for markets of the parameter updates
   * @param additionalData Array of additional data for the updates
   *
   */
  function publishBulkRiskParameterUpdates(
    string[] memory referenceIds,
    bytes[] memory newValues,
    string[] memory updateTypes,
    address[] memory markets,
    bytes[] memory additionalData
  ) external;

  function getAllUpdateTypes() external view returns (string[] memory);

  /**
   * @notice Fetches the most recent update for a specific parameter in a specific market.
   * @param updateType The identifier for the parameter.
   * @param market The market identifier.
   * @return The most recent RiskParameterUpdate for the specified parameter and market.
   */
  function getLatestUpdateByParameterAndMarket(
    string memory updateType,
    address market
  ) external view returns (RiskParameterUpdate memory);

  /*
   * @notice Fetches the update for a provided updateId.
   * @param updateId Update ID.
   * @return The most recent RiskParameterUpdate for the specified id.
   */
  function getUpdateById(uint256 updateId) external view returns (RiskParameterUpdate memory);

  /**
   * @notice Checks if an address is authorized to perform updates.
   * @param sender Address to check.
   * @return Boolean indicating whether the address is authorized.
   */
  function isAuthorized(address sender) external view returns (bool);
}
