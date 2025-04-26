// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Ethereum_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant ECOSYSTEM_RESERVE = 0x25F2226B597E8F9514B3F68F00f494cF4f286491;
  address public constant AAVE_FINANCE_COMMITEE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

  uint256 public constant USDT_SWAP_AMOUNT = 2_000_000e6;
  uint256 public constant USDC_SWAP_AMOUNT = 2_000_000e6;
  uint256 public constant USDT_BUYBACK_AMOUNT = 3_000_000e6;
  uint256 public constant USDC_BUYBACK_AMOUNT = 3_000_000e6;

  function execute() external {
    _transfers();
    _swaps();
    _aaveBuybackAllowance();
  }

  function _transfers() internal {
    /// steward already withdrew aave from v2 & v3, only need to transfer all
    uint256 aaveBalance = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING),
      ECOSYSTEM_RESERVE,
      aaveBalance
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
        slippage: 150
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
        fromUnderlyingPriceFeed: AaveV2EthereumAssets.CVX_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.WETH_ORACLE,
        amount: IERC20(AaveV2EthereumAssets.CVX_UNDERLYING).balanceOf(COLLECTOR),
        slippage: 100
      })
    );

    /// ~13k
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV2EthereumAssets.RAI_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV2EthereumAssets.RAI_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.WETH_ORACLE,
        amount: IERC20(AaveV2EthereumAssets.RAI_UNDERLYING).balanceOf(COLLECTOR),
        slippage: 150
      })
    );

    /// ~11k
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV2EthereumAssets.MANA_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.WETH_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV2EthereumAssets.MANA_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.WETH_ORACLE,
        amount: IERC20(AaveV2EthereumAssets.MANA_UNDERLYING).balanceOf(COLLECTOR),
        slippage: 150
      })
    );
  }

  function _aaveBuybackAllowance() internal {
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
  }
}
