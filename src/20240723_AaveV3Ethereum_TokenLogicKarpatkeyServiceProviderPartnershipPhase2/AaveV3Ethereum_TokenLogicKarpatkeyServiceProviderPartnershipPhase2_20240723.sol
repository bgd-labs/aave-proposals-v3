// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title TokenLogic & karpatkey Service Provider Partnership-phase 2
 * @author TokenLogic & karpatkey
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc44ec840f8f7f6ca3ef2f2a4289882c4cdc1a8b3e6e9ad6b811a640097a8016a
 * - Discussion: https://governance.aave.com/t/arfc-tokenlogic-karpatkey-financial-service-providers-phase-ii/18285
 */
contract AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723 is
  IProposalGenericExecutor
{
  address public constant KARPATKEY_RECEIVER = 0x58e6c7ab55Aa9012eAccA16d1ED4c15795669E1C;
  address public constant TOKENLOGIC_RECEIVER = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;

  uint256 public constant AMOUNT = 250_000 ether;

  uint256 public constant STREAM_DURATION = 180 days;
  uint256 public constant ORIGINAL_STARTDATE = 1718673864;

  uint256 public constant ACTUAL_AMOUNT = (AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function execute() external {
    uint256 backdatedAmount = (ACTUAL_AMOUNT / STREAM_DURATION) *
      (block.timestamp - ORIGINAL_STARTDATE);

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      KARPATKEY_RECEIVER,
      backdatedAmount
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      TOKENLOGIC_RECEIVER,
      backdatedAmount
    );

    AaveV3Ethereum.COLLECTOR.createStream(
      KARPATKEY_RECEIVER,
      ACTUAL_AMOUNT - backdatedAmount,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      ORIGINAL_STARTDATE + STREAM_DURATION
    );

    AaveV3Ethereum.COLLECTOR.createStream(
      TOKENLOGIC_RECEIVER,
      ACTUAL_AMOUNT - backdatedAmount,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      ORIGINAL_STARTDATE + STREAM_DURATION
    );
  }
}
