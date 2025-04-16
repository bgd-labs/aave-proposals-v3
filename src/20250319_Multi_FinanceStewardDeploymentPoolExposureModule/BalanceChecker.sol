// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IERC20 as IERC20D} from 'forge-std/interfaces/IERC20.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import {Values} from './Values.sol';

contract BalanceChecker is ProtocolV3TestBase {
  function assertBalances(IPool pool, address oracle, address dustBin) internal {
    TestBalance tester = new TestBalance();

    address[] memory reserves = pool.getReservesList();
    uint256 reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];
      address aToken = pool.getReserveAToken(reserve);
      uint256 decimals = IERC20D(reserve).decimals();

      uint256 tokenAmount = Values.getTokenAmountByDollarValue(reserve, oracle, decimals, 100);
      uint256 balanceDustBin = IERC20(aToken).balanceOf(dustBin);

      try tester.isGreaterThanOrEqual(balanceDustBin, tokenAmount) {} catch {
        assertGt(balanceDustBin, 0, 'a token does not have greater than 0 balance in dust bin');
      }
    }
  }
}

contract TestBalance is ProtocolV3TestBase {
  function isGreaterThanOrEqual(uint256 balanceDustBin, uint256 minTokenAmount) public pure {
    assertGe(balanceDustBin, minTokenAmount, 'a token does not have greater than $100 in dust bin');
  }
}
