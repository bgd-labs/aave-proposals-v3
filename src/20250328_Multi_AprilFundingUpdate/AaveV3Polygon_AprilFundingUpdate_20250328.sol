// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IAavePolEthERC20Bridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IPoolExposureSteward} from './IPoolExposureSteward.sol';

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
    IPoolExposureSteward(AaveV3Polygon.POOL_EXPOSURE_STEWARD).withdrawV3(
      address(AaveV3Polygon.POOL),
      AaveV3PolygonAssets.USDC_UNDERLYING,
      _getWithdrawableBalance(
        address(AaveV3Polygon.COLLECTOR),
        AaveV3PolygonAssets.USDC_UNDERLYING,
        AaveV3PolygonAssets.USDC_A_TOKEN
      )
    );
    IPoolExposureSteward(AaveV3Polygon.POOL_EXPOSURE_STEWARD).withdrawV2(
      address(AaveV2Polygon.POOL),
      AaveV2PolygonAssets.USDC_UNDERLYING,
      _getWithdrawableBalance(
        address(AaveV2Polygon.COLLECTOR),
        AaveV2PolygonAssets.USDC_UNDERLYING,
        AaveV2PolygonAssets.USDC_A_TOKEN
      )
    );
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // usdt
    IPoolExposureSteward(AaveV3Polygon.POOL_EXPOSURE_STEWARD).withdrawV3(
      address(AaveV3Polygon.POOL),
      AaveV3PolygonAssets.USDT_UNDERLYING,
      _getWithdrawableBalance(
        address(AaveV3Polygon.COLLECTOR),
        AaveV3PolygonAssets.USDT_UNDERLYING,
        AaveV3PolygonAssets.USDT_A_TOKEN
      )
    );
    IPoolExposureSteward(AaveV3Polygon.POOL_EXPOSURE_STEWARD).withdrawV2(
      address(AaveV2Polygon.POOL),
      AaveV2PolygonAssets.USDT_UNDERLYING,
      _getWithdrawableBalance(
        address(AaveV2Polygon.COLLECTOR),
        AaveV2PolygonAssets.USDT_UNDERLYING,
        AaveV2PolygonAssets.USDT_A_TOKEN
      )
    );
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.USDT_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // weth
    IPoolExposureSteward(AaveV3Polygon.POOL_EXPOSURE_STEWARD).withdrawV3(
      address(AaveV3Polygon.POOL),
      AaveV3PolygonAssets.WETH_UNDERLYING,
      _getWithdrawableBalance(
        address(AaveV3Polygon.COLLECTOR),
        AaveV3PolygonAssets.WETH_UNDERLYING,
        AaveV3PolygonAssets.WETH_A_TOKEN
      )
    );
    IPoolExposureSteward(AaveV3Polygon.POOL_EXPOSURE_STEWARD).withdrawV2(
      address(AaveV2Polygon.POOL),
      AaveV2PolygonAssets.WETH_UNDERLYING,
      _getWithdrawableBalance(
        address(AaveV2Polygon.COLLECTOR),
        AaveV2PolygonAssets.WETH_UNDERLYING,
        AaveV2PolygonAssets.WETH_A_TOKEN
      )
    );
    AaveV2Polygon.COLLECTOR.transfer(
      IERC20(AaveV2PolygonAssets.WETH_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      IERC20(AaveV2PolygonAssets.WETH_UNDERLYING).balanceOf(address(AaveV2Polygon.COLLECTOR))
    );

    // dai
    IPoolExposureSteward(AaveV3Polygon.POOL_EXPOSURE_STEWARD).withdrawV3(
      address(AaveV3Polygon.POOL),
      AaveV3PolygonAssets.DAI_UNDERLYING,
      _getWithdrawableBalance(
        address(AaveV3Polygon.COLLECTOR),
        AaveV3PolygonAssets.DAI_UNDERLYING,
        AaveV3PolygonAssets.DAI_A_TOKEN
      )
    );
    IPoolExposureSteward(AaveV3Polygon.POOL_EXPOSURE_STEWARD).withdrawV2(
      address(AaveV2Polygon.POOL),
      AaveV2PolygonAssets.DAI_UNDERLYING,
      _getWithdrawableBalance(
        address(AaveV2Polygon.COLLECTOR),
        AaveV2PolygonAssets.DAI_UNDERLYING,
        AaveV2PolygonAssets.DAI_A_TOKEN
      )
    );
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
