// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IAavePolEthERC20Bridge {
  function bridge(address token, uint256 amount) external;
}

/**
 * @title Treasury Management - GSM Funding & RWA Strategy Preparations (Part 1)
 * @author efecarranza.eth
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128
 */
contract AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;

  uint256 public constant AAVE_V3_DAI_TO_WITHDRAW = 1_000_000 ether;

  IAavePolEthERC20Bridge public constant bridge =
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE);

  function execute() external {
    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 10e6
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.USDT_A_TOKEN,
      address(this),
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 10e6
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.DAI_A_TOKEN,
      address(this),
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 10e18
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 10e6
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.USDT_A_TOKEN,
      address(this),
      IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 10e6
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.DAI_A_TOKEN,
      address(this),
      AAVE_V3_DAI_TO_WITHDRAW
    );

    AaveV2Polygon.POOL.withdraw(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    AaveV2Polygon.POOL.withdraw(
      AaveV3PolygonAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    AaveV2Polygon.POOL.withdraw(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(bridge)
    );

    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      AAVE_V3_DAI_TO_WITHDRAW,
      address(bridge)
    );

    bridge.bridge(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(address(bridge))
    );
    bridge.bridge(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(address(bridge))
    );
    bridge.bridge(
      AaveV2PolygonAssets.USDT_UNDERLYING,
      IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(address(bridge))
    );
  }
}
