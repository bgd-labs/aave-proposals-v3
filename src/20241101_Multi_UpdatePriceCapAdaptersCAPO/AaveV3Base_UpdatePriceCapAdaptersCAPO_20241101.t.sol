// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @dev Test for AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 23772801);
    proposal = new AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3BaseAssets.USDC_UNDERLYING,
      AaveV3BaseAssets.USDC_ORACLE,
      PriceFeeds.BASE_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3BaseAssets.USDbC_UNDERLYING,
      AaveV3BaseAssets.USDC_ORACLE,
      PriceFeeds.BASE_V3_USDC_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3Base.ORACLE);
  }
}
