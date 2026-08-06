// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFixedPriceStrategy4626 {
  function getAssetPriceInGho(uint256 assetAmount, bool roundUp) external view returns (uint256);
  function getGhoPriceInAsset(uint256 ghoAmount, bool roundUp) external view returns (uint256);
}
