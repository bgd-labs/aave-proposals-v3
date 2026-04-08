// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

/**
 * @title Aave Will Win Framework: Primary Funding Request
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aavedao.eth/proposal/0x35901c1a7cd2baf56dfd120024793b30dd73c52e1c0a9810ff78efbca3b5fbcb
 * - Discussion: https://governance.aave.com/t/arfc-aave-will-win-framework/24352
 */
contract AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407 is
  IProposalGenericExecutor
{
  using CollectorUtils for ICollector;

  address public constant AAVE_LABS = 0x488c053F07391dC78b12Da7107eb22aF77A255a1;

  uint256 public constant UPFRONT_AGHO_AMOUNT = 5_000_000e18;

  uint256 public constant STREAM_ONE_AGHO_AMOUNT = 5_000_000e18;
  uint256 public constant STREAM_ONE_AGHO_DURATION = 180 days;

  uint256 public constant STREAM_TWO_AGHO_AMOUNT = 15_000_000e18;
  uint256 public constant STREAM_TWO_AGHO_DURATION = 365 days;

  uint256 public constant STREAM_AAVE_AMOUNT = 75_000e18;
  uint256 public constant STREAM_AAVE_DURATION = 4 * 365 days;

  function execute() external {
    _upfrontAmount();
    _stablecoinStreams();
    _aaveStream();
  }

  function _upfrontAmount() internal {
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      AAVE_LABS,
      UPFRONT_AGHO_AMOUNT
    );
  }

  function _stablecoinStreams() internal {
    AaveV3EthereumLido.COLLECTOR.stream(
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: AAVE_LABS,
        amount: STREAM_ONE_AGHO_AMOUNT,
        start: block.timestamp,
        duration: STREAM_ONE_AGHO_DURATION
      })
    );

    AaveV3EthereumLido.COLLECTOR.stream(
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: AAVE_LABS,
        amount: STREAM_TWO_AGHO_AMOUNT,
        start: block.timestamp,
        duration: STREAM_TWO_AGHO_DURATION
      })
    );
  }

  function _aaveStream() internal {
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream({
      collector: MiscEthereum.ECOSYSTEM_RESERVE,
      recipient: AAVE_LABS,
      deposit: (STREAM_AAVE_AMOUNT / STREAM_AAVE_DURATION) * STREAM_AAVE_DURATION,
      tokenAddress: AaveV3EthereumAssets.AAVE_UNDERLYING,
      startTime: block.timestamp,
      stopTime: block.timestamp + STREAM_AAVE_DURATION
    });
  }
}
