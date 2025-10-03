// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IClient} from 'src/interfaces/ccip/IClient.sol';

interface IInternal {
  /// @notice A collection of token price and gas price updates.
  /// @dev RMN depends on this struct, if changing, please notify the RMN maintainers.
  struct PriceUpdates {
    TokenPriceUpdate[] tokenPriceUpdates;
    GasPriceUpdate[] gasPriceUpdates;
  }

  /// @notice Token price in USD.
  /// @dev RMN depends on this struct, if changing, please notify the RMN maintainers.
  struct TokenPriceUpdate {
    address sourceToken; // Source token
    uint224 usdPerToken; // 1e18 USD per 1e18 of the smallest token denomination.
  }

  /// @notice Gas price for a given chain in USD, its value may contain tightly packed fields.
  /// @dev RMN depends on this struct, if changing, please notify the RMN maintainers.
  struct GasPriceUpdate {
    uint64 destChainSelector; // Destination chain selector
    uint224 usdPerUnitGas; // 1e18 USD per smallest unit (e.g. wei) of destination chain gas
  }

  /// @notice A timestamped uint224 value that can contain several tightly packed fields.
  struct TimestampedPackedUint224 {
    uint224 value; // ───────╮ Value in uint224, packed.
    uint32 timestamp; // ────╯ Timestamp of the most recent price update.
  }

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

  /// @notice Family-agnostic header for OnRamp & OffRamp messages.
  /// The messageId is not expected to match hash(message), since it may originate from another ramp family.
  struct RampMessageHeader {
    bytes32 messageId; // Unique identifier for the message, generated with the source chain's encoding scheme (i.e. not necessarily abi.encoded).
    uint64 sourceChainSelector; // ─╮ the chain selector of the source chain, note: not chainId.
    uint64 destChainSelector; //    │ the chain selector of the destination chain, note: not chainId.
    uint64 sequenceNumber; //       │ sequence number, not unique across lanes.
    uint64 nonce; // ───────────────╯ nonce for this lane for this sender, not unique across senders/lanes.
  }

  struct EVM2AnyTokenTransfer {
    // The source pool EVM address. This value is trusted as it was obtained through the onRamp. It can be relied
    // upon by the destination pool to validate the source pool.
    address sourcePoolAddress;
    // The EVM address of the destination token.
    // This value is UNTRUSTED as any pool owner can return whatever value they want.
    bytes destTokenAddress;
    // Optional pool data to be transferred to the destination chain. Be default this is capped at
    // CCIP_LOCK_OR_BURN_V1_RET_BYTES bytes. If more data is required, the TokenTransferFeeConfig.destBytesOverhead
    // has to be set for the specific token.
    bytes extraData;
    uint256 amount; // Amount of tokens.
    // Destination chain data used to execute the token transfer on the destination chain. For an EVM destination, it
    // consists of the amount of gas available for the releaseOrMint and transfer calls made by the offRamp.
    bytes destExecData;
  }

  /// @notice Family-agnostic message emitted from the OnRamp.
  /// Note: hash(Any2EVMRampMessage) != hash(EVM2AnyRampMessage) due to encoding & parameter differences.
  /// messageId = hash(EVM2AnyRampMessage) using the source EVM chain's encoding format.
  struct EVM2AnyRampMessage {
    RampMessageHeader header; // Message header.
    address sender; // sender address on the source chain.
    bytes data; // arbitrary data payload supplied by the message sender.
    bytes receiver; // receiver address on the destination chain.
    bytes extraArgs; // destination-chain specific extra args, such as the gasLimit for EVM chains.
    address feeToken; // fee token.
    uint256 feeTokenAmount; // fee token amount.
    uint256 feeValueJuels; // fee amount in Juels.
    EVM2AnyTokenTransfer[] tokenAmounts; // array of tokens and amounts to transfer.
  }

  struct Any2EVMTokenTransfer {
    // The source pool EVM address encoded to bytes. This value is trusted as it is obtained through the onRamp. It can
    // be relied upon by the destination pool to validate the source pool.
    bytes sourcePoolAddress;
    address destTokenAddress; // ─╮ Address of destination token
    uint32 destGasAmount; // ─────╯ The amount of gas available for the releaseOrMint and transfer calls on the offRamp.
    // Optional pool data to be transferred to the destination chain. Be default this is capped at
    // CCIP_LOCK_OR_BURN_V1_RET_BYTES bytes. If more data is required, the TokenTransferFeeConfig.destBytesOverhead
    // has to be set for the specific token.
    bytes extraData;
    uint256 amount; // Amount of tokens.
  }

  /// @notice Family-agnostic message routed to an OffRamp.
  /// Note: hash(Any2EVMRampMessage) != hash(EVM2AnyRampMessage), hash(Any2EVMRampMessage) != messageId due to encoding
  /// and parameter differences.
  struct Any2EVMRampMessage {
    RampMessageHeader header; // Message header.
    bytes sender; // sender address on the source chain.
    bytes data; // arbitrary data payload supplied by the message sender.
    address receiver; // receiver address on the destination chain.
    uint256 gasLimit; // user supplied maximum gas amount available for dest chain execution.
    Any2EVMTokenTransfer[] tokenAmounts; // array of tokens and amounts to transfer.
  }
}
