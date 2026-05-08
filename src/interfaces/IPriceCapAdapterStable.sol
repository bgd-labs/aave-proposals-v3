// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPriceCapAdapterStable {
  function isCapped() external view returns (bool);
  function getPriceCap() external view returns (int256);
  function ASSET_TO_USD_AGGREGATOR() external view returns (address);
}
