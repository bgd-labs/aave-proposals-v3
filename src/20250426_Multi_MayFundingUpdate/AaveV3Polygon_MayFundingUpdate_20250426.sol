// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IAavePolEthERC20Bridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthERC20Bridge.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Polygon_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  function execute() external {
    /// WBTC
    uint256 wbtcAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Polygon.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.WBTC_UNDERLYING,
        amount: IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR))
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.WBTC_UNDERLYING,
      wbtcAmountWithdrawn
    );

    /// USDT
    uint256 usdtAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Polygon.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.USDT_UNDERLYING,
        amount: IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR))
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.USDT_UNDERLYING,
      usdtAmountWithdrawn
    );

    /// DAI
    uint256 daiAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Polygon.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.DAI_UNDERLYING,
        amount: IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR))
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      daiAmountWithdrawn
    );

    /// MATICX
    uint256 maticxAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Polygon.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.MaticX_UNDERLYING,
        amount: IERC20(AaveV3PolygonAssets.MaticX_A_TOKEN).balanceOf(
          address(AaveV3Polygon.COLLECTOR)
        )
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      maticxAmountWithdrawn
    );
  }
}
