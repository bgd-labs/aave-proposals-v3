// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IInternal} from './IInternal.sol';
import {ITypeAndVersion} from './ITypeAndVersion.sol';

interface IEVM2EVMOffRamp_1_2 is ITypeAndVersion {
  /// @notice Execute a single message.
  /// @param message The message that will be executed.
  /// @param offchainTokenData Token transfer data to be passed to TokenPool.
  /// @dev We make this external and callable by the contract itself, in order to try/catch
  /// its execution and enforce atomicity among successful message processing and token transfer.
  /// @dev We use ERC-165 to check for the ccipReceive interface to permit sending tokens to contracts
  /// (for example smart contract wallets) without an associated message.
  function executeSingleMessage(
    IInternal.EVM2EVMMessage memory message,
    bytes[] memory offchainTokenData
  ) external;
}

interface IEVM2EVMOffRamp_1_5 is ITypeAndVersion {
  /// @notice Execute a single message.
  /// @param message The message that will be executed.
  /// @param offchainTokenData Token transfer data to be passed to TokenPool.
  /// @dev We make this external and callable by the contract itself, in order to try/catch
  /// its execution and enforce atomicity among successful message processing and token transfer.
  /// @dev We use ERC-165 to check for the ccipReceive interface to permit sending tokens to contracts
  /// (for example smart contract wallets) without an associated message.
  function executeSingleMessage(
    IInternal.EVM2EVMMessage calldata message,
    bytes[] calldata offchainTokenData,
    uint32[] memory tokenGasOverrides
  ) external;
}
