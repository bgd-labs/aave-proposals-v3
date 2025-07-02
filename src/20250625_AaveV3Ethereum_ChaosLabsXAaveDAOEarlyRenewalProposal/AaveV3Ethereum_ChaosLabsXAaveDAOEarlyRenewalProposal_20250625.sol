// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
/**
 * @title Chaos Labs x Aave DAO — Early Renewal Proposal
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x9722b9690b52a159c0f6d9fb9fe805390031573d87e89a77fe90888f27ab0c3c
 * - Discussion: https://governance.aave.com/t/chaos-labs-x-aave-dao-early-renewal-proposal/22346
 */
contract AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625 is IProposalGenericExecutor {
  // stream information
  uint256 public constant STREAM_START = 1752364800; // 2025-07-13 00:00:00
  uint256 public constant STREAM_STOP = 1783900799; // 2026-07-12 23:59:59
  // budgets
  uint256 public constant GHO_STREAM_AMOUNT = 2_550_000 ether;

  uint256 public constant AAVE_AMOUNT_IN_DOLLARS = 450_000;
  uint256 public constant AAVE_PRICE = 264_73676823505275; // TWAP from 2025-05-23 to 2025-06-22
  // stream receivers
  address public constant CHAOS_LABS = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;

  function execute() external {
    uint256 start = STREAM_START;
    if (block.timestamp >= STREAM_START) {
      start = block.timestamp;
    }

    uint256 duration = STREAM_STOP - start;

    // Create aEthLidoGho stream
    CollectorUtils.stream(
      AaveV3EthereumLido.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: CHAOS_LABS,
        amount: GHO_STREAM_AMOUNT,
        start: start,
        duration: duration
      })
    );

    // Create the AAVE stream on the ecosystem reserve
    uint256 aave_amount = (AAVE_AMOUNT_IN_DOLLARS *
      10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals() *
      10 ** 14) / AAVE_PRICE; // we used 14 decimals for price

    // To interact we reserve we can't use the CollectorUtils wrapper
    // So we need to do the modulo ourself or createStream call will revert
    uint256 ACTUAL_AMOUNT = (aave_amount / duration) * duration;

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      CHAOS_LABS,
      ACTUAL_AMOUNT,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      start,
      STREAM_STOP // The non-wrapped version is (start, stop) instead of (start, duration)
    );
  }
}
