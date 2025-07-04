// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ChainlinkEthereum} from 'aave-address-book/ChainlinkEthereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title CEX Earn Funding Proposal
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xa390fb9061fd689a5d93519a7a9dae23d76b4010b3eea6aaedc70ea7aaed9310
 * - Discussion: https://governance.aave.com/t/arfc-gho-cex-earn-incentive-program/22284
 */
contract AaveV3EthereumLido_CEXEarnFundingProposal_20250625 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  // https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa
  address public constant AFC_SAFE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;
  uint256 public constant CEX_EARN_AMOUNT = 5_000_000 ether;

  /// Swaps Constants

  /// https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;

  /// https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  uint256 public constant USDC_SWAP_AMOUNT = 2_500_000e6;
  uint256 public constant USDT_SWAP_AMOUNT = 2_500_000e6;

  function execute() external {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      AFC_SAFE,
      CEX_EARN_AMOUNT
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
        toUnderlyingPriceFeed: ChainlinkEthereum.GHO_USD,
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
        toUnderlyingPriceFeed: ChainlinkEthereum.GHO_USD,
        amount: USDT_SWAP_AMOUNT,
        slippage: 75
      })
    );
  }
}
