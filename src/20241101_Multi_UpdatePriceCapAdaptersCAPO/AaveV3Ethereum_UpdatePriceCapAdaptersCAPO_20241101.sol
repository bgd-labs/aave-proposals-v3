// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IPolygonMigration} from './interfaces/IPolygonMigration.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant MATIC_POL_MIGRATION_CONTRACT = 0x29e7DF7b6A1B2b07b731457f499E1696c60E2C4e;
  address public constant MATIC_UNDERLYING = 0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0;
  address public constant POL_UNDERLYING = 0x455e53CBB86018Ac2B8092FdCd39d8444aFFC3F6;

  function _postExecute() internal override {
    _updateV2PriceAdapters();
    _migrateCollectorMaticToPol();
  }

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](8);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.USDT_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_USDT_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.DAI_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_DAI_FEED
    });
    feedsUpdate[3] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.LUSD_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_LUSD_FEED
    });
    feedsUpdate[4] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.FRAX_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_FRAX_FEED
    });
    feedsUpdate[5] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.crvUSD_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_CRVUSD_FEED
    });
    feedsUpdate[6] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.PYUSD_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_PYUSD_FEED
    });
    feedsUpdate[7] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.sDAI_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_SDAI_FEED
    });

    return feedsUpdate;
  }

  function _updateV2PriceAdapters() internal {
    address[] memory assets = new address[](10);
    address[] memory sources = new address[](10);

    assets[0] = AaveV2EthereumAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.ETHEREUM_V2_USDC_FEED;

    assets[1] = AaveV2EthereumAssets.USDT_UNDERLYING;
    sources[1] = PriceFeeds.ETHEREUM_V2_USDT_FEED;

    assets[2] = AaveV2EthereumAssets.DAI_UNDERLYING;
    sources[2] = PriceFeeds.ETHEREUM_V2_DAI_FEED;

    assets[3] = AaveV2EthereumAssets.FRAX_UNDERLYING;
    sources[3] = PriceFeeds.ETHEREUM_V2_FRAX_FEED;

    assets[4] = AaveV2EthereumAssets.LUSD_UNDERLYING;
    sources[4] = PriceFeeds.ETHEREUM_V2_LUSD_FEED;

    assets[5] = AaveV2EthereumAssets.USDP_UNDERLYING;
    sources[5] = PriceFeeds.ETHEREUM_V2_USDP_FEED;

    assets[6] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    sources[6] = PriceFeeds.ETHEREUM_V2_SUSD_FEED;

    assets[7] = AaveV2EthereumAssets.BUSD_UNDERLYING;
    sources[7] = PriceFeeds.ETHEREUM_V2_BUSD_FEED;

    assets[8] = AaveV2EthereumAssets.TUSD_UNDERLYING;
    sources[8] = PriceFeeds.ETHEREUM_V2_TUSD_FEED;

    assets[9] = AaveV2EthereumAssets.UST_UNDERLYING;
    sources[9] = PriceFeeds.ETHEREUM_V2_UST_FEED;

    AaveV2Ethereum.ORACLE.setAssetSources(assets, sources);
  }

  function _migrateCollectorMaticToPol() internal {
    uint256 maticAmount = IERC20(MATIC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR));

    AaveV3Ethereum.COLLECTOR.transfer(
      MATIC_UNDERLYING,
      address(this),
      IERC20(MATIC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    IERC20(MATIC_UNDERLYING).forceApprove(MATIC_POL_MIGRATION_CONTRACT, maticAmount);
    IPolygonMigration(MATIC_POL_MIGRATION_CONTRACT).migrate(maticAmount);

    IERC20(POL_UNDERLYING).transfer(address(AaveV3Ethereum.COLLECTOR), maticAmount);
  }
}
