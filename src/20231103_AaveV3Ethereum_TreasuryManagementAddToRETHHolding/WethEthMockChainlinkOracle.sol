// SPDX-License-Identifier: MIT
/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/
pragma solidity ^0.8.0;

contract WethEthMockChainlinkOracle {
  /// mocks a WETH/ETH chainlink pricefeed to help with swap
  function latestAnswer() external view returns (int256) {
    return 1 ether;
  }

  function decimals() external view returns (uint8) {
    return 18;
  }
}