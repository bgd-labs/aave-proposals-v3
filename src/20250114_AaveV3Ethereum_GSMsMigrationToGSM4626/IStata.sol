// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC4626StataToken {
  /**
   * @notice Deposits underlying and mints static aTokens to msg.sender
   * @param assets The amount of tokens to deposit (e.g. deposit of 100 USDC)
   * @param receiver The address that will receive the static aTokens
   * @return uint256 The amount of StaticAToken minted, static balance
   **/
  function deposit(uint256 assets, address receiver) external returns (uint256);
}
