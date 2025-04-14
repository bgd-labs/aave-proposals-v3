// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';

library Values {
  function getTokenAmountByDollarValue(
    address underlying,
    address oracle,
    uint256 decimals,
    uint256 dollarValue
  ) internal view returns (uint256) {
    dollarValue = decimals > 5 ? dollarValue : dollarValue * 10;
    uint256 latestAnswer = IPriceOracleGetter(oracle).getAssetPrice(underlying);
    return (dollarValue * 10 ** (8 + decimals)) / latestAnswer;
  }

  function getTokenAmountByDollarValueEthOracle(
    address underlying,
    address oracle,
    uint256 decimals,
    uint256 dollarValue,
    uint256 ethPrice
  ) internal view returns (uint256) {
    dollarValue = decimals > 5 ? dollarValue : dollarValue * 10;
    uint256 latestAnswer = IPriceOracleGetter(oracle).getAssetPrice(underlying);
    uint256 tokenUsdPrice = (latestAnswer * ethPrice) / (10 ** 18);
    uint256 scaledDollarValue = dollarValue * (10 ** 8);
    return (scaledDollarValue * (10 ** decimals)) / tokenUsdPrice;
  }
}
