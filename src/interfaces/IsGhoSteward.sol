// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IsGhoSteward Interface
 * @notice Interface for the sGHO steward contract, which manages the `targetRate` and `supplyCap` of the sGHO contract.
 */
interface IsGhoSteward {
  /**
   * @notice Formula for the `targetRate` (taking into account integer math) is:
   *         `targetRate = amplification * floatRate / AMPLIFICATION_DENOMINATOR + fixedRate`,
   *         where `AMPLIFICATION_DENOMINATOR` is 100_00,
   *         `amplification`, `floatRate` and `fixedRate` are `uint16`
   */
  struct RateConfig {
    /// @notice Amplification factor
    uint16 amplification;
    /// @notice Representative of market conditions
    uint16 floatRate;
    /// @notice Nominal Amount
    uint16 fixedRate;
  }

  /**
   * @dev Event is emitted whenever the `rateConfig` is updated.
   * @param caller Message sender, who initiated the update
   * @param targetRate Target rate set in `sGHO` after update
   * @param amplification Amplification factor used to calculate `targetRate`
   * @param floatRate Float rate used to calculate `targetRate`
   * @param fixedRate Fixed rate used to calculate `targetRate`
   */
  event RateConfigUpdated(
    address indexed caller,
    uint16 targetRate,
    uint16 amplification,
    uint16 floatRate,
    uint16 fixedRate
  );

  /**
   * @dev Event is emitted whenever the `supplyCap` is updated.
   * @param caller Message sender, who initiated the update
   * @param supplyCap Supply Cap set in `sGHO` after update
   */
  event SupplyCapUpdated(address indexed caller, uint256 supplyCap);

  /**
   * @dev Attempted to set zero address.
   */
  error ZeroAddress();

  /**
   * @dev Attempted to set rate greater than `MAX_RATE` defined in `sGHO`.
   */
  error MaxRateExceeded();

  /**
   * @dev Attempted to set the same rate, which is already set.
   */
  error RateUnchanged();

  /**
   * @dev Attempted to set the same supplyCap, which is already set.
   */
  error SupplyCapUnchanged();

  /**
   * @notice Updates `targetRate` on `sGHO` and `rateConfig` inside the steward using new values.
   * @dev `rateConfig_` must be different from the current `rateConfig`, otherwise the function will revert.
   *
   * If the value specified in the `rateConfig_` is identical to the current one, then the `msg.sender` role check will be skipped.
   * Otherwise, it will be assumed that `msg.sender` is trying to update the variable and role check will be performed.
   *
   * For example, `msg.sender` could have 2 roles out of 3, but this does not prevent it from using
   * this function and performing updates to the corresponding variables.
   *
   * To update all parameters at once the caller must have three roles:
   *   - `AMPLIFICATION_MANAGER_ROLE`
   *   - `FLOAT_RATE_MANAGER_ROLE`
   *   - `FIXED_RATE_MANAGER_ROLE`
   *
   * @param rateConfig_ Set of parameters for calculating `targetRate`
   * @return targetRate `targetRate` set in `sGHO`
   */
  function setRateConfig(RateConfig calldata rateConfig_) external returns (uint16);

  /**
   * @notice Updates `supplyCap` on `sGHO`.
   * @dev Could be updated to any `uint160` value, reverts otherwise.
   * Only callable by `SUPPLY_CAP_MANAGER_ROLE`.
   * @param supplyCap_ New `supplyCap` to set.
   */
  function setSupplyCap(uint256 supplyCap_) external;

  /**
   * @notice Calculates `targetRate` using `rateConfig_` struct.
   * @dev Reverts if new `targetRate` exceeds `MAX_RATE`.
   * @param rateConfig_ Set of parameters for calculating `targetRate`
   * @return targetRate result `targetRate`
   */
  function previewTargetRate(RateConfig calldata rateConfig_) external view returns (uint16);

  /**
   * @notice Returns current `rateConfig`.
   */
  function getRateConfig() external view returns (RateConfig memory);

  /**
   * @notice Returns `sGHO` address.
   */
  function sGHO() external view returns (address);

  /**
   * @notice Returns the max `targetRate` that can be set.
   */
  function MAX_RATE() external view returns (uint16);

  /**
   * @notice Returns constant, on which `amplification` is divided by in the formula for calculating `targetRate`.
   */
  function AMPLIFICATION_DENOMINATOR() external view returns (uint16);

  /**
   * @notice Returns role that can update the `amplification` parameter.
   */
  function AMPLIFICATION_MANAGER_ROLE() external view returns (bytes32);

  /**
   * @notice Returns role that can update the `floatRate` parameter.
   */
  function FLOAT_RATE_MANAGER_ROLE() external view returns (bytes32);

  /**
   * @notice Returns role that can update the `fixedRate` parameter.
   */
  function FIXED_RATE_MANAGER_ROLE() external view returns (bytes32);

  /**
   * @notice Returns role that can update the `supplyCap` parameter.
   */
  function SUPPLY_CAP_MANAGER_ROLE() external view returns (bytes32);
}
