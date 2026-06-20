// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IChainlinkAggregator} from 'aave-helpers/src/interfaces/IChainlinkAggregator.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IPriceCapAdapterStable} from '../interfaces/IPriceCapAdapterStable.sol';
import {AaveV3Ethereum_UpdateUSDGPriceFeed_20260514} from './AaveV3Ethereum_UpdateUSDGPriceFeed_20260514.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdateUSDGPriceFeed_20260514
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260514_AaveV3Ethereum_UpdateUSDGPriceFeed/AaveV3Ethereum_UpdateUSDGPriceFeed_20260514.t.sol -vv
 */
contract AaveV3Ethereum_UpdateUSDGPriceFeed_20260514_Test is ProtocolV3TestBase {
  // New capped Chainlink USDG/USD feed (PriceCapAdapterStable, $1.04 cap).
  address internal constant USDG_PRICE_FEED = 0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4;
  address internal constant USDG_USD_CHAINLINK_FEED = 0x14f0737d6b705259e521EA6E9E3506AC78dBd311;
  // Legacy fixed $1.00 USDG feed this payload retires.
  address internal constant LEGACY_USDG_FEED = 0xF29b1e3b68Fd59DD0a413811fD5d0AbaE653216d;

  AaveV3Ethereum_UpdateUSDGPriceFeed_20260514 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25352820);
    proposal = new AaveV3Ethereum_UpdateUSDGPriceFeed_20260514();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UpdateUSDGPriceFeed_20260514',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_usdgPriceFeedMigratedToCapo() public {
    assertEq(
      AaveV3Ethereum.ORACLE.getSourceOfAsset(AaveV3EthereumAssets.USDG_UNDERLYING),
      LEGACY_USDG_FEED,
      'USDG should start on the legacy fixed feed'
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      AaveV3Ethereum.ORACLE.getSourceOfAsset(AaveV3EthereumAssets.USDG_UNDERLYING),
      USDG_PRICE_FEED,
      'USDG should be repriced to the capped market feed'
    );
  }

  function test_usdgCapoWiringAndBounds() public view {
    IPriceCapAdapterStable capo = IPriceCapAdapterStable(USDG_PRICE_FEED);
    assertEq(IChainlinkAggregator(USDG_PRICE_FEED).decimals(), 8, 'USDG CAPO decimals != 8');
    assertEq(
      capo.ASSET_TO_USD_AGGREGATOR(),
      USDG_USD_CHAINLINK_FEED,
      'USDG CAPO should source the USDG/USD Chainlink feed'
    );
    assertEq(capo.getPriceCap(), int256(1.04e8), 'USDG CAPO price cap should be 1.04');
    assertFalse(capo.isCapped(), 'USDG CAPO should not be capped at current par price');

    int256 price = IChainlinkAggregator(USDG_PRICE_FEED).latestAnswer();
    assertGt(price, int256(0.98e8), 'USDG price below expected lower bound');
    assertLe(price, capo.getPriceCap(), 'USDG price must not exceed the cap');
  }

  function test_usdgOraclePriceReflectsCapo() public {
    assertEq(
      AaveV3Ethereum.ORACLE.getAssetPrice(AaveV3EthereumAssets.USDG_UNDERLYING),
      1e8,
      'legacy feed should price USDG at a fixed 1.00'
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 price = AaveV3Ethereum.ORACLE.getAssetPrice(AaveV3EthereumAssets.USDG_UNDERLYING);
    assertEq(
      price,
      uint256(IChainlinkAggregator(USDG_PRICE_FEED).latestAnswer()),
      'oracle price should equal the CAPO answer'
    );
    assertGt(price, 0.98e8, 'USDG price below expected lower bound');
    assertLe(
      price,
      uint256(IPriceCapAdapterStable(USDG_PRICE_FEED).getPriceCap()),
      'price over cap'
    );
  }
}
