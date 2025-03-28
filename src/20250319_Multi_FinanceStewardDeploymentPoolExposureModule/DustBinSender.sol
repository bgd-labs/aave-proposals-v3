// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20 as IERC20D} from 'forge-std/interfaces/IERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IPool, ICollector} from 'aave-address-book/AaveV3.sol';

import {Values} from './Values.sol';

contract DustBinSender {
  uint256 public constant MIN_DOLLAR_VALUE = 100;

  function send(IPool pool, ICollector collector, address oracle, address dustBin) internal {
    address[] memory reserves = pool.getReservesList();
    uint256 reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];
      address aToken = pool.getReserveAToken(reserve);
      uint256 decimals = IERC20D(reserve).decimals();

      uint256 tokenAmount = Values.getTokenAmountByDollarValue(
        reserve,
        oracle,
        decimals,
        MIN_DOLLAR_VALUE
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(dustBin);

      if (balanceDustBin < tokenAmount) {
        uint256 balanceCollector = IERC20(aToken).balanceOf(address(collector));

        if (balanceCollector > 0) {
          uint256 toSend = tokenAmount - balanceDustBin;
          collector.transfer(
            IERC20(aToken),
            dustBin,
            balanceCollector >= toSend ? toSend : balanceCollector
          );
        }
      }
    }
  }
}
