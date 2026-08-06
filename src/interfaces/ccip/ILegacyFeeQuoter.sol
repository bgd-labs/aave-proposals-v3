// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IClient} from './IClient.sol';
import {IInternal} from './IInternal.sol';

/// @dev Minimal FeeQuoter interface (CCIP 1.6 / 2.0) exposing the views the OnRamp uses
/// when emitting `CCIPMessageSent`, so tests can reconstruct the exact emitted message.
interface ILegacyFeeQuoter {
  /// @notice Validates & converts the user supplied extraArgs and reports the resolved
  /// out-of-order execution flag (the OnRamp emits `convertedExtraArgs`, not the raw args).
  function processMessageArgs(
    uint64 destChainSelector,
    address feeToken,
    uint256 feeTokenAmount,
    bytes calldata extraArgs,
    bytes calldata messageReceiver
  )
    external
    view
    returns (uint256 msgFeeJuels, bool isOutOfOrderExecution, bytes memory convertedExtraArgs);

  /// @notice Returns the per-token `destExecData` (encoded dest gas amount) the OnRamp emits.
  function processPoolReturnData(
    uint64 destChainSelector,
    IInternal.EVM2AnyTokenTransfer[] calldata onRampTokenTransfers,
    IClient.EVMTokenAmount[] calldata sourceTokenAmounts
  ) external view returns (bytes[] memory destExecDataPerToken);
}
