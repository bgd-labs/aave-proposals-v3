// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @dev Test for AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 15441891);
    proposal = new AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3ScrollAssets.USDC_UNDERLYING,
      AaveV3ScrollAssets.USDC_ORACLE,
      PriceFeeds.SCROLL_V3_USDC_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3Scroll.ORACLE);
  }
}
