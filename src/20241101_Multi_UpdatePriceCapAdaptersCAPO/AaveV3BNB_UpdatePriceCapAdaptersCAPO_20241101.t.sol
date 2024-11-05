// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.t.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @dev Test for AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 43745061);
    proposal = new AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101', AaveV3BNB.POOL, address(proposal));
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateV3PriceFeed(
      AaveV3BNBAssets.USDC_UNDERLYING,
      AaveV3BNBAssets.USDC_ORACLE,
      PriceFeeds.BNB_V3_USDC_FEED
    );
    _validateV3PriceFeed(
      AaveV3BNBAssets.USDT_UNDERLYING,
      AaveV3BNBAssets.USDT_ORACLE,
      PriceFeeds.BNB_V3_USDT_FEED
    );
    _validateV3PriceFeed(
      AaveV3BNBAssets.FDUSD_UNDERLYING,
      AaveV3BNBAssets.FDUSD_ORACLE,
      PriceFeeds.BNB_V3_FDUSD_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3BNB.ORACLE);
  }
}
