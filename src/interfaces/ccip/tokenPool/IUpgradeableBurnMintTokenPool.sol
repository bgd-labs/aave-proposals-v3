// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRateLimiter} from '../IRateLimiter.sol';
import {IPool} from './IPool.sol';

interface IUpgradeableBurnMintTokenPool_1_4 {
  struct ChainUpdate {
    uint64 remoteChainSelector;
    bool allowed;
    IRateLimiter.Config outboundIRateLimiterConfig;
    IRateLimiter.Config inboundIRateLimiterConfig;
  }

  error AggregateValueMaxCapacityExceeded(uint256 capacity, uint256 requested);
  error AggregateValueRateLimitReached(uint256 minWaitInSeconds, uint256 available);
  error AllowListNotEnabled();
  error BadARMSignal();
  error BucketOverfilled();
  error CallerIsNotARampOnRouter(address caller);
  error ChainAlreadyExists(uint64 chainSelector);
  error ChainNotAllowed(uint64 remoteChainSelector);
  error DisabledNonZeroRateLimit(IRateLimiter.Config config);
  error InvalidRatelimitRate(IRateLimiter.Config IRateLimiterConfig);
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
    IRateLimiter.Config outboundIRateLimiterConfig,
    IRateLimiter.Config inboundIRateLimiterConfig
  );
  event ChainConfigured(
    uint64 remoteChainSelector,
    IRateLimiter.Config outboundIRateLimiterConfig,
    IRateLimiter.Config inboundIRateLimiterConfig
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
  function applyChainUpdates(ChainUpdate[] memory chains) external;
  function directBurn(uint256 amount) external;
  function getAllowList() external view returns (address[] memory);
  function getAllowListEnabled() external view returns (bool);
  function getArmProxy() external view returns (address armProxy);
  function getCurrentInboundIRateLimiterState(
    uint64 remoteChainSelector
  ) external view returns (IRateLimiter.TokenBucket memory);
  function getCurrentOutboundIRateLimiterState(
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

interface IUpgradeableBurnMintTokenPool_1_5_1 {
  struct ChainUpdate {
    uint64 remoteChainSelector;
    bytes[] remotePoolAddresses;
    bytes remoteTokenAddress;
    IRateLimiter.Config outboundRateLimiterConfig;
    IRateLimiter.Config inboundRateLimiterConfig;
  }

  error AggregateValueMaxCapacityExceeded(uint256 capacity, uint256 requested);
  error AggregateValueRateLimitReached(uint256 minWaitInSeconds, uint256 available);
  error AllowListNotEnabled();
  error BucketOverfilled();
  error CallerIsNotARampOnRouter(address caller);
  error CannotTransferToSelf();
  error ChainAlreadyExists(uint64 chainSelector);
  error ChainNotAllowed(uint64 remoteChainSelector);
  error CursedByRMN();
  error DisabledNonZeroRateLimit(IRateLimiter.Config config);
  error InvalidDecimalArgs(uint8 expected, uint8 actual);
  error InvalidRateLimitRate(IRateLimiter.Config IRateLimiterConfig);
  error InvalidRemoteChainDecimals(bytes sourcePoolData);
  error InvalidRemotePoolForChain(uint64 remoteChainSelector, bytes remotePoolAddress);
  error InvalidSourcePoolAddress(bytes sourcePoolAddress);
  error InvalidToken(address token);
  error MustBeProposedOwner();
  error NonExistentChain(uint64 remoteChainSelector);
  error OnlyCallableByOwner();
  error OverflowDetected(uint8 remoteDecimals, uint8 localDecimals, uint256 remoteAmount);
  error OwnerCannotBeZero();
  error PoolAlreadyAdded(uint64 remoteChainSelector, bytes remotePoolAddress);
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
    bytes remoteToken,
    IRateLimiter.Config outboundIRateLimiterConfig,
    IRateLimiter.Config inboundIRateLimiterConfig
  );
  event ChainConfigured(
    uint64 remoteChainSelector,
    IRateLimiter.Config outboundIRateLimiterConfig,
    IRateLimiter.Config inboundIRateLimiterConfig
  );
  event ChainRemoved(uint64 remoteChainSelector);
  event ConfigChanged(IRateLimiter.Config config);
  event Initialized(uint8 version);
  event Locked(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event OwnershipTransferRequested(address indexed from, address indexed to);
  event OwnershipTransferred(address indexed from, address indexed to);
  event RateLimitAdminSet(address rateLimitAdmin);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event RemotePoolAdded(uint64 indexed remoteChainSelector, bytes remotePoolAddress);
  event RemotePoolRemoved(uint64 indexed remoteChainSelector, bytes remotePoolAddress);
  event RouterUpdated(address oldRouter, address newRouter);
  event TokensConsumed(uint256 tokens);

  function acceptOwnership() external;
  function addRemotePool(uint64 remoteChainSelector, bytes memory remotePoolAddress) external;
  function applyAllowListUpdates(address[] memory removes, address[] memory adds) external;
  function applyChainUpdates(
    uint64[] memory remoteChainSelectorsToRemove,
    ChainUpdate[] memory chainsToAdd
  ) external;
  function directMint(address to, uint256 amount) external;
  function getAllowList() external view returns (address[] memory);
  function getAllowListEnabled() external view returns (bool);
  function getCurrentInboundRateLimiterState(
    uint64 remoteChainSelector
  ) external view returns (IRateLimiter.TokenBucket memory);
  function getCurrentOutboundRateLimiterState(
    uint64 remoteChainSelector
  ) external view returns (IRateLimiter.TokenBucket memory);
  function getRateLimitAdmin() external view returns (address);
  function getRemotePools(uint64 remoteChainSelector) external view returns (bytes[] memory);
  function getRemoteToken(uint64 remoteChainSelector) external view returns (bytes memory);
  function getRmnProxy() external view returns (address rmnProxy);
  function getRouter() external view returns (address router);
  function getSupportedChains() external view returns (uint64[] memory);
  function getToken() external view returns (address token);
  function getTokenDecimals() external view returns (uint8 decimals);
  function initialize(address owner_, address[] memory allowlist, address router) external;
  function isRemotePool(
    uint64 remoteChainSelector,
    bytes memory remotePoolAddress
  ) external view returns (bool);
  function isSupportedChain(uint64 remoteChainSelector) external view returns (bool);
  function isSupportedToken(address token) external view returns (bool);
  function lockOrBurn(
    IPool.LockOrBurnInV1 memory lockOrBurnIn
  ) external returns (IPool.LockOrBurnOutV1 memory);
  function owner() external view returns (address);
  function releaseOrMint(
    IPool.ReleaseOrMintInV1 memory releaseOrMintIn
  ) external returns (IPool.ReleaseOrMintOutV1 memory);
  function removeRemotePool(uint64 remoteChainSelector, bytes memory remotePoolAddress) external;
  function setChainRateLimiterConfig(
    uint64 remoteChainSelector,
    IRateLimiter.Config memory outboundConfig,
    IRateLimiter.Config memory inboundConfig
  ) external;
  function setRateLimitAdmin(address rateLimitAdmin) external;
  function setRouter(address newRouter) external;
  function supportsInterface(bytes4 interfaceId) external pure returns (bool);
  function transferOwnership(address to) external;
  function typeAndVersion() external view returns (string memory);
}
