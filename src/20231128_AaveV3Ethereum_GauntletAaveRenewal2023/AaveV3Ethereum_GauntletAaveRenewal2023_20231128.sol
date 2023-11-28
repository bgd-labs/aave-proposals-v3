// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Gauntlet <> Aave Renewal 2023
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x8771479c821f55fe5fd16f939047de573203ac540282810a94ccf1bce2e2c021
 * - Discussion: https://governance.aave.com/t/arfc-gauntlet-aave-renewal-2023/15380
 */
contract AaveV3Ethereum_GauntletAaveRenewal2023_20231128 is IProposalGenericExecutor {
  address public constant GAUNTLET_STREAMING_BENEFICIARY = 0xD20c9667bf0047F313228F9fE11F8b9F8Dc29bBa;
  address public constant GAUNTLET_INSOLVENCY_REFUND = 0x7667095Caa12b79fCa489ff6E2198Ca01fDAe057;

  uint256 public constant STREAM_DURATION = 365 days;

  uint256 public constant INSOLVENCY_REFUND_AMOUNT_USDT = 480_000e6;

  uint256 public constant GAUNTLET_STREAM_AMOUNT_USDT = 320_000e6;
  uint256 public constant GAUNTLET_STREAM_AMOUNT_GHO = 800_000e18;

  uint256 public constant ACTUAL_GAUNTLET_STREAM_AMOUNT_USDT =
    (GAUNTLET_STREAM_AMOUNT_USDT / STREAM_DURATION) * STREAM_DURATION;

  uint256 public constant ACTUAL_GAUNTLET_STREAM_AMOUNT_GHO =
    (GAUNTLET_STREAM_AMOUNT_GHO / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    // aUSDT stream
    AaveV3Ethereum.COLLECTOR.createStream(
      GAUNTLET_STREAMING_BENEFICIARY,
      ACTUAL_GAUNTLET_STREAM_AMOUNT_USDT,
      AaveV2EthereumAssets.USDT_A_TOKEN,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    // GHO stream
    AaveV3Ethereum.COLLECTOR.createStream(
      GAUNTLET_STREAMING_BENEFICIARY,
      ACTUAL_GAUNTLET_STREAM_AMOUNT_GHO,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    // insolvency refund payment
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      GAUNTLET_INSOLVENCY_REFUND,
      INSOLVENCY_REFUND_AMOUNT_USDT
    );
  }
}
