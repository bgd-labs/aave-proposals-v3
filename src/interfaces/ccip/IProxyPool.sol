// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITypeAndVersion} from './ITypeAndVersion.sol';
import {IRateLimiter} from './IRateLimiter.sol';

interface IProxyPool is ITypeAndVersion {
  struct ChainUpdate {
    uint64 remoteChainSelector;
    bool allowed;
    bytes remotePoolAddress;
    bytes remoteTokenAddress;
    IRateLimiter.Config inboundRateLimiterConfig;
    IRateLimiter.Config outboundRateLimiterConfig;
  }

  function owner() external view returns (address);
  function transferOwnership(address newOwner) external;
  function acceptOwnership() external;
  function getRouter() external view returns (address);
  function setRouter(address router) external;
  function applyChainUpdates(ChainUpdate[] memory updates) external;
  function isSupportedChain(uint64 chainSelector) external view returns (bool);
  function getPreviousPool() external view returns (address);
  function getCurrentInboundRateLimiterState(
    uint64 chainSelector
  ) external view returns (IRateLimiter.TokenBucket memory);
  function getCurrentOutboundRateLimiterState(
    uint64 chainSelector
  ) external view returns (IRateLimiter.TokenBucket memory);
  function getRemotePool(uint64 remoteChainSelector) external view returns (bytes memory);
  function getRemoteToken(uint64 remoteChainSelector) external view returns (bytes memory);
}
