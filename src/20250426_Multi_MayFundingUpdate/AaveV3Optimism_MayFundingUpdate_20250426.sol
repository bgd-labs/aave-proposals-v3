// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IAaveOpEthERC20Bridge} from 'aave-helpers/src/bridges/optimism/IAaveOpEthERC20Bridge.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-2025-funding-update/21906
 */
contract AaveV3Optimism_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  address public constant COLLECTOR = address(AaveV3Optimism.COLLECTOR);
  address public constant BRIDGE = MiscOptimism.AAVE_OPT_ETH_BRIDGE;

  function execute() external {
    /// DAI
    uint256 daiBalance = IERC20(AaveV3OptimismAssets.DAI_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Optimism.COLLECTOR.transfer(
      IERC20(AaveV3OptimismAssets.DAI_UNDERLYING),
      BRIDGE,
      daiBalance
    );
    IAaveOpEthERC20Bridge(BRIDGE).bridge(
      AaveV3OptimismAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      daiBalance
    );

    /// USDT
    uint256 usdtBalance = IERC20(AaveV3OptimismAssets.USDT_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Optimism.COLLECTOR.transfer(
      IERC20(AaveV3OptimismAssets.USDT_UNDERLYING),
      BRIDGE,
      usdtBalance
    );
    IAaveOpEthERC20Bridge(BRIDGE).bridge(
      AaveV3OptimismAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      usdtBalance
    );

    /// USDC
    uint256 usdcBalance = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Optimism.COLLECTOR.transfer(
      IERC20(AaveV3OptimismAssets.USDC_UNDERLYING),
      BRIDGE,
      usdcBalance
    );
    IAaveOpEthERC20Bridge(BRIDGE).bridge(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      usdcBalance
    );
  }
}
