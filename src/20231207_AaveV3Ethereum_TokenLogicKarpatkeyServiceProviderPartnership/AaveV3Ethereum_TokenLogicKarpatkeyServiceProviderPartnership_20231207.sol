// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title TokenLogic & karpatkey Service Provider Partnership
 * @author efecarranza.eth
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x6e57ed54cf803652ab4839ff7b7f7de08ba086fbe99163547c6188a3ee55e209
 * - Discussion: https://governance.aave.com/t/arfc-tokenlogic-karpatkey-service-provider-partnership/15755
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

  uint256 public constant STREAM_TO_CANCEL = 100017; // ipns://app.aave.com/governance/proposal/346/

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

    AaveV3Ethereum.COLLECTOR.cancelStream(STREAM_TO_CANCEL);
  }
}
