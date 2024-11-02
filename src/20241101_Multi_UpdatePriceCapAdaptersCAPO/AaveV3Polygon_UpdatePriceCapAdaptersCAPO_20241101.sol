// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IPoolConfiguratorV2} from './interfaces/IPoolConfiguratorV2.sol';
import {ConfiguratorInputTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/ConfiguratorInputTypes.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Polygon.sol';
import {TokenImpls} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateMaticTokensNameAndSymbol();
  }

  // we change the name and symbol of aToken and variableDebtToken to use WPOL instead of WMATIC
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
        name: 'Aave Matic Market WPOL',
        symbol: 'amWPOL',
        implementation: TokenImpls.POLYGON_V_TOKEN_IMPL_V2,
        params: ''
      })
    );
  }
}
