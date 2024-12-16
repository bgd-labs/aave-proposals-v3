// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumEtherFi, AaveV3EthereumEtherFiAssets} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {PriceFeeds} from './Constants.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';

/**
 * @dev Test for AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21413537);
    proposal = new AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3EthereumEtherFi.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3EthereumEtherFiAssets.USDC_UNDERLYING,
      AaveV3EthereumEtherFiAssets.USDC_ORACLE,
      PriceFeeds.ETHEREUM_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumEtherFiAssets.PYUSD_UNDERLYING,
      AaveV3EthereumEtherFiAssets.PYUSD_ORACLE,
      PriceFeeds.ETHEREUM_V3_PYUSD_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumEtherFiAssets.FRAX_UNDERLYING,
      AaveV3EthereumEtherFiAssets.FRAX_ORACLE,
      PriceFeeds.ETHEREUM_V3_FRAX_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3EthereumEtherFi.ORACLE);
  }
}
