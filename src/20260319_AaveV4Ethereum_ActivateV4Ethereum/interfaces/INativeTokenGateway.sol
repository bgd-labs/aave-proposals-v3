// SPDX-License-Identifier: LicenseRef-BUSL
pragma solidity ^0.8.0;

interface INativeTokenGateway {
  function supplyNative(
    address spoke,
    uint256 reserveId,
    uint256 amount
  ) external payable returns (uint256, uint256);

  function supplyAsCollateralNative(
    address spoke,
    uint256 reserveId,
    uint256 amount
  ) external payable returns (uint256, uint256);

  function withdrawNative(
    address spoke,
    uint256 reserveId,
    uint256 amount
  ) external returns (uint256, uint256);

  function borrowNative(
    address spoke,
    uint256 reserveId,
    uint256 amount
  ) external returns (uint256, uint256);

  function repayNative(
    address spoke,
    uint256 reserveId,
    uint256 amount
  ) external payable returns (uint256, uint256);

  function NATIVE_TOKEN_WRAPPER() external view returns (address);
}
