// SPDX-License-Identifier: LicenseRef-BUSL
pragma solidity ^0.8.0;

interface IPriceOracle {
  function getReservePrice(uint256 reserveId) external view returns (uint256);
  function decimals() external view returns (uint8);
}
