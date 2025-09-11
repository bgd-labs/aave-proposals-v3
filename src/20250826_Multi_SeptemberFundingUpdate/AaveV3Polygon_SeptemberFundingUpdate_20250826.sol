// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IAavePolEthERC20Bridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title September Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915
 */
contract AaveV3Polygon_SeptemberFundingUpdate_20250826 is IProposalGenericExecutor {
  uint256 public constant USDC_AMOUNT = 557_125e6;

  function execute() external {
    _approvals();
    _bridges();
  }

  function _approvals() internal {
    AaveV3Polygon.COLLECTOR.approve(
      IERC20(AaveV3PolygonAssets.USDCn_UNDERLYING),
      MiscPolygon.AFC_SAFE,
      USDC_AMOUNT
    );
  }

  function _bridges() internal {
    // DAI
    uint256 daiBalance = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      daiBalance
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      daiBalance
    );

    // USDC
    uint256 usdcBalance = IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      usdcBalance
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      usdcBalance
    );

    /// WBTC
    uint256 wbtcBalance = IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      wbtcBalance
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.WBTC_UNDERLYING,
      wbtcBalance
    );
  }
}
