// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @title Aave BGD Phase 6
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x3fcc8b9500e341189ff66cbbf690c6a738a2ae49d6e16aa21b8a8f1fd2597e80
 * - Discussion: https://governance.aave.com/t/arfc-aave-bored-ghosts-developing-phase-6/23191
 */
contract AaveV3Ethereum_AaveBGDPhase6_20251023 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant BGD_RECEIVER = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant STOP_TIME = 1775001600; // ends on 1 April 2026

  uint256 public constant UPFRONT_AUSDC_AMOUNT = 1_320_000e6;
  uint256 public constant UPFRONT_AAVE_AMOUNT = 1_800e18;

  uint256 public constant STREAM_AGHO_AMOUNT = 880_000e6;
  uint256 public constant STREAM_AAVE_AMOUNT = 1_200e18;

  function execute() external {
    // Upfront
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      BGD_RECEIVER,
      UPFRONT_AUSDC_AMOUNT
    );
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      BGD_RECEIVER,
      UPFRONT_AAVE_AMOUNT
    );

    // Streams
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
