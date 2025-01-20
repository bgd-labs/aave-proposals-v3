// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGsm {
  /**
   * @notice Returns the identifier of the Configurator Role
   * @return The bytes32 id hash of the Configurator role
   */
  function CONFIGURATOR_ROLE() external view returns (bytes32);

  /**
   * @notice Returns the identifier of the Configurator Role
   * @return The bytes32 id hash of the Configurator role
   */
  function LIQUIDATOR_ROLE() external view returns (bytes32);

  /**
   * @notice Buys the GSM underlying asset in exchange for selling GHO
   * @dev Use `getAssetAmountForBuyAsset` function to calculate the amount based on the GHO amount to sell
   * @param minAmount The minimum amount of the underlying asset to buy
   * @param receiver Recipient address of the underlying asset being purchased
   * @return The amount of underlying asset bought
   * @return The amount of GHO sold by the user
   */
  function buyAsset(uint256 minAmount, address receiver) external returns (uint256, uint256);

  /**
   * @notice Sells the GSM underlying asset in exchange for buying GHO
   * @dev Use `getAssetAmountForSellAsset` function to calculate the amount based on the GHO amount to buy
   * @param maxAmount The maximum amount of the underlying asset to sell
   * @param receiver Recipient address of the GHO being purchased
   * @return The amount of underlying asset sold
   * @return The amount of GHO bought by the user
   */
  function sellAsset(uint256 maxAmount, address receiver) external returns (uint256, uint256);

  /**
   * @notice Seizes all of the underlying asset from the GSM, sending to the Treasury
   * @dev Seizing is a last resort mechanism to provide the Treasury with the entire amount of underlying asset
   * so it can be used to backstop any potential event impacting the functionality of the Gsm.
   * @dev Seizing disables the swap feature
   * @return The amount of underlying asset seized and transferred to Treasury
   */
  function seize() external returns (uint256);

  /**
   * @notice Burns an amount of GHO after seizure reducing the facilitator bucket level effectively
   * @dev Passing an amount higher than the facilitator bucket level will result in burning all minted GHO
   * @dev Only callable if the GSM has assets seized, helpful to wind down the facilitator
   * @param amount The amount of GHO to burn
   * @return The amount of GHO burned
   */
  function burnAfterSeize(uint256 amount) external returns (uint256);

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
