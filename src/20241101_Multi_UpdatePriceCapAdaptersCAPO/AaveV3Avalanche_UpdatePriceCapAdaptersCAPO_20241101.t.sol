// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.t.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @dev Test for AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;
  bool switchToV2Oracle;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 52687284);
    proposal = new AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateV3PriceFeed(
      AaveV3AvalancheAssets.USDC_UNDERLYING,
      AaveV3AvalancheAssets.USDC_ORACLE,
      PriceFeeds.AVALANCHE_V3_USDC_FEED
    );
    _validateV3PriceFeed(
      AaveV3AvalancheAssets.USDt_UNDERLYING,
      AaveV3AvalancheAssets.USDt_ORACLE,
      PriceFeeds.AVALANCHE_V3_USDT_FEED
    );
    _validateV3PriceFeed(
      AaveV3AvalancheAssets.DAIe_UNDERLYING,
      AaveV3AvalancheAssets.DAIe_ORACLE,
      PriceFeeds.AVALANCHE_V3_DAI_FEED
    );
    _validateV3PriceFeed(
      AaveV3AvalancheAssets.FRAX_UNDERLYING,
      AaveV3AvalancheAssets.FRAX_ORACLE,
      PriceFeeds.AVALANCHE_V3_FRAX_FEED
    );
    _validateV3PriceFeed(
      AaveV3AvalancheAssets.MAI_UNDERLYING,
      AaveV3AvalancheAssets.MAI_ORACLE,
      PriceFeeds.AVALANCHE_V3_MAI_FEED
    );

    switchToV2Oracle = true;
  }

  function getAaveOracle() public virtual override returns (address) {
    if (switchToV2Oracle) {
      return address(AaveV2Avalanche.ORACLE);
    } else {
      return address(AaveV3Avalanche.ORACLE);
    }
  }
}
