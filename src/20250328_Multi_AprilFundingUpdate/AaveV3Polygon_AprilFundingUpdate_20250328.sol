// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IAavePolEthERC20Bridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title April Funding update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-funding-update/21590
 */
contract AaveV3Polygon_AprilFundingUpdate_20250328 is IProposalGenericExecutor {
  function execute() external {
    _prepareBridge();
    _bridge();
  }

  function _prepareBridge() internal {
    // usdc.e
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // usdt
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.USDT_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // weth
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.WETH_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.WETH_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // dai
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.DAI_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.DAI_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );
  }

  function _bridge() internal {
    // usdc
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // usdt
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.USDT_UNDERLYING,
      IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // WETH
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.WETH_UNDERLYING,
      IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // DAI
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );
  }
}
