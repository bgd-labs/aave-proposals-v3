// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

interface WETH {
  function deposit() external payable;
}

/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-2025-funding-update/21906
 */
contract AaveV3Ethereum_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

  /// https://etherscan.io/address/0xdef1FA4CEfe67365ba046a7C630D6B885298E210
  address public constant ACI = 0xdef1FA4CEfe67365ba046a7C630D6B885298E210;

  /// https://etherscan.io/address/0xdeadD8aB03075b7FBA81864202a2f59EE25B312b
  address public constant MERIT_SAFE = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;

  /// https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa
  address public constant AAVE_FINANCE_COMMITEE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;

  /// https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;

  /// https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  /// https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  /// https://etherscan.io/address/0x7d1afa7b718fb893db30a3abc0cfc608aacfebb0
  IERC20 public constant MATIC_MAINNET = IERC20(0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0);

  /// https://etherscan.io/address/0x9ee91f9f426fa633d227f7a9b000e28b9dfd8599
  IERC20 public constant STMATIC_MAINNET = IERC20(0x9ee91F9f426fA633d227f7a9b000E28b9dfd8599);

  /// https://etherscan.io/address/0xd962fC30A72A84cE50161031391756Bf2876Af5D
  address public constant CVX_USD_ORACLE = 0xd962fC30A72A84cE50161031391756Bf2876Af5D;

  /// https://etherscan.io/address/0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD
  address public constant FRAX_USD_ORACLE = 0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD;

  uint256 public constant USDT_SWAP_AMOUNT = 2_000_000e6;
  uint256 public constant USDC_SWAP_AMOUNT = 2_000_000e6;

  uint256 public constant USDT_BUYBACK_AMOUNT = 3_000_000e6;
  uint256 public constant USDC_BUYBACK_AMOUNT = 3_000_000e6;

  uint256 public constant GHO_ALLOWANCE_AMOUNT = 3_000_000e6;
  uint256 public constant WETH_ALLOWANCE_AMOUNT = 800e18;

  uint256 public constant ETH_TRANSFER_AMOUNT = 0.5847 ether;
  uint256 public constant ETH_DEPOSIT_AMOUNT = 115 ether;

  function execute() external {
    _depositETH();
    _transfers();
    _swaps();
    _allowances();
  }

  function _depositETH() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3Ethereum.COLLECTOR.ETH_MOCK_ADDRESS()),
      address(this),
      ETH_DEPOSIT_AMOUNT
    );
    WETH(AaveV3EthereumAssets.WETH_UNDERLYING).deposit{value: ETH_DEPOSIT_AMOUNT}();
    IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      ETH_DEPOSIT_AMOUNT
    );
    CollectorUtils.depositToV3(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        amount: ETH_DEPOSIT_AMOUNT
      })
    );
  }

  function _transfers() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING),
      MiscEthereum.ECOSYSTEM_RESERVE,
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3Ethereum.COLLECTOR.ETH_MOCK_ADDRESS()),
      ACI,
      ETH_TRANSFER_AMOUNT
    );
  }

  function _swaps() internal {
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

    /// ~ 2.3M
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.USDS_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.DAI_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.USDS_ORACLE,
        amount: IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(COLLECTOR),
        slippage: 75
      })
    );

    /// ~7k
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.LUSD_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.LUSD_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.WETH_ORACLE,
        amount: IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(COLLECTOR),
        slippage: 350
      })
    );

    /// ~20k
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV2EthereumAssets.CVX_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        fromUnderlyingPriceFeed: CVX_USD_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.WETH_ORACLE,
        amount: IERC20(AaveV2EthereumAssets.CVX_UNDERLYING).balanceOf(COLLECTOR),
        slippage: 200
      })
    );

    /// ~7k
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV2EthereumAssets.FRAX_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        fromUnderlyingPriceFeed: FRAX_USD_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.WETH_ORACLE,
        amount: IERC20(AaveV2EthereumAssets.FRAX_UNDERLYING).balanceOf(COLLECTOR),
        slippage: 350
      })
    );
  }

  function _allowances() internal {
    /// Acquire ETH allowances
    AaveV3Ethereum.COLLECTOR.approve(
      MATIC_MAINNET,
      AAVE_FINANCE_COMMITEE,
      MATIC_MAINNET.balanceOf(COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.approve(
      STMATIC_MAINNET,
      AAVE_FINANCE_COMMITEE,
      STMATIC_MAINNET.balanceOf(COLLECTOR)
    );

    /// Aave buyback allowance
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      AAVE_FINANCE_COMMITEE,
      USDT_BUYBACK_AMOUNT
    );
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      AAVE_FINANCE_COMMITEE,
      USDC_BUYBACK_AMOUNT
    );

    /// Merit + Ahab Programs
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MERIT_SAFE,
      GHO_ALLOWANCE_AMOUNT
    );

    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      MERIT_SAFE,
      WETH_ALLOWANCE_AMOUNT
    );
  }
}
