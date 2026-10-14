// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISpoke, IAaveOracle} from 'aave-address-book/AaveV4.sol';
import {IPriceFeed} from 'aave-v4/spoke/interfaces/IPriceFeed.sol';
import {AaveV4EthereumSentoraCuratedAssets as Assets, AaveV4EthereumSentoraCuratedSpokePriceFeeds as Feeds} from 'aave-address-book/AaveV4EthereumSentoraCurated.sol';
import {SentoraTestBase} from './SentoraTestBase.sol';

/// @dev Every reserve's price source against the STATE.md oracle audit.
contract SentoraOracles_Test is SentoraTestBase {
  struct SourceSpec {
    ISpoke spoke;
    address underlying;
    address source;
  }

  function setUp() public override {
    super.setUp();
    _activate();
  }

  function test_reserveSources() public view {
    SourceSpec[] memory specs = _specs();
    uint256 reserveCount;
    for (uint256 i; i < specs.length; ++i) {
      IAaveOracle oracle = IAaveOracle(specs[i].spoke.ORACLE());
      uint256 reserveId = _reserveId(specs[i].spoke, specs[i].underlying);
      assertEq(oracle.getReserveSource(reserveId), specs[i].source, 'source');
      assertGt(oracle.getReservePrice(reserveId), 0, 'price');
      assertEq(
        oracle.getReservePrice(reserveId),
        uint256(IPriceFeed(specs[i].source).latestAnswer()),
        'price from source'
      );
      assertEq(IPriceFeed(specs[i].source).decimals(), 8, 'source decimals');
    }
    ISpoke[] memory spokes = _spokes();
    for (uint256 i; i < spokes.length; ++i) {
      reserveCount += spokes[i].getReserveCount();
    }
    assertEq(reserveCount, specs.length, 'every reserve covered');
  }

  function test_usdeOnCappedUsdeAdapter() public view {
    assertEq(
      _source(RLUSD_YIELD, _reserveId(RLUSD_YIELD, Assets.USDe_UNDERLYING)),
      0x8004d13AF906d85997106D92Cec947880191e7Cc,
      'rlusd yield'
    );
    assertEq(
      _source(OUSD_YIELD, _reserveId(OUSD_YIELD, Assets.USDe_UNDERLYING)),
      0x8004d13AF906d85997106D92Cec947880191e7Cc,
      'ousd yield'
    );
  }

  function test_oraclesBoundToSpokes() public view {
    ISpoke[] memory spokes = _spokes();
    for (uint256 i; i < spokes.length; ++i) {
      IAaveOracle oracle = IAaveOracle(spokes[i].ORACLE());
      assertEq(oracle.spoke(), address(spokes[i]), 'oracle spoke');
      assertEq(oracle.decimals(), 8, 'oracle decimals');
    }
  }

  function _specs() internal pure returns (SourceSpec[] memory s) {
    s = new SourceSpec[](14);
    s[0] = SourceSpec(
      RLUSD_YIELD,
      Assets.RLUSD_UNDERLYING,
      Feeds.RLUSD_YIELD_SPOKE_RLUSD_PRICE_FEED
    );
    s[1] = SourceSpec(RLUSD_YIELD, Assets.USDe_UNDERLYING, Feeds.RLUSD_YIELD_SPOKE_USDe_PRICE_FEED);
    s[2] = SourceSpec(
      RLUSD_YIELD,
      Assets.PRIME_UNDERLYING,
      Feeds.RLUSD_YIELD_SPOKE_PRIME_PRICE_FEED
    );
    s[3] = SourceSpec(RLUSD_YIELD, Assets.mWIN_UNDERLYING, Feeds.RLUSD_YIELD_SPOKE_mWIN_PRICE_FEED);
    s[4] = SourceSpec(RLUSD_YIELD, Assets.PST_UNDERLYING, Feeds.RLUSD_YIELD_SPOKE_PST_PRICE_FEED);
    s[5] = SourceSpec(OUSD_YIELD, Assets.OUSD_UNDERLYING, Feeds.OUSD_YIELD_SPOKE_OUSD_PRICE_FEED);
    s[6] = SourceSpec(OUSD_YIELD, Assets.USDe_UNDERLYING, Feeds.OUSD_YIELD_SPOKE_USDe_PRICE_FEED);
    s[7] = SourceSpec(OUSD_YIELD, Assets.PRIME_UNDERLYING, Feeds.OUSD_YIELD_SPOKE_PRIME_PRICE_FEED);
    s[8] = SourceSpec(OUSD_YIELD, Assets.mWIN_UNDERLYING, Feeds.OUSD_YIELD_SPOKE_mWIN_PRICE_FEED);
    s[9] = SourceSpec(OUSD_YIELD, Assets.PST_UNDERLYING, Feeds.OUSD_YIELD_SPOKE_PST_PRICE_FEED);
    s[10] = SourceSpec(BLUECHIP, Assets.RLUSD_UNDERLYING, Feeds.BLUECHIP_SPOKE_RLUSD_PRICE_FEED);
    s[11] = SourceSpec(BLUECHIP, Assets.PYUSD_UNDERLYING, Feeds.BLUECHIP_SPOKE_PYUSD_PRICE_FEED);
    s[12] = SourceSpec(BLUECHIP, Assets.OUSD_UNDERLYING, Feeds.BLUECHIP_SPOKE_OUSD_PRICE_FEED);
    s[13] = SourceSpec(BLUECHIP, Assets.kBTC_UNDERLYING, Feeds.BLUECHIP_SPOKE_kBTC_PRICE_FEED);
  }
}
