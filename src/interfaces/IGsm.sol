// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGsm {
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
   * @notice Buys the GSM underlying asset in exchange for selling GHO, using an EIP-712 signature
   * @dev Use `getAssetAmountForBuyAsset` function to calculate the amount based on the GHO amount to sell
   * @param originator The signer of the request
   * @param minAmount The minimum amount of the underlying asset to buy
   * @param receiver Recipient address of the underlying asset being purchased
   * @param deadline Signature expiration deadline
   * @param signature Signature data
   * @return The amount of underlying asset bought
   * @return The amount of GHO sold by the user
   */
  function buyAssetWithSig(
    address originator,
    uint256 minAmount,
    address receiver,
    uint256 deadline,
    bytes calldata signature
  ) external returns (uint256, uint256);

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
   * @notice Sells the GSM underlying asset in exchange for buying GHO, using an EIP-712 signature
   * @dev Use `getAssetAmountForSellAsset` function to calculate the amount based on the GHO amount to buy
   * @param originator The signer of the request
   * @param maxAmount The maximum amount of the underlying asset to sell
   * @param receiver Recipient address of the GHO being purchased
   * @param deadline Signature expiration deadline
   * @param signature Signature data
   * @return The amount of underlying asset sold
   * @return The amount of GHO bought by the user
   */
  function sellAssetWithSig(
    address originator,
    uint256 maxAmount,
    address receiver,
    uint256 deadline,
    bytes calldata signature
  ) external returns (uint256, uint256);

  /**
   * @notice Rescue and transfer tokens locked in this contract
   * @param token The address of the token
   * @param to The address of the recipient
   * @param amount The amount of token to transfer
   */
  function rescueTokens(address token, address to, uint256 amount) external;

  /**
   * @notice Enable or disable the swap freeze
   * @param enable True to freeze swap functions, false otherwise
   */
  function setSwapFreeze(bool enable) external;

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
   * @notice Updates the address of the Fee Strategy
   * @param feeStrategy The address of the new FeeStrategy
   */
  function updateFeeStrategy(address feeStrategy) external;

  /**
   * @notice Updates the exposure cap of the underlying asset
   * @param exposureCap The new value for the exposure cap (in underlying asset terms)
   */
  function updateExposureCap(uint128 exposureCap) external;

  /**
   * @notice Returns the EIP712 domain separator
   * @return The EIP712 domain separator
   */
  function DOMAIN_SEPARATOR() external view returns (bytes32);

  /**
   * @notice Returns the total amount of GHO, gross amount and fee result of buying assets
   * @param minAssetAmount The minimum amount of underlying asset to buy
   * @return The exact amount of underlying asset to be bought
   * @return The total amount of GHO the user sells (gross amount in GHO plus fee)
   * @return The gross amount of GHO
   * @return The fee amount in GHO, applied on top of gross amount of GHO
   */
  function getGhoAmountForBuyAsset(
    uint256 minAssetAmount
  ) external view returns (uint256, uint256, uint256, uint256);

  /**
   * @notice Returns the total amount of GHO, gross amount and fee result of selling assets
   * @param maxAssetAmount The maximum amount of underlying asset to sell
   * @return The exact amount of underlying asset to sell
   * @return The total amount of GHO the user buys (gross amount in GHO minus fee)
   * @return The gross amount of GHO
   * @return The fee amount in GHO, applied to the gross amount of GHO
   */
  function getGhoAmountForSellAsset(
    uint256 maxAssetAmount
  ) external view returns (uint256, uint256, uint256, uint256);

  /**
   * @notice Returns the amount of underlying asset, gross amount of GHO and fee result of buying assets
   * @param maxGhoAmount The maximum amount of GHO the user provides for buying underlying asset
   * @return The amount of underlying asset the user buys
   * @return The exact amount of GHO the user provides
   * @return The gross amount of GHO corresponding to the given total amount of GHO
   * @return The fee amount in GHO, charged for buying assets
   */
  function getAssetAmountForBuyAsset(
    uint256 maxGhoAmount
  ) external view returns (uint256, uint256, uint256, uint256);

  /**
   * @notice Returns the amount of underlying asset, gross amount of GHO and fee result of selling assets
   * @param minGhoAmount The minimum amount of GHO the user must receive for selling underlying asset
   * @return The amount of underlying asset the user sells
   * @return The exact amount of GHO the user receives in exchange
   * @return The gross amount of GHO corresponding to the given total amount of GHO
   * @return The fee amount in GHO, charged for selling assets
   */
  function getAssetAmountForSellAsset(
    uint256 minGhoAmount
  ) external view returns (uint256, uint256, uint256, uint256);

  /**
   * @notice Returns the remaining GSM exposure capacity
   * @return The amount of underlying asset that can be sold to the GSM
   */
  function getAvailableUnderlyingExposure() external view returns (uint256);

  /**
   * @notice Returns the exposure limit to the underlying asset
   * @return The maximum amount of underlying asset that can be sold to the GSM
   */
  function getExposureCap() external view returns (uint128);

  /**
   * @notice Returns the actual underlying asset balance immediately available in the GSM
   * @return The amount of underlying asset that can be bought from the GSM
   */
  function getAvailableLiquidity() external view returns (uint256);

  /**
   * @notice Returns the Fee Strategy for the GSM
   * @dev It returns 0x0 in case of no fee strategy
   * @return The address of the FeeStrategy
   */
  function getFeeStrategy() external view returns (address);

  /**
   * @notice Returns the amount of current accrued fees
   * @dev It does not factor in potential fees that can be accrued upon distribution of fees
   * @return The amount of accrued fees
   */
  function getAccruedFees() external view returns (uint256);

  /**
   * @notice Returns the freeze status of the GSM
   * @return True if frozen, false if not
   */
  function getIsFrozen() external view returns (bool);

  /**
   * @notice Returns the current seizure status of the GSM
   * @return True if the GSM has been seized, false if not
   */
  function getIsSeized() external view returns (bool);

  /**
   * @notice Returns whether or not swaps via buyAsset/sellAsset are currently possible
   * @return True if the GSM has swapping enabled, false otherwise
   */
  function canSwap() external view returns (bool);

  /**
   * @notice Returns the GSM revision number
   * @return The revision number
   */
  function GSM_REVISION() external pure returns (uint256);

  /**
   * @notice Returns the address of the GHO token
   * @return The address of GHO token contract
   */
  function GHO_TOKEN() external view returns (address);

  /**
   * @notice Returns the underlying asset of the GSM
   * @return The address of the underlying asset
   */
  function UNDERLYING_ASSET() external view returns (address);

  /**
   * @notice Returns the price strategy of the GSM
   * @return The address of the price strategy
   */
  function PRICE_STRATEGY() external view returns (address);

  /**
   * @notice Returns the current nonce (for EIP-712 signature methods) of an address
   * @param user The address of the user
   * @return The current nonce of the user
   */
  function nonces(address user) external view returns (uint256);

  /**
   * @notice Returns the identifier of the Configurator Role
   * @return The bytes32 id hash of the Configurator role
   */
  function CONFIGURATOR_ROLE() external pure returns (bytes32);

  /**
   * @notice Returns the identifier of the Token Rescuer Role
   * @return The bytes32 id hash of the TokenRescuer role
   */
  function TOKEN_RESCUER_ROLE() external pure returns (bytes32);

  /**
   * @notice Returns the identifier of the Swap Freezer Role
   * @return The bytes32 id hash of the SwapFreezer role
   */
  function SWAP_FREEZER_ROLE() external pure returns (bytes32);

  /**
   * @notice Returns the identifier of the Liquidator Role
   * @return The bytes32 id hash of the Liquidator role
   */
  function LIQUIDATOR_ROLE() external pure returns (bytes32);

  /**
   * @notice Returns the EIP-712 signature typehash for buyAssetWithSig
   * @return The bytes32 signature typehash for buyAssetWithSig
   */
  function BUY_ASSET_WITH_SIG_TYPEHASH() external pure returns (bytes32);

  /**
   * @notice Returns the EIP-712 signature typehash for sellAssetWithSig
   * @return The bytes32 signature typehash for sellAssetWithSig
   */
  function SELL_ASSET_WITH_SIG_TYPEHASH() external pure returns (bytes32);

  /**
   * @notice Distribute fees to the GhoTreasury
   */
  function distributeFeesToTreasury() external;

  /**
   * @notice Returns the address of the Gho Treasury
   * @return The address of the GhoTreasury contract
   */
  function getGhoTreasury() external view returns (address);

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
