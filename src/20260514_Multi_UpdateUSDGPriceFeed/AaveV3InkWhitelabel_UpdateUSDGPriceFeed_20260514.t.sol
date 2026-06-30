// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel, AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {IAaveOracle} from 'aave-address-book/AaveV3.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IChainlinkAggregator} from 'aave-helpers/src/interfaces/IChainlinkAggregator.sol';
import {IPriceCapAdapterStable} from '../interfaces/IPriceCapAdapterStable.sol';
import {AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514} from './AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514.t.sol -vv
 */
contract AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514_Test is ProtocolV3TestBase {
  address internal constant USDG_PRICE_FEED = 0x32b1f1A1D3423dE69cf1f75092eCfDc5090d6624;
  address internal constant USDG_USD_CHAINLINK_FEED = 0xdb3B1fa77CF2c9597f9d4871Bed1Df03D096fdf3;

  AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 48628521);
    proposal = new AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514();
  }

  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514',
      pool: AaveV3InkWhitelabel.POOL,
      payload: address(proposal),
      runE2E: true,
      runSeatbelt: true
    });
  }

  function test_usdgPriceFeedMigratedToCapo() public {
    address before = AaveV3InkWhitelabel.ORACLE.getSourceOfAsset(
      AaveV3InkWhitelabelAssets.USDG_UNDERLYING
    );
    assertEq(before, AaveV3InkWhitelabelAssets.USDG_ORACLE, 'USDG not on the legacy feed');

    GovV3Helpers.executePayload(
      vm,
      address(proposal),
      address(GovV3Helpers.getPayloadsController(AaveV3InkWhitelabel.POOL, block.chainid))
    );

    assertEq(
      AaveV3InkWhitelabel.ORACLE.getSourceOfAsset(AaveV3InkWhitelabelAssets.USDG_UNDERLYING),
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
    GovV3Helpers.executePayload(
      vm,
      address(proposal),
      address(GovV3Helpers.getPayloadsController(AaveV3InkWhitelabel.POOL, block.chainid))
    );

    uint256 price = AaveV3InkWhitelabel.ORACLE.getAssetPrice(
      AaveV3InkWhitelabelAssets.USDG_UNDERLYING
    );
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

  function test_reservesUseNewPriceFeed() public {
    GovV3Helpers.executePayload(
      vm,
      address(proposal),
      address(GovV3Helpers.getPayloadsController(AaveV3InkWhitelabel.POOL, block.chainid))
    );

    _assertReserveUsesFeed(AaveV3InkWhitelabelAssets.USDG_UNDERLYING);
  }

  /// @dev Resolves the oracle from the pool and checks the listed reserve is priced by the new feed.
  function _assertReserveUsesFeed(address asset) internal view {
    assertTrue(
      AaveV3InkWhitelabel.POOL.getReserveData(asset).aTokenAddress != address(0),
      'asset is not a listed reserve'
    );
    IAaveOracle oracle = IAaveOracle(
      AaveV3InkWhitelabel.POOL.ADDRESSES_PROVIDER().getPriceOracle()
    );
    assertEq(oracle.getSourceOfAsset(asset), USDG_PRICE_FEED, 'reserve not priced by the new feed');
    assertGt(oracle.getAssetPrice(asset), 0, 'reserve price is zero');
  }
}
