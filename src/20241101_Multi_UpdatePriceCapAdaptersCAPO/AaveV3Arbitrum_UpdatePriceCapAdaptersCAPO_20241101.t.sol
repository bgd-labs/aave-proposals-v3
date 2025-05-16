// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @dev Test for AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 336562426);
    proposal = new AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      AaveV3ArbitrumAssets.USDC_ORACLE,
      PriceFeeds.ARBITRUM_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3ArbitrumAssets.USDCn_UNDERLYING,
      AaveV3ArbitrumAssets.USDC_ORACLE,
      PriceFeeds.ARBITRUM_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3ArbitrumAssets.USDT_UNDERLYING,
      AaveV3ArbitrumAssets.USDT_ORACLE,
      PriceFeeds.ARBITRUM_V3_USDT_FEED
    );
    _validateUSDPriceFeed(
      AaveV3ArbitrumAssets.DAI_UNDERLYING,
      AaveV3ArbitrumAssets.DAI_ORACLE,
      PriceFeeds.ARBITRUM_V3_DAI_FEED
    );
    _validateUSDPriceFeed(
      AaveV3ArbitrumAssets.MAI_UNDERLYING,
      AaveV3ArbitrumAssets.MAI_ORACLE,
      PriceFeeds.ARBITRUM_V3_MAI_FEED
    );
    _validateUSDPriceFeed(
      AaveV3ArbitrumAssets.LUSD_UNDERLYING,
      AaveV3ArbitrumAssets.LUSD_ORACLE,
      PriceFeeds.ARBITRUM_V3_LUSD_FEED
    );
    _validateUSDPriceFeed(
      AaveV3ArbitrumAssets.FRAX_UNDERLYING,
      AaveV3ArbitrumAssets.FRAX_ORACLE,
      PriceFeeds.ARBITRUM_V3_FRAX_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3Arbitrum.ORACLE);
  }
}
