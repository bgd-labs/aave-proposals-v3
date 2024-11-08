// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IAaveOracle} from 'aave-v3-origin/contracts/interfaces/IAaveOracle.sol';
import {IPriceCapAdapterStable} from './interfaces/IPriceCapAdapterStable.sol';

abstract contract BasePayloadUSDFeedTest is Test {
  function _validateUSDPriceFeed(address underlying, address previousFeed, address newFeed) public {
    assertEq(
      IPriceCapAdapterStable(previousFeed).latestAnswer(),
      IPriceCapAdapterStable(newFeed).latestAnswer()
    );
    assertFalse(IPriceCapAdapterStable(newFeed).isCapped());

    assertEq(IAaveOracle(getAaveOracle()).getSourceOfAsset(underlying), newFeed);

    // we expect revert as the previousFeed does not have this method
    vm.expectRevert();
    IPriceCapAdapterStable(previousFeed).getPriceCap();

    // sDAI feed was not a capo feed before, hence this exception
    if (
      keccak256(bytes(IPriceCapAdapterStable(newFeed).description())) !=
      keccak256(bytes('Capped sDAI / DAI / USD'))
    ) {
      assertEq(
        IPriceCapAdapterStable(previousFeed).ASSET_TO_USD_AGGREGATOR(),
        IPriceCapAdapterStable(newFeed).ASSET_TO_USD_AGGREGATOR()
      );
      assertEq(
        IPriceCapAdapterStable(previousFeed).description(),
        IPriceCapAdapterStable(newFeed).description()
      );

      // price cap for all stable capo feed is same except LUSD
      if (
        keccak256(bytes(IPriceCapAdapterStable(newFeed).description())) ==
        keccak256(bytes('Capped LUSD/USD'))
      ) {
        assertEq(IPriceCapAdapterStable(newFeed).getPriceCap(), 1_10000000);
      } else {
        assertEq(IPriceCapAdapterStable(newFeed).getPriceCap(), 1_04000000);
      }
    }
  }

  function getAaveOracle() public virtual returns (address);
}
