// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Aave BGD Phase 4
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x2dfb5a6e770bf7a34ddb5ab05560c24a169c63f84e9e8d373767a5b072f1f21d
 * - Discussion: https://governance.aave.com/t/aave-bored-ghosts-developing-phase-4/19484
 */
contract AaveV3Ethereum_AaveBGDPhase4_20241025 is IProposalGenericExecutor {
  address public constant BGD_RECEIVER = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant STOP_TIME = 1743485400; // ends on 1 april 2025

  uint256 public constant UPFRONT_AUSDC_AMOUNT = 1_150_000e6;
  uint256 public constant UPFRONT_AAVE_AMOUNT = 2_500e18;

  uint256 public constant STREAM_AUSDC_AMOUNT = 1_150_000e6;
  uint256 public constant STREAM_AAVE_AMOUNT = 2_500e18;

  function execute() external {
    uint256 DURATION = STOP_TIME - block.timestamp;

    // transfer half upfront
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      BGD_RECEIVER,
      UPFRONT_AUSDC_AMOUNT
    );
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      BGD_RECEIVER,
      UPFRONT_AAVE_AMOUNT
    );

    // create streams for the other half
    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumAssets.USDC_A_TOKEN,
        receiver: BGD_RECEIVER,
        amount: STREAM_AUSDC_AMOUNT,
        start: block.timestamp,
        duration: DURATION
      })
    );
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      BGD_RECEIVER,
      (STREAM_AAVE_AMOUNT / DURATION) * DURATION,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      block.timestamp,
      STOP_TIME
    );
  }
}
