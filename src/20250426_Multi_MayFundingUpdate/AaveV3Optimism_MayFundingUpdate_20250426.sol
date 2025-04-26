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
  address public constant DAI = AaveV3OptimismAssets.DAI_UNDERLYING;
  // address public constant WETH = AaveV3OptimismAssets.WETH_UNDERLYING;
  // address public constant WBTC = AaveV3OptimismAssets.WBTC_UNDERLYING;
  address public constant USDT = AaveV3OptimismAssets.USDT_UNDERLYING;
  address public constant USDC = AaveV3OptimismAssets.USDC_UNDERLYING;
  address public constant COLLECTOR = address(AaveV3Optimism.COLLECTOR);
  address public constant BRIDGE = MiscOptimism.AAVE_OPT_ETH_BRIDGE;

  function execute() external {
    /// DAI
    uint256 daiBalance = IERC20(DAI).balanceOf(COLLECTOR);
    AaveV3Optimism.COLLECTOR.transfer(IERC20(DAI), BRIDGE, daiBalance);
    IAaveOpEthERC20Bridge(BRIDGE).bridge(DAI, AaveV3EthereumAssets.DAI_UNDERLYING, daiBalance);

    /// WETH
    // uint256 wethBalance = IERC20(WETH).balanceOf(COLLECTOR);
    // AaveV3Optimism.COLLECTOR.transfer(
    //   WETH,
    //   BRIDGE,
    //   wethBalance
    // );
    // IAaveOpEthERC20Bridge(BRIDGE).bridge(
    //   WETH,
    //   AaveV3EthereumAssets.WETH_UNDERLYING,
    //   wethBalance
    // );

    /// WBTC
    // uint256 wbtcBalance = IERC20(WBTC).balanceOf(COLLECTOR);
    // AaveV3Optimism.COLLECTOR.transfer(
    //   WBTC,
    //   BRIDGE,
    //   wbtcBalance
    // );
    // IAaveOpEthERC20Bridge(BRIDGE).bridge(
    //   WBTC,
    //   AaveV3EthereumAssets.WBTC_UNDERLYING,
    //   wbtcBalance
    // );

    /// USDT
    uint256 usdtBalance = IERC20(USDT).balanceOf(COLLECTOR);
    AaveV3Optimism.COLLECTOR.transfer(IERC20(USDT), BRIDGE, usdtBalance);
    IAaveOpEthERC20Bridge(BRIDGE).bridge(USDT, AaveV3EthereumAssets.USDT_UNDERLYING, usdtBalance);

    /// USDC
    uint256 usdcBalance = IERC20(USDC).balanceOf(COLLECTOR);
    AaveV3Optimism.COLLECTOR.transfer(IERC20(USDC), BRIDGE, usdcBalance);
    IAaveOpEthERC20Bridge(BRIDGE).bridge(USDC, AaveV3EthereumAssets.USDC_UNDERLYING, usdcBalance);
  }
}
