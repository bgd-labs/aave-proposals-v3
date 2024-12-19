// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {PriceFeeds} from './Constants.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';
import {AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.sol';

/**
 * @dev Test for AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 129368356);
    proposal = new AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      AaveV3OptimismAssets.USDC_ORACLE,
      PriceFeeds.OPTIMISM_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3OptimismAssets.USDCn_UNDERLYING,
      AaveV3OptimismAssets.USDC_ORACLE,
      PriceFeeds.OPTIMISM_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3OptimismAssets.USDT_UNDERLYING,
      AaveV3OptimismAssets.USDT_ORACLE,
      PriceFeeds.OPTIMISM_V3_USDT_FEED
    );
    _validateUSDPriceFeed(
      AaveV3OptimismAssets.DAI_UNDERLYING,
      AaveV3OptimismAssets.DAI_ORACLE,
      PriceFeeds.OPTIMISM_V3_DAI_FEED
    );
    _validateUSDPriceFeed(
      AaveV3OptimismAssets.MAI_UNDERLYING,
      AaveV3OptimismAssets.MAI_ORACLE,
      PriceFeeds.OPTIMISM_V3_MAI_FEED
    );
    _validateUSDPriceFeed(
      AaveV3OptimismAssets.LUSD_UNDERLYING,
      AaveV3OptimismAssets.LUSD_ORACLE,
      PriceFeeds.OPTIMISM_V3_LUSD_FEED
    );
    _validateUSDPriceFeed(
      AaveV3OptimismAssets.sUSD_UNDERLYING,
      AaveV3OptimismAssets.sUSD_ORACLE,
      PriceFeeds.OPTIMISM_V3_SUSD_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3Optimism.ORACLE);
  }
}
