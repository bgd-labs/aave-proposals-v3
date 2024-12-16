// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @dev Test for AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 37551987);
    proposal = new AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3GnosisAssets.USDC_UNDERLYING,
      AaveV3GnosisAssets.USDC_ORACLE,
      PriceFeeds.GNOSIS_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3GnosisAssets.USDCe_UNDERLYING,
      AaveV3GnosisAssets.USDC_ORACLE,
      PriceFeeds.GNOSIS_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3GnosisAssets.WXDAI_UNDERLYING,
      AaveV3GnosisAssets.WXDAI_ORACLE,
      PriceFeeds.GNOSIS_V3_WXDAI_FEED
    );
    _validateUSDPriceFeed(
      AaveV3GnosisAssets.sDAI_UNDERLYING,
      AaveV3GnosisAssets.sDAI_ORACLE,
      PriceFeeds.GNOSIS_V3_SDAI_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3Gnosis.ORACLE);
  }
}
