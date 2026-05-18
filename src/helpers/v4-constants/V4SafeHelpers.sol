// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title V4SafeHelpers
 * @author Aave Labs
 * @notice Builds calldata for Gnosis Safe `execTransaction` actions
 */
library V4SafeHelpers {
  /// @notice Trusted Gnosis Safe MultiSendCallOnly contract.
  address internal constant MULTI_SEND_CALL_ONLY = 0x9641d764fc13c8B624c04430C7356C1C7C8102e2;

  struct Action {
    address to;
    bytes data;
  }

  /// @notice Build Safe `execTransaction` parameters for a single action.
  /// @dev Operation = 0 (CALL).
  function createSafeCalldata(
    Action memory action
  ) internal pure returns (address to, bytes memory data, uint8 operation) {
    to = action.to;
    data = action.data;
    operation = 0;
  }

  /// @notice Build Safe `execTransaction` parameters for a batch of actions.
  /// @dev Falls through to the single-action path if `actions.length == 1`.
  /// Otherwise returns a delegatecall (operation = 1) to MultiSendCallOnly.
  function createSafeCalldata(
    Action[] memory actions
  ) internal pure returns (address to, bytes memory data, uint8 operation) {
    require(actions.length > 0, 'NO_ACTIONS');
    if (actions.length == 1) {
      return createSafeCalldata(actions[0]);
    }
    to = MULTI_SEND_CALL_ONLY;
    data = _encodeMultiSend(actions);
    operation = 1;
  }

  /// @dev Encode actions into Gnosis Safe MultiSendCallOnly packed format.
  /// Each tx: operation (1 byte) + to (20) + value (32) + dataLength (32) + data (variable).
  function _encodeMultiSend(Action[] memory actions) private pure returns (bytes memory) {
    bytes memory packed;
    for (uint256 i = 0; i < actions.length; i++) {
      packed = abi.encodePacked(
        packed,
        uint8(0), // operation = call
        actions[i].to,
        uint256(0), // value
        actions[i].data.length,
        actions[i].data
      );
    }
    return abi.encodeWithSelector(bytes4(0x8d80ff0a), packed); // multiSend(bytes)
  }
}
