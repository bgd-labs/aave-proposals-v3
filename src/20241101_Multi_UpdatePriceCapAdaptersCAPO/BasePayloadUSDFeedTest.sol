// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IAaveOracle} from 'aave-v3-origin/contracts/interfaces/IAaveOracle.sol';
import {IPriceCapAdapterStable} from './interfaces/IPriceCapAdapterStable.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

abstract contract BasePayloadUSDFeedTest is Test {
  function _validateUSDPriceFeed(address underlying, address previousFeed, address newFeed) public {
    assertFalse(IPriceCapAdapterStable(newFeed).isCapped());

    assertEq(IAaveOracle(getAaveOracle()).getSourceOfAsset(underlying), newFeed);

    if (previousFeed != AaveV3EthereumAssets.USDS_ORACLE) {
      // we expect revert as the previousFeed does not have this method, USDS is exception
      // as it has this method in prevFeed
      vm.expectRevert();
      IPriceCapAdapterStable(previousFeed).getPriceCap();

      // USDS is exception as we change the underlying feed from DAI/USD to USDS/USD
      assertEq(
        IPriceCapAdapterStable(previousFeed).latestAnswer(),
        IPriceCapAdapterStable(newFeed).latestAnswer()
      );
    }

    // sDAI feed was not a capo feed before, hence this exception
    if (
      keccak256(bytes(IPriceCapAdapterStable(newFeed).description())) !=
      keccak256(bytes('Capped sDAI / DAI / USD'))
    ) {
      if (previousFeed != AaveV3EthereumAssets.USDS_ORACLE) {
        assertEq(
          IPriceCapAdapterStable(previousFeed).ASSET_TO_USD_AGGREGATOR(),
          IPriceCapAdapterStable(newFeed).ASSET_TO_USD_AGGREGATOR()
        );
        assertEq(
          IPriceCapAdapterStable(previousFeed).description(),
          IPriceCapAdapterStable(newFeed).description()
        );
      }

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
