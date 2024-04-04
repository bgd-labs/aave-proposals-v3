// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGsmFeeStrategy {
  function getBuyFee(uint256 grossAmount) external view returns (uint256);

  function getSellFee(uint256 grossAmount) external view returns (uint256);

  function getGrossAmountFromTotalBought(uint256 totalAmount) external view returns (uint256);

  function getGrossAmountFromTotalSold(uint256 totalAmount) external view returns (uint256);
}
