// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRateLimiter} from './IRateLimiter.sol';

interface IUpgradeableBurnMintTokenPool {
  error AggregateValueMaxCapacityExceeded(uint256 capacity, uint256 requested);
  error AggregateValueRateLimitReached(uint256 minWaitInSeconds, uint256 available);
  error AllowListNotEnabled();
  error BadARMSignal();
  error BucketOverfilled();
  error CallerIsNotARampOnRouter(address caller);
  error ChainAlreadyExists(uint64 chainSelector);
  error ChainNotAllowed(uint64 remoteChainSelector);
  error DisabledNonZeroRateLimit(IRateLimiter.Config config);
  error InvalidRatelimitRate(IRateLimiter.Config rateLimiterConfig);
  error NonExistentChain(uint64 remoteChainSelector);
  error RateLimitMustBeDisabled();
  error SenderNotAllowed(address sender);
  error TokenMaxCapacityExceeded(uint256 capacity, uint256 requested, address tokenAddress);
  error TokenRateLimitReached(uint256 minWaitInSeconds, uint256 available, address tokenAddress);
  error Unauthorized(address caller);
  error ZeroAddressNotAllowed();

  event AllowListAdd(address sender);
  event AllowListRemove(address sender);
  event Burned(address indexed sender, uint256 amount);
  event ChainAdded(
    uint64 remoteChainSelector,
    IRateLimiter.Config outboundRateLimiterConfig,
    IRateLimiter.Config inboundRateLimiterConfig
  );
  event ChainConfigured(
    uint64 remoteChainSelector,
    IRateLimiter.Config outboundRateLimiterConfig,
    IRateLimiter.Config inboundRateLimiterConfig
  );
  event ChainRemoved(uint64 remoteChainSelector);
  event ConfigChanged(IRateLimiter.Config config);
  event Initialized(uint8 version);
  event Locked(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event OwnershipTransferRequested(address indexed from, address indexed to);
  event OwnershipTransferred(address indexed from, address indexed to);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event RouterUpdated(address oldRouter, address newRouter);
  event TokensConsumed(uint256 tokens);

  function acceptOwnership() external;
  function applyAllowListUpdates(address[] memory removes, address[] memory adds) external;
  function getAllowList() external view returns (address[] memory);
  function getAllowListEnabled() external view returns (bool);
  function getArmProxy() external view returns (address armProxy);
  function getCurrentInboundRateLimiterState(
    uint64 remoteChainSelector
  ) external view returns (IRateLimiter.TokenBucket memory);
  function getCurrentOutboundRateLimiterState(
    uint64 remoteChainSelector
  ) external view returns (IRateLimiter.TokenBucket memory);
  function getProxyPool() external view returns (address proxyPool);
  function getRateLimitAdmin() external view returns (address);
  function getRouter() external view returns (address router);
  function getSupportedChains() external view returns (uint64[] memory);
  function getToken() external view returns (address token);
  function initialize(address owner, address[] memory allowlist, address router) external;
  function isSupportedChain(uint64 remoteChainSelector) external view returns (bool);
  function lockOrBurn(
    address originalSender,
    bytes memory,
    uint256 amount,
    uint64 remoteChainSelector,
    bytes memory
  ) external returns (bytes memory);
  function owner() external view returns (address);
  function releaseOrMint(
    bytes memory,
    address receiver,
    uint256 amount,
    uint64 remoteChainSelector,
    bytes memory
  ) external;
  function setChainRateLimiterConfig(
    uint64 remoteChainSelector,
    IRateLimiter.Config memory outboundConfig,
    IRateLimiter.Config memory inboundConfig
  ) external;
  function setProxyPool(address proxyPool) external;
  function setRateLimitAdmin(address rateLimitAdmin) external;
  function setRouter(address newRouter) external;
  function supportsInterface(bytes4 interfaceId) external pure returns (bool);
  function transferOwnership(address to) external;
  function typeAndVersion() external view returns (string memory);
}
