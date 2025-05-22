// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @dev Test for AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 20413285);
    proposal = new AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Metis.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3MetisAssets.mUSDC_UNDERLYING,
      AaveV3MetisAssets.mUSDC_ORACLE,
      PriceFeeds.METIS_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3MetisAssets.mUSDT_UNDERLYING,
      AaveV3MetisAssets.mUSDT_ORACLE,
      PriceFeeds.METIS_V3_USDT_FEED
    );
    _validateUSDPriceFeed(
      AaveV3MetisAssets.mDAI_UNDERLYING,
      AaveV3MetisAssets.mDAI_ORACLE,
      PriceFeeds.METIS_V3_DAI_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3Metis.ORACLE);
  }
}
