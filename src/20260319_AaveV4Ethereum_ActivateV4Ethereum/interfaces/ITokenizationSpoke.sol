// SPDX-License-Identifier: LicenseRef-BUSL
pragma solidity ^0.8.0;

interface ITokenizationSpoke {
  function hub() external view returns (address);
  function assetId() external view returns (uint256);
  function asset() external view returns (address);
  function decimals() external view returns (uint8);

  function deposit(uint256 assets, address receiver) external returns (uint256 shares);
  function mint(uint256 shares, address receiver) external returns (uint256 assets);
  function withdraw(uint256 assets, address receiver, address owner) external returns (uint256);
  function redeem(uint256 shares, address receiver, address owner) external returns (uint256);
  function depositWithPermit(
    uint256 assets,
    address receiver,
    uint256 deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external returns (uint256);

  function previewDeposit(uint256 assets) external view returns (uint256);
  function previewMint(uint256 shares) external view returns (uint256);
  function previewWithdraw(uint256 assets) external view returns (uint256);
  function previewRedeem(uint256 shares) external view returns (uint256);

  function maxDeposit(address receiver) external view returns (uint256);
  function maxWithdraw(address owner) external view returns (uint256);
  function maxRedeem(address owner) external view returns (uint256);

  function totalAssets() external view returns (uint256);
  function totalSupply() external view returns (uint256);
  function convertToShares(uint256 assets) external view returns (uint256);
  function convertToAssets(uint256 shares) external view returns (uint256);
  function balanceOf(address account) external view returns (uint256);
}
