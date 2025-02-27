// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IAavePolEthERC20Bridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title February Funding Update - Part B
 * @author TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Polygon_FebruaryFundingUpdatePartB_20250207 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  function execute() external {
    _prepareBridge();
    _bridge();
  }

  function _prepareBridge() internal {
    // usdc.e
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.USDC_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.USDC_UNDERLYING,
          AaveV3PolygonAssets.USDC_A_TOKEN
        ) - 100e6
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.USDC_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV2Polygon.COLLECTOR),
          AaveV2PolygonAssets.USDC_UNDERLYING,
          AaveV2PolygonAssets.USDC_A_TOKEN
        ) - 100e6
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // bal
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.BAL_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.BAL_UNDERLYING,
          AaveV3PolygonAssets.BAL_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.BAL_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV2Polygon.COLLECTOR),
          AaveV2PolygonAssets.BAL_UNDERLYING,
          AaveV2PolygonAssets.BAL_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.BAL_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.BAL_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // weth
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.WETH_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.WETH_UNDERLYING,
          AaveV3PolygonAssets.WETH_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.WETH_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV2Polygon.COLLECTOR),
          AaveV2PolygonAssets.WETH_UNDERLYING,
          AaveV2PolygonAssets.WETH_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.WETH_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.WETH_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // dai
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.DAI_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.DAI_UNDERLYING,
          AaveV3PolygonAssets.DAI_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.DAI_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV2Polygon.COLLECTOR),
          AaveV2PolygonAssets.DAI_UNDERLYING,
          AaveV2PolygonAssets.DAI_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );

    // aave
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.AAVE_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.AAVE_UNDERLYING,
          AaveV3PolygonAssets.AAVE_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.AAVE_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.AAVE_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // crv
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.CRV_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.CRV_UNDERLYING,
          AaveV3PolygonAssets.CRV_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.CRV_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.CRV_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // stMatic
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.stMATIC_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.stMATIC_UNDERLYING,
          AaveV3PolygonAssets.stMATIC_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );

    // dpi
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.DPI_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.DPI_UNDERLYING,
          AaveV3PolygonAssets.DPI_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );

    // wstEth
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.wstETH_UNDERLYING,
        amount: _getWithdrawableBalance(
          address(AaveV3Polygon.COLLECTOR),
          AaveV3PolygonAssets.wstETH_UNDERLYING,
          AaveV3PolygonAssets.wstETH_A_TOKEN
        ) - 1 ether
      }),
      MiscPolygon.AAVE_POL_ETH_BRIDGE
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.wstETH_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV3PolygonAssets.wstETH_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR))
    );
  }

  function _bridge() internal {
    // usdc
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // bal
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.BAL_UNDERLYING,
      IERC20(AaveV3PolygonAssets.BAL_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // aave
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.AAVE_UNDERLYING,
      IERC20(AaveV3PolygonAssets.AAVE_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // weth
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.WETH_UNDERLYING,
      IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // dai
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // crv
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.CRV_UNDERLYING,
      IERC20(AaveV3PolygonAssets.CRV_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // stMatic
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.stMATIC_UNDERLYING,
      IERC20(AaveV3PolygonAssets.stMATIC_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // dpi
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.DPI_UNDERLYING,
      IERC20(AaveV3PolygonAssets.DPI_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );

    // wstEth
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.wstETH_UNDERLYING,
      IERC20(AaveV3PolygonAssets.wstETH_UNDERLYING).balanceOf(MiscPolygon.AAVE_POL_ETH_BRIDGE)
    );
  }

  function _getWithdrawableBalance(
    address collector,
    address underlying,
    address aToken
  ) internal view returns (uint256) {
    uint256 collectorBalance = IERC20(aToken).balanceOf(collector);
    uint256 liquidity = IERC20(underlying).balanceOf(aToken);

    return collectorBalance > liquidity ? liquidity : collectorBalance;
  }
}
