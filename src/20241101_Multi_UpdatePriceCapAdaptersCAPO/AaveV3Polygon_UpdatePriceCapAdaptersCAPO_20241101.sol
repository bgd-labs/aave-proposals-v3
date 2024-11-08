// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadPolygon} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPolygon.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IPoolConfiguratorV2} from './interfaces/IPoolConfiguratorV2.sol';
import {ConfiguratorInputTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/ConfiguratorInputTypes.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Polygon.sol';
import {TokenImpls, PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadPolygon {
  function _postExecute() internal override {
    _updateV2PriceAdapters();
    _updateMaticTokensNameAndSymbol();
  }

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](5);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.POLYGON_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.USDCn_UNDERLYING,
      priceFeed: PriceFeeds.POLYGON_V3_USDC_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.USDT_UNDERLYING,
      priceFeed: PriceFeeds.POLYGON_V3_USDT_FEED
    });
    feedsUpdate[3] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.DAI_UNDERLYING,
      priceFeed: PriceFeeds.POLYGON_V3_DAI_FEED
    });
    feedsUpdate[4] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.miMATIC_UNDERLYING,
      priceFeed: PriceFeeds.POLYGON_V3_MIMATIC_FEED
    });

    return feedsUpdate;
  }

  /**
   * @dev we change the name and symbol of aToken and variableDebtToken to use WPOL instead of WMATIC
   */
  function _updateMaticTokensNameAndSymbol() internal {
    AaveV3Polygon.POOL_CONFIGURATOR.updateAToken(
      ConfiguratorInputTypes.UpdateATokenInput({
        asset: AaveV3PolygonAssets.WPOL_UNDERLYING,
        treasury: address(AaveV3Polygon.COLLECTOR),
        incentivesController: AaveV3Polygon.DEFAULT_INCENTIVES_CONTROLLER,
        name: 'Aave Polygon WPOL',
        symbol: 'aPolWPOL',
        implementation: TokenImpls.POLYGON_A_TOKEN_IMPL_V3,
        params: ''
      })
    );
    AaveV3Polygon.POOL_CONFIGURATOR.updateVariableDebtToken(
      ConfiguratorInputTypes.UpdateDebtTokenInput({
        asset: AaveV3PolygonAssets.WPOL_UNDERLYING,
        incentivesController: AaveV3Polygon.DEFAULT_INCENTIVES_CONTROLLER,
        name: 'Aave Polygon Variable Debt WPOL',
        symbol: 'variableDebtPolWPOL',
        implementation: TokenImpls.POLYGON_V_TOKEN_IMPL_V3,
        params: ''
      })
    );

    IPoolConfiguratorV2(address(AaveV2Polygon.POOL_CONFIGURATOR)).updateAToken(
      IPoolConfiguratorV2.UpdateATokenInput({
        asset: AaveV2PolygonAssets.WPOL_UNDERLYING,
        treasury: address(AaveV2Polygon.COLLECTOR),
        incentivesController: AaveV2Polygon.DEFAULT_INCENTIVES_CONTROLLER,
        name: 'Aave Matic Market WPOL',
        symbol: 'amWPOL',
        implementation: TokenImpls.POLYGON_A_TOKEN_IMPL_V2,
        params: ''
      })
    );
    IPoolConfiguratorV2(address(AaveV2Polygon.POOL_CONFIGURATOR)).updateVariableDebtToken(
      IPoolConfiguratorV2.UpdateDebtTokenInput({
        asset: AaveV2PolygonAssets.WPOL_UNDERLYING,
        incentivesController: AaveV2Polygon.DEFAULT_INCENTIVES_CONTROLLER,
        name: 'Aave Matic Market variable debt mWPOL',
        symbol: 'variableDebtmWPOL',
        implementation: TokenImpls.POLYGON_V_TOKEN_IMPL_V2,
        params: ''
      })
    );
  }

  function _updateV2PriceAdapters() internal {
    address[] memory assets = new address[](3);
    address[] memory sources = new address[](3);

    assets[0] = AaveV2PolygonAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.POLYGON_V2_USDC_FEED;

    assets[1] = AaveV2PolygonAssets.USDT_UNDERLYING;
    sources[1] = PriceFeeds.POLYGON_V2_USDT_FEED;

    assets[2] = AaveV2PolygonAssets.DAI_UNDERLYING;
    sources[2] = PriceFeeds.POLYGON_V2_DAI_FEED;

    AaveV2Polygon.ORACLE.setAssetSources(assets, sources);
  }
}
