// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Aave BGD Phase 3
 * @author BGD Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf453667458e093dcd5bd986e0a62b4ef9dc914dca56ef97a8dc28ca89af6c8d3
 * - Discussion: https://governance.aave.com/t/aave-bored-ghosts-developing-phase-3/16893
 */
contract AaveV3Ethereum_AaveBGDPhase3_20240325 is IProposalGenericExecutor {
  address public constant BGD_RECIPIENT = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;

  // SCOPE 1
  uint256 public constant SCOPE_1_AAVE_UPFRONT = 3_000 ether;
  uint256 public constant SCOPE_1_AUSDT_UPFRONT = 960_000e6;
  uint256 public constant SCOPE_1_AAVE_STREAM = 2_000 ether;
  uint256 public constant SCOPE_1_GHO_STREAM = 640_000 ether;
  uint256 public constant SCOPE_1_STREAM_DURATION = 180 days;

  uint256 public constant ACTUAL_SCOPE_1_AAVE_STREAM =
    (SCOPE_1_AAVE_STREAM / SCOPE_1_STREAM_DURATION) * SCOPE_1_STREAM_DURATION;
  uint256 public constant ACTUAL_SCOPE_1_GHO_STREAM =
    (SCOPE_1_GHO_STREAM / SCOPE_1_STREAM_DURATION) * SCOPE_1_STREAM_DURATION;

  // SCOPE 2
  uint256 public constant SCOPE_2_AAVE_UPFRONT = 3_000 ether;
  uint256 public constant SCOPE_2_AUSDC_UPFRONT = 760_000e6;
  uint256 public constant SCOPE_2_AAVE_STREAM = 4_500 ether;
  uint256 public constant SCOPE_2_AUSDC_STREAM = 1_140_000e6;
  uint256 public constant SCOPE_2_STREAM_DURATION = 1; // 1 second
  uint256 public constant SCOPE_2_DELAY = 120 days;

  function execute() external {
    // UPFRONT
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      BGD_RECIPIENT,
      SCOPE_1_AAVE_UPFRONT + SCOPE_2_AAVE_UPFRONT
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      BGD_RECIPIENT,
      SCOPE_1_AUSDT_UPFRONT
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      BGD_RECIPIENT,
      SCOPE_2_AUSDC_UPFRONT
    );

    // SCOPE 1 STREAM
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      BGD_RECIPIENT,
      ACTUAL_SCOPE_1_AAVE_STREAM,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      block.timestamp,
      block.timestamp + SCOPE_1_STREAM_DURATION
    );
    AaveV3Ethereum.COLLECTOR.createStream(
      BGD_RECIPIENT,
      ACTUAL_SCOPE_1_GHO_STREAM,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + SCOPE_1_STREAM_DURATION
    );

    // SCOPE 2 STREAM
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      BGD_RECIPIENT,
      SCOPE_2_AAVE_STREAM,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      block.timestamp + SCOPE_2_DELAY, // start of the stream will be after 4 months
      block.timestamp + SCOPE_2_DELAY + SCOPE_2_STREAM_DURATION // end of the stream will be one second after the start
    );
    AaveV3Ethereum.COLLECTOR.createStream(
      BGD_RECIPIENT,
      SCOPE_2_AUSDC_STREAM,
      AaveV3EthereumAssets.USDC_A_TOKEN,
      block.timestamp + SCOPE_2_DELAY, // start of the stream will be after 4 months
      block.timestamp + SCOPE_2_DELAY + SCOPE_2_STREAM_DURATION // end of the stream will be one second after the start
    );
  }
}
