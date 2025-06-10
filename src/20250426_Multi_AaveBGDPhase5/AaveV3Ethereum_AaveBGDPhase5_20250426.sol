// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @title Aave BGD Phase 5
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xcad607fa0b4cc00eb09d8af5a6506d64b74a0713b4261014ca3f23fa8afe4c07
 * - Discussion: https://governance.aave.com/t/arfc-aave-bored-ghosts-developing-phase-5/21803
 */
contract AaveV3Ethereum_AaveBGDPhase5_20250426 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant BGD_RECEIVER = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant STOP_TIME = 1759276800; // ends on 1 October 2025

  uint256 public constant UPFRONT_AUSDT_AMOUNT = 1_150_000e6;
  uint256 public constant UPFRONT_AAVE_AMOUNT = 2_000e18;

  uint256 public constant STREAM_AGHO_AMOUNT = 1_150_000e18;
  uint256 public constant STREAM_AAVE_AMOUNT = UPFRONT_AAVE_AMOUNT;

  function execute() external {
    // -- Upfront
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      BGD_RECEIVER,
      UPFRONT_AUSDT_AMOUNT
    );
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      BGD_RECEIVER,
      UPFRONT_AAVE_AMOUNT
    );

    // -- Streams
    uint256 streamsDuration = STOP_TIME - block.timestamp;

    AaveV3Ethereum.COLLECTOR.stream(
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: BGD_RECEIVER,
        amount: STREAM_AGHO_AMOUNT,
        start: block.timestamp,
        duration: streamsDuration
      })
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      BGD_RECEIVER,
      (STREAM_AAVE_AMOUNT / streamsDuration) * streamsDuration,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      block.timestamp,
      STOP_TIME
    );
  }
}
