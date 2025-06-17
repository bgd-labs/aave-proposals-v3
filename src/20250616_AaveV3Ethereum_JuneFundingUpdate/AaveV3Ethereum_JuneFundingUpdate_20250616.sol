// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title June Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-june-2025-funding-update/22352/2
 */
contract AaveV3Ethereum_JuneFundingUpdate_20250616 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  /// Approvals Constants
  /// https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa
  address public constant AFC_SAFE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;

  /// https://etherscan.io/address/0xdeadD8aB03075b7FBA81864202a2f59EE25B312b
  address public constant MERIT_AHAB_SAFE = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;

  uint256 public constant AFC_USDC_ALLOWANCE = 2_000_000e6;
  uint256 public constant AFC_USDT_ALLOWANCE = 4_000_000e6;
  uint256 public constant MERIT_LIDO_GHO_ALLOWANCE = 3_000_000 ether;
  uint256 public constant AHAB_WETH_ALLOWANCE = 800 ether;

  /// Swaps Constants

  /// https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;

  /// https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  /// https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  uint256 public constant USDC_SWAP_AMOUNT = 2_000_000e6;
  uint256 public constant USDT_SWAP_AMOUNT = 1_000_000e6;

  function execute() external {
    // AFC aEthUSDC Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      AFC_SAFE,
      AFC_USDC_ALLOWANCE
    );

    // AFC aEthUSDT Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      AFC_SAFE,
      AFC_USDT_ALLOWANCE
    );

    // Merit aEthLidoGHO Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MERIT_AHAB_SAFE,
      MERIT_LIDO_GHO_ALLOWANCE
    );

    // Ahab aEthWETH Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      MERIT_AHAB_SAFE,
      AHAB_WETH_ALLOWANCE
    );

    // USDC Swaps
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.USDC_ORACLE,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: USDC_SWAP_AMOUNT,
        slippage: 75
      })
    );

    // USDT Swaps
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.USDT_ORACLE,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: USDT_SWAP_AMOUNT,
        slippage: 75
      })
    );
  }
}
