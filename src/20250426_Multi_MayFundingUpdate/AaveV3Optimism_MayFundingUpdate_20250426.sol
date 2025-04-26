// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IAaveOpEthERC20Bridge} from 'aave-helpers/src/bridges/optimism/IAaveOpEthERC20Bridge.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Optimism_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  function execute() external {
    /// DAI
    uint256 daiAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Optimism.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.DAI_UNDERLYING,
        amount: IERC20(AaveV3OptimismAssets.DAI_A_TOKEN).balanceOf(
          address(AaveV3Optimism.COLLECTOR)
        )
      }),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE
    );
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      daiAmountWithdrawn
    );

    /// WETH
    uint256 wethAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Optimism.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.WETH_UNDERLYING,
        amount: IERC20(AaveV3OptimismAssets.WETH_A_TOKEN).balanceOf(
          address(AaveV3Optimism.COLLECTOR)
        )
      }),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE
    );
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      wethAmountWithdrawn
    );

    /// WBTC
    uint256 wbtcAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Optimism.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.WBTC_UNDERLYING,
        amount: IERC20(AaveV3OptimismAssets.WBTC_A_TOKEN).balanceOf(
          address(AaveV3Optimism.COLLECTOR)
        )
      }),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE
    );
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      wbtcAmountWithdrawn
    );

    /// USDC
    uint256 usdcAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Optimism.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.USDC_UNDERLYING,
        amount: IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
          address(AaveV3Optimism.COLLECTOR)
        )
      }),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE
    );
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      usdcAmountWithdrawn
    );

    /// USDC
    uint256 usdtAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Optimism.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.USDT_UNDERLYING,
        amount: IERC20(AaveV3OptimismAssets.USDT_A_TOKEN).balanceOf(
          address(AaveV3Optimism.COLLECTOR)
        )
      }),
      MiscOptimism.AAVE_OPT_ETH_BRIDGE
    );
    IAaveOpEthERC20Bridge(MiscOptimism.AAVE_OPT_ETH_BRIDGE).bridge(
      AaveV3OptimismAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      usdtAmountWithdrawn
    );
  }
}
