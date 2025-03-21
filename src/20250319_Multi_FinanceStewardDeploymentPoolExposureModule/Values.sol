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
    uint256 latestAnswer = IPriceOracleGetter(oracle).getAssetPrice(underlying);
    return (dollarValue * 10 ** (8 + decimals)) / latestAnswer;
  }
}
