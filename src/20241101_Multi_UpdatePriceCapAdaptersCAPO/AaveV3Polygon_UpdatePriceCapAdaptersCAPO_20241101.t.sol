// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {PriceFeeds} from './Constants.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';
import {BasePayloadETHFeedTest} from './BasePayloadETHFeedTest.sol';
import {IERC20Detailed} from 'aave-v3-origin/contracts/dependencies/openzeppelin/contracts/IERC20Detailed.sol';

/**
 * @dev Test for AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  BasePayloadETHFeedTest,
  ProtocolV3TestBase
{
  AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;
  bool switchToV2Oracle;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 71502501);
    proposal = new AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Polygon.POOL,
      address(proposal),
      false
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      AaveV3PolygonAssets.USDC_ORACLE,
      PriceFeeds.POLYGON_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3PolygonAssets.USDCn_UNDERLYING,
      AaveV3PolygonAssets.USDC_ORACLE,
      PriceFeeds.POLYGON_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3PolygonAssets.USDT_UNDERLYING,
      AaveV3PolygonAssets.USDT_ORACLE,
      PriceFeeds.POLYGON_V3_USDT_FEED
    );
    _validateUSDPriceFeed(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      AaveV3PolygonAssets.DAI_ORACLE,
      PriceFeeds.POLYGON_V3_DAI_FEED
    );
    _validateUSDPriceFeed(
      AaveV3PolygonAssets.miMATIC_UNDERLYING,
      AaveV3PolygonAssets.miMATIC_ORACLE,
      PriceFeeds.POLYGON_V3_MIMATIC_FEED
    );

    switchToV2Oracle = true;

    _validateETHPriceFeed(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      AaveV2PolygonAssets.USDC_ORACLE,
      PriceFeeds.POLYGON_V2_USDC_FEED,
      PriceFeeds.POLYGON_V3_USDC_FEED // assetToPeg feed is the same as v3
    );
    _validateETHPriceFeed(
      AaveV2PolygonAssets.USDT_UNDERLYING,
      AaveV2PolygonAssets.USDT_ORACLE,
      PriceFeeds.POLYGON_V2_USDT_FEED,
      PriceFeeds.POLYGON_V3_USDT_FEED
    );
    _validateETHPriceFeed(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      AaveV2PolygonAssets.DAI_ORACLE,
      PriceFeeds.POLYGON_V2_DAI_FEED,
      PriceFeeds.POLYGON_V3_DAI_FEED
    );
  }

  function getAaveOracle()
    public
    virtual
    override(BasePayloadETHFeedTest, BasePayloadUSDFeedTest)
    returns (address)
  {
    if (switchToV2Oracle) {
      return address(AaveV2Polygon.ORACLE);
    } else {
      return address(AaveV3Polygon.ORACLE);
    }
  }
}
