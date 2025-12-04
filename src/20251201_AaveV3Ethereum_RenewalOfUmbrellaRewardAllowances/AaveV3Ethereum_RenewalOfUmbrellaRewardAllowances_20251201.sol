// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';

/**
 * @title Renewal of Umbrella Reward Allowances
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-renewal-of-umbrella-reward-allowances/23474
 * @notice Payload that renews the Umbrella reward allowances from the Aave Ethereum
 *         Collector to the Umbrella Rewards Controller, so that emissions can
 *         continue at the current rate without interruption.
 */
contract AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201 is IProposalGenericExecutor {
  /// @notice Additional allowance for stkwaEthUSDC.v1 rewards (USDC, 6 decimals).
  uint256 public constant USDC_RENEWAL_ALLOWANCE = 1_149_028e6;

  /// @notice Additional allowance for stkwaEthUSDT.v1 rewards (USDT, 6 decimals).
  uint256 public constant USDT_RENEWAL_ALLOWANCE = 1_809_848e6;

  /// @notice Additional allowance for stkwaEthWETH.v1 rewards (WETH, 18 decimals).
  uint256 public constant WETH_RENEWAL_ALLOWANCE = 271 ether;

  /// @notice Additional allowance for stkGHO.v1 rewards (GHO, 18 decimals).
  uint256 public constant GHO_RENEWAL_ALLOWANCE = 591_781 ether;

  /// @notice Renews the Collector -> Umbrella Rewards Controller allowances
  ///         by adding the configured renewal amounts on top of the existing
  ///         allowances for each reward asset.
  function execute() external override {
    address collector = address(AaveV3Ethereum.COLLECTOR);
    address rewardsController = UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER;

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      rewardsController,
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(collector, rewardsController) +
        USDC_RENEWAL_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      rewardsController,
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(collector, rewardsController) +
        USDT_RENEWAL_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      rewardsController,
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(collector, rewardsController) +
        WETH_RENEWAL_ALLOWANCE
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      rewardsController,
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(collector, rewardsController) +
        GHO_RENEWAL_ALLOWANCE
    );
  }
}
