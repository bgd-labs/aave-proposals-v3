// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title karpatkey Gho Growth Service Provider
 * @author karpatkey
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x87585d9dcb104d2946ca2def6bcf57708480fafc5e310de4850dc2fbe1820893
 * - Discussion: https://governance.aave.com/t/arfc-karpatkey-as-gho-growth-service-provider/20206
 */
contract AaveV3Ethereum_karpatkeyGhoGrowth_20241231 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  uint256 public constant KARPATKEY_STREAM_AMOUNT = 250_000e18;
  address public constant KARPATKEY_SAFE = 0x58e6c7ab55Aa9012eAccA16d1ED4c15795669E1C;
  uint256 public constant STREAM_DURATION = 180 days;
  uint256 public constant STREAM_START_TIME = 1734912000; // Sun Dec 23 2024 12:00 GMT+0000
  uint256 public constant ACTUAL_STREAM_AMOUNT =
    (KARPATKEY_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external override {
    uint256 backDatedAmount = (ACTUAL_STREAM_AMOUNT * (block.timestamp - STREAM_START_TIME)) /
      STREAM_DURATION;

    // transfer backend amount
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumLidoAssets.GHO_A_TOKEN,
      KARPATKEY_SAFE,
      backDatedAmount
    );

    // stream
    AaveV3Ethereum.COLLECTOR.stream(
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: KARPATKEY_SAFE,
        amount: ACTUAL_STREAM_AMOUNT - backDatedAmount,
        start: block.timestamp,
        duration: STREAM_DURATION + STREAM_START_TIME - block.timestamp
      })
    );
  }
}
