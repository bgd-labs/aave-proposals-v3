// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101.sol';
import {PriceFeeds} from './Constants.sol';
import {BasePayloadUSDFeedTest} from './BasePayloadUSDFeedTest.sol';
import {BasePayloadETHFeedTest} from './BasePayloadETHFeedTest.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101_Test is
  BasePayloadUSDFeedTest,
  BasePayloadETHFeedTest,
  ProtocolV3TestBase
{
  AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;
  bool switchToV2Oracle;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22489327);
    proposal = new AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_priceFeeds() public {
    executePayload(vm, address(proposal));

    _validateUSDPriceFeed(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      PriceFeeds.ETHEREUM_V3_USDC_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      PriceFeeds.ETHEREUM_V3_USDT_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      PriceFeeds.ETHEREUM_V3_DAI_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      PriceFeeds.ETHEREUM_V3_LUSD_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.FRAX_ORACLE,
      PriceFeeds.ETHEREUM_V3_FRAX_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumAssets.crvUSD_UNDERLYING,
      AaveV3EthereumAssets.crvUSD_ORACLE,
      PriceFeeds.ETHEREUM_V3_CRVUSD_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_ORACLE,
      PriceFeeds.ETHEREUM_V3_PYUSD_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumAssets.sDAI_UNDERLYING,
      AaveV3EthereumAssets.sDAI_ORACLE,
      PriceFeeds.ETHEREUM_V3_SDAI_FEED
    );
    _validateUSDPriceFeed(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.USDS_ORACLE,
      PriceFeeds.ETHEREUM_V3_USDS_FEED
    );

    switchToV2Oracle = true;

    _validateETHPriceFeed(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDC_ORACLE,
      PriceFeeds.ETHEREUM_V2_USDC_FEED,
      PriceFeeds.ETHEREUM_V3_USDC_FEED // assetToPeg feed is the same as v3
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.USDT_ORACLE,
      PriceFeeds.ETHEREUM_V2_USDT_FEED,
      PriceFeeds.ETHEREUM_V3_USDT_FEED
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.DAI_ORACLE,
      PriceFeeds.ETHEREUM_V2_DAI_FEED,
      PriceFeeds.ETHEREUM_V3_DAI_FEED
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV2EthereumAssets.FRAX_ORACLE,
      PriceFeeds.ETHEREUM_V2_FRAX_FEED,
      PriceFeeds.ETHEREUM_V3_FRAX_FEED
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.LUSD_UNDERLYING,
      AaveV2EthereumAssets.LUSD_ORACLE,
      PriceFeeds.ETHEREUM_V2_LUSD_FEED,
      PriceFeeds.ETHEREUM_V3_LUSD_FEED
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.USDP_UNDERLYING,
      AaveV2EthereumAssets.USDP_ORACLE,
      PriceFeeds.ETHEREUM_V2_USDP_FEED,
      0x09823a47Fd106d69925eD5867fdfaFddA5c333B2 // USDP/USD capo feed
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.sUSD_UNDERLYING,
      AaveV2EthereumAssets.sUSD_ORACLE,
      PriceFeeds.ETHEREUM_V2_SUSD_FEED,
      0x92339c63fa1537079F10f9F142707F03e4e95703 // sUSD/USD capo feed
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      AaveV2EthereumAssets.BUSD_ORACLE,
      PriceFeeds.ETHEREUM_V2_BUSD_FEED,
      0x8b1d214b3556820d72219aa4cf19dcCA2DE43C9e // BUSD/USD capo feed
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV2EthereumAssets.TUSD_ORACLE,
      PriceFeeds.ETHEREUM_V2_TUSD_FEED,
      0x42FA344028123cbEFBDa821528Ab8bDbE5F9C4B7 // TUSD/USD capo feed
    );
    _validateETHPriceFeed(
      AaveV2EthereumAssets.UST_UNDERLYING,
      AaveV2EthereumAssets.UST_ORACLE,
      PriceFeeds.ETHEREUM_V2_UST_FEED,
      0x049971FAAF0E4474A883979a9696AfDa390abF0c // UST/USD capo feed
    );
  }

  function getAaveOracle()
    public
    virtual
    override(BasePayloadETHFeedTest, BasePayloadUSDFeedTest)
    returns (address)
  {
    if (switchToV2Oracle) {
      return address(AaveV2Ethereum.ORACLE);
    } else {
      return address(AaveV3Ethereum.ORACLE);
    }
  }
}
