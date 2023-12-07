// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title TokenLogic & karpatkey Service Provider Partnership
 * @author efecarranza.eth
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/temp-check-financial-services-proposal-karpatkey-tokenlogic/15633
 */
contract AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207 is
  IProposalGenericExecutor
{
  address public constant STREAM_ONE_RECEIVER = 0x58e6c7ab55Aa9012eAccA16d1ED4c15795669E1C;
  address public constant STREAM_TWO_RECEIVER = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;

  uint256 public constant STREAM_ONE_AMOUNT = 220_000 ether;
  uint256 public constant STREAM_TWO_AMOUNT = 180_000 ether;

  uint256 public constant STREAM_DURATION = 180 days;

  uint256 public constant ACTUAL_AMOUNT_ONE =
    (STREAM_ONE_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  uint256 public constant ACTUAL_AMOUNT_TWO =
    (STREAM_TWO_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.createStream(
      STREAM_ONE_RECEIVER,
      ACTUAL_AMOUNT_ONE,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );

    AaveV3Ethereum.COLLECTOR.createStream(
      STREAM_TWO_RECEIVER,
      ACTUAL_AMOUNT_TWO,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
