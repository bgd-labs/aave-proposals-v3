// SPDX-License-Identifier: agpl-3
pragma solidity ^0.8.0;

/**
 * @title IsGho
 * @notice Interface for sGHO
 */
interface IsGho {
  /**
   * @notice Thrown if the target rate is set to a value greater than the max rate.
   */
  error MaxRateExceeded();

  /**
   * @notice Thrown when a zero address is provided for a critical parameter during initialization.
   */
  error ZeroAddressNotAllowed();

  /**
   * @dev Emitted when the target rate is updated.
   * @param newRate The new target rate.
   */
  event TargetRateUpdated(uint256 newRate);

  /**
   * @dev Emitted when the timestamp and yield index are updated.
   * @param timestamp The timestamp of the update.
   * @param currentRate The current yield index.
   */
  event ExchangeRateUpdated(uint256 timestamp, uint256 currentRate);

  /**
   * @dev Emitted when the supply cap is updated.
   * @param newSupplyCap The new supply cap.
   */
  event SupplyCapUpdated(uint256 newSupplyCap);

  /**
   * @notice Struct for signature parameters.
   * @param v The recovery ID of the signature.
   * @param r The R component of the signature.
   * @param s The S component of the signature.
   */
  struct SignatureParams {
    uint8 v;
    bytes32 r;
    bytes32 s;
  }

  /**
   * @notice Deposits GHO into the vault using permit and mints sGHO shares to the receiver.
   * @dev This function allows users to deposit GHO without requiring a separate approve transaction.
   * The permit is used to approve the vault to spend the user's GHO tokens.
   * The yield index is updated before the deposit to ensure correct share calculation.
   * @param assets The amount of GHO to deposit.
   * @param receiver The address that will receive the sGHO shares.
   * @param deadline Maximum timestamp at which intent can be executed/signature is valid (must be in the future)
   * @param sig A `secp256k1` signature params from `msgSender()`.
   * @return The amount of sGHO shares minted.
   */
  function depositWithPermit(
    uint256 assets,
    address receiver,
    uint256 deadline,
    SignatureParams memory sig
  ) external returns (uint256);

  /**
   * @notice Pauses the contract, can be called by `PAUSE_GUARDIAN_ROLE`.
   * Emits a {Paused} event.
   */
  function pause() external;

  /**
   * @notice Unpauses the contract, can be called by `PAUSE_GUARDIAN_ROLE`.
   * Emits a {Unpaused} event.
   */
  function unpause() external;

  /**
   * @notice Sets the target rate for yield generation.
   * @dev This function can only be called by an address with the YIELD_MANAGER role.
   * The new rate must be less than 50% (5000 basis points).
   * @param newRate The new target rate in basis points (e.g., 1000 for 10%).
   */
  function setTargetRate(uint16 newRate) external;

  /**
   * @notice Sets the supply cap for the vault.
   * @dev This function can only be called by an address with the YIELD_MANAGER role.
   * @dev Supply cap is in asset terms.
   * @param newSupplyCap The new supply cap.
   */
  function setSupplyCap(uint160 newSupplyCap) external;

  /**
   * @notice Returns the maximum safe rate for the vault.
   * @dev Maximum safe annual yield rate in basis points (50%)
   * @return The maximum safe rate.
   */
  function MAX_SAFE_RATE() external view returns (uint16);

  /**
   * @notice Returns the role identifier for the Pause Guardian.
   * @dev This role has permissions to pause/unpause sGho.
   * @return The keccak256 hash of "PAUSE_GUARDIAN_ROLE".
   */
  function PAUSE_GUARDIAN_ROLE() external view returns (bytes32);

  /**
   * @notice Returns the role identifier for the Token Rescuer.
   * @dev This role has permissions to rescue tokens held on the contract.
   * @return The keccak256 hash of "TOKEN_RESCUER_ROLE".
   */
  function TOKEN_RESCUER_ROLE() external view returns (bytes32);

  /**
   * @notice Returns the role identifier for the Yield Manager.
   * @dev This role has permissions to update the target rate.
   * @return The keccak256 hash of "YIELD_MANAGER_ROLE".
   */
  function YIELD_MANAGER_ROLE() external view returns (bytes32);

  /**
   * @notice Returns the address of the GHO token used as the underlying asset in the vault.
   * @return The address of the GHO token.
   */
  function GHO() external view returns (address);

  /**
   * @notice Returns the timestamp of the last time the yield index was updated.
   * @return The Unix timestamp of the last update.
   */
  function lastUpdate() external view returns (uint64);

  /**
   * @notice Returns the current rate per second for yield generation.
   * @dev The rate is expressed in basis points (1% = 100).
   * @return The rate per second multiplied in RAY.
   */
  function ratePerSecond() external view returns (uint96);

  /**
   * @notice Returns the total supply cap of the vault.
   * @dev Supply cap is in asset terms.
   * @return The total supply cap.
   */
  function supplyCap() external view returns (uint160);

  /**
   * @notice Returns the current target annual percentage rate (APR) for yield generation.
   * @dev The rate is expressed in basis points (1% = 100).
   * @return The target rate in basis points.
   */
  function targetRate() external view returns (uint16);

  /**
   * @notice Returns the current yield index, representing the accumulated yield.
   * @dev This index is used to calculate the value of sGHO in terms of GHO. Index scale is in RAY.
   * @return The current yield index.
   */
  function yieldIndex() external view returns (uint176);
}
