// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {IAaveOpEthERC20Bridge} from 'aave-helpers/src/bridges/optimism/IAaveOpEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title September Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915
 */
contract AaveV3Optimism_SeptemberFundingUpdate_20250826 is IProposalGenericExecutor {
  function execute() external {
    /// Allowances
    AaveV3Optimism.COLLECTOR.approve(
      IERC20(AaveV3OptimismAssets.USDCn_UNDERLYING),
      MiscOptimism.AFC_SAFE,
      IERC20(AaveV3OptimismAssets.USDCn_UNDERLYING).balanceOf(address(AaveV3Optimism.COLLECTOR))
    );

    AaveV3Optimism.COLLECTOR.approve(
      IERC20(AaveV3OptimismAssets.sUSD_UNDERLYING),
      MiscOptimism.AFC_SAFE,
      IERC20(AaveV3OptimismAssets.sUSD_UNDERLYING).balanceOf(address(AaveV3Optimism.COLLECTOR))
    );

    /// Bridges
    /// USDT
    uint256 usdtBalance = IERC20(AaveV3OptimismAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );
    AaveV3Optimism.COLLECTOR.transfer(
      IERC20(AaveV3OptimismAssets.USDT_UNDERLYING),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE,
      usdtBalance
    );
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      usdtBalance
    );

    /// USDC
    uint256 usdcBalance = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );
    AaveV3Optimism.COLLECTOR.transfer(
      IERC20(AaveV3OptimismAssets.USDC_UNDERLYING),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE,
      usdcBalance
    );
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      usdcBalance
    );

    /// wBTC
    uint256 wbtcBalance = IERC20(AaveV3OptimismAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );
    AaveV3Optimism.COLLECTOR.transfer(
      IERC20(AaveV3OptimismAssets.WBTC_UNDERLYING),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE,
      wbtcBalance
    );
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      wbtcBalance
    );
  }
}
