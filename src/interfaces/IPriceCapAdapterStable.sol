// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPriceCapAdapterStable {
  function ACL_MANAGER() external view returns (address);
  function ASSET_TO_USD_AGGREGATOR() external view returns (address);
  function getPriceCap() external view returns (int256);
  /// @dev Gated by `CallerIsNotRiskOrPoolAdmin` against the wired ACL_MANAGER.
  function setPriceCap(int256 priceCap) external;
}
