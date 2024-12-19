// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveSwapper} from 'aave-helpers/src/swaps/AaveSwapper.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title TokenLogic Financial Service Provider
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xd1fdca5d69b03ed57848180d62a812ab1a1ff72f85d671c417b5ff8fb2bd0a7c
 * - Discussion: https://governance.aave.com/t/arfc-tokenlogic-financial-services-provider/20182
 */
contract AaveV3Ethereum_TokenLogicFinancialServiceProvider_20241213 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  uint256 public constant GHO_DEPOSIT_AMOUNT = 750_000e18;
  uint256 public constant A_ETH_USDC_WITHDRAW_AMOUNT = 750_000e6;

  // https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;
  // https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  // https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  uint256 public constant TOKENLOGIC_STREAM_AMOUNT = 1_000_000e18;
  address public constant TOKENLOGIC_SAFE = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;
  uint256 public constant STREAM_DURATION = 365 days;
  uint256 public constant STREAM_START_TIME = 1734225865; // Sun Dec 15 2024 01:24:25 GMT+0000
  uint256 public constant ACTUAL_STREAM_AMOUNT =
    (TOKENLOGIC_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external override {
    // deposit gho
    AaveV3EthereumLido.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3EthereumLido.POOL),
        underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        amount: GHO_DEPOSIT_AMOUNT
      })
    );

    // withdraw usdc
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        amount: A_ETH_USDC_WITHDRAW_AMOUNT
      }),
      MiscEthereum.AAVE_SWAPPER
    );

    AaveSwapper(MiscEthereum.AAVE_SWAPPER).swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      GHO_USD_FEED,
      address(AaveV3EthereumLido.COLLECTOR),
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(MiscEthereum.AAVE_SWAPPER),
      100
    );

    uint256 backDatedAmount = (ACTUAL_STREAM_AMOUNT * (block.timestamp - STREAM_START_TIME)) /
      STREAM_DURATION;

    // transfer backend amount
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumLidoAssets.GHO_A_TOKEN,
      TOKENLOGIC_SAFE,
      backDatedAmount
    );

    // stream
    AaveV3Ethereum.COLLECTOR.stream(
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: TOKENLOGIC_SAFE,
        amount: ACTUAL_STREAM_AMOUNT - backDatedAmount,
        start: block.timestamp,
        duration: STREAM_DURATION + STREAM_START_TIME - block.timestamp
      })
    );
  }
}
