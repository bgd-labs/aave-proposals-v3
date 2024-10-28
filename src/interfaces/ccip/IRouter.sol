// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IClient} from 'src/interfaces/ccip/IClient.sol';

interface IRouter {
  error UnsupportedDestinationChain(uint64 destChainSelector);
  error InsufficientFeeTokenAmount();
  error InvalidMsgValue();

  struct OnRamp {
    uint64 destChainSelector;
    address onRamp;
  }
  struct OffRamp {
    uint64 sourceChainSelector;
    address offRamp;
  }

  function owner() external view returns (address);
  function getWrappedNative() external view returns (address);
  function getOffRamps() external view returns (OffRamp[] memory);
  function getOnRamp(uint64 destChainSelector) external view returns (address onRampAddress);
  function isOffRamp(
    uint64 sourceChainSelector,
    address offRamp
  ) external view returns (bool isOffRamp);
  function applyRampUpdates(
    OnRamp[] calldata onRampUpdates,
    OffRamp[] calldata offRampRemoves,
    OffRamp[] calldata offRampAdds
  ) external;
  function isChainSupported(uint64 chainSelector) external view returns (bool supported);
  function getSupportedTokens(uint64 chainSelector) external view returns (address[] memory tokens);
  function ccipSend(
    uint64 destinationChainSelector,
    IClient.EVM2AnyMessage memory message
  ) external payable returns (bytes32);
  function getFee(
    uint64 destinationChainSelector,
    IClient.EVM2AnyMessage memory message
  ) external view returns (uint256 fee);
}
