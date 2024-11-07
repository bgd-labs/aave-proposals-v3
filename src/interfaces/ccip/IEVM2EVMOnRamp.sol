// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IInternal} from './IInternal.sol';

interface IEVM2EVMOnRamp {
  struct TokenTransferFeeConfig {
    uint32 minFeeUSDCents; // ──────────╮ Minimum fee to charge per token transfer, multiples of 0.01 USD
    uint32 maxFeeUSDCents; //           │ Maximum fee to charge per token transfer, multiples of 0.01 USD
    uint16 deciBps; //                  │ Basis points charged on token transfers, multiples of 0.1bps, or 1e-5
    uint32 destGasOverhead; //          │ Gas charged to execute the token transfer on the destination chain
    //                                  │ Extra data availability bytes that are returned from the source pool and sent
    uint32 destBytesOverhead; //        │ to the destination pool. Must be >= Pool.CCIP_LOCK_OR_BURN_V1_RET_BYTES
    bool aggregateRateLimitEnabled; //  │ Whether this transfer token is to be included in Aggregate Rate Limiting
    bool isEnabled; // ─────────────────╯ Whether this token has custom transfer fees
  }

  struct DynamicConfig {
    address router; // ──────────────────────────╮ Router address
    uint16 maxNumberOfTokensPerMsg; //           │ Maximum number of distinct ERC20 token transferred per message
    uint32 destGasOverhead; //                   │ Gas charged on top of the gasLimit to cover destination chain costs
    uint16 destGasPerPayloadByte; //             │ Destination chain gas charged for passing each byte of `data` payload to receiver
    uint32 destDataAvailabilityOverheadGas; // ──╯ Extra data availability gas charged on top of the message, e.g. for OCR
    uint16 destGasPerDataAvailabilityByte; // ───╮ Amount of gas to charge per byte of message data that needs availability
    uint16 destDataAvailabilityMultiplierBps; // │ Multiplier for data availability gas, multiples of bps, or 0.0001
    address priceRegistry; //                    │ Price registry address
    uint32 maxDataBytes; //                      │ Maximum payload data size in bytes
    uint32 maxPerMsgGasLimit; // ────────────────╯ Maximum gas limit for messages targeting EVMs
    //                                           │
    // The following three properties are defaults, they can be overridden by setting the TokenTransferFeeConfig for a token
    uint16 defaultTokenFeeUSDCents; // ──────────╮ Default token fee charged per token transfer
    uint32 defaultTokenDestGasOverhead; //       │ Default gas charged to execute the token transfer on the destination chain
    bool enforceOutOfOrder; // ──────────────────╯ Whether to enforce the allowOutOfOrderExecution extraArg value to be true.
  }

  /// @notice Gets the next sequence number to be used in the onRamp
  /// @return the next sequence number to be used
  function getExpectedNextSequenceNumber() external view returns (uint64);

  /// @notice Get the next nonce for a given sender
  /// @param sender The sender to get the nonce for
  /// @return nonce The next nonce for the sender
  function getSenderNonce(address sender) external view returns (uint64 nonce);

  /// @notice Adds and removed token pools.
  /// @param removes The tokens and pools to be removed
  /// @param adds The tokens and pools to be added.
  function applyPoolUpdates(
    IInternal.PoolUpdate[] memory removes,
    IInternal.PoolUpdate[] memory adds
  ) external;

  /// @notice Get the pool for a specific token
  /// @param destChainSelector The destination chain selector
  /// @param sourceToken The source chain token to get the pool for
  /// @return pool Token pool
  function getPoolBySourceToken(
    uint64 destChainSelector,
    address sourceToken
  ) external view returns (address);

  /// @notice Gets the transfer fee config for a given token.
  function getTokenTransferFeeConfig(
    address token
  ) external view returns (TokenTransferFeeConfig memory tokenTransferFeeConfig);

  /// @notice Returns the dynamic onRamp config.
  /// @return dynamicConfig the configuration.
  function getDynamicConfig() external view returns (DynamicConfig memory dynamicConfig);
}
