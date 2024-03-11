// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IAavePolEthERC20Bridge {
  function bridge(address token, uint256 amount) external;
}

/**
 * @title Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09
 * - Discussion: https://governance.aave.com/t/arfc-funding-update/16675
 */
contract AaveV3Polygon_FundingUpdate_20240224 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  IAavePolEthERC20Bridge public constant bridge =
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE);

  function execute() external {
    /// Transfer
    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.WETH_A_TOKEN,
      address(this),
      IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1 ether
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.DAI_A_TOKEN,
      address(this),
      IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1 ether
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.BAL_A_TOKEN,
      address(this),
      IERC20(AaveV3PolygonAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1 ether
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.CRV_A_TOKEN,
      address(this),
      IERC20(AaveV3PolygonAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1 ether
    );

    /// Withdraw
    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.BAL_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.CRV_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    /// Bridge

    bridge.bridge(
      AaveV3PolygonAssets.WETH_UNDERLYING,
      IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(address(bridge))
    );

    bridge.bridge(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(address(bridge))
    );

    bridge.bridge(
      AaveV3PolygonAssets.BAL_UNDERLYING,
      IERC20(AaveV3PolygonAssets.BAL_UNDERLYING).balanceOf(address(bridge))
    );

    bridge.bridge(
      AaveV3PolygonAssets.CRV_UNDERLYING,
      IERC20(AaveV3PolygonAssets.CRV_UNDERLYING).balanceOf(address(bridge))
    );
  }
}
