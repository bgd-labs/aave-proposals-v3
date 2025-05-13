// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {PriceFeeds} from './Constants.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';

/**
 * @dev Test for AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  ProtocolV3TestBase
{
  AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22474831);
    proposal = new AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3EthereumLidoAssets.USDS_UNDERLYING,
      AaveV3EthereumLidoAssets.USDS_ORACLE,
      PriceFeeds.ETHEREUM_V3_USDS_FEED
    );
  }

  function getAaveOracle() public virtual override returns (address) {
    return address(AaveV3EthereumLido.ORACLE);
  }
}
