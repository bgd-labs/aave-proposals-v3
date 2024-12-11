// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IClient} from 'src/interfaces/ccip/IClient.sol';

interface IInternal {
  struct PoolUpdate {
    address token; // The IERC20 token address
    address pool; // The token pool address
  }

  /// @notice The cross chain message that gets committed to EVM chains.
  /// @dev RMN depends on this struct, if changing, please notify the RMN maintainers.
  struct EVM2EVMMessage {
    uint64 sourceChainSelector; // ─────────╮ the chain selector of the source chain, note: not chainId
    address sender; // ─────────────────────╯ sender address on the source chain
    address receiver; // ───────────────────╮ receiver address on the destination chain
    uint64 sequenceNumber; // ──────────────╯ sequence number, not unique across lanes
    uint256 gasLimit; //                      user supplied maximum gas amount available for dest chain execution
    bool strict; // ────────────────────────╮ DEPRECATED
    uint64 nonce; //                        │ nonce for this lane for this sender, not unique across senders/lanes
    address feeToken; // ───────────────────╯ fee token
    uint256 feeTokenAmount; //                fee token amount
    bytes data; //                            arbitrary data payload supplied by the message sender
    IClient.EVMTokenAmount[] tokenAmounts; //  array of tokens and amounts to transfer
    bytes[] sourceTokenData; //               array of token pool return values, one per token
    bytes32 messageId; //                     a hash of the message data
  }
}
