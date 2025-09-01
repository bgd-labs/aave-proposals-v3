// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {IEVM2EVMOffRamp_1_5} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GhoCCIPChains} from '../constants/GhoCCIPChains.sol';
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';

import {AaveV3GHOLane} from '../AaveV3GHOLane.sol';

abstract contract AaveV3GHOLaneTest is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    uint64 destChainSelector;
    address destToken;
  }

  AaveV3GHOLane internal proposal;

  string internal forkRpcAlias;
  uint256 internal immutable FORK_BLOCK_NUMBER;
  uint64 internal immutable LOCAL_CHAIN_SELECTOR;
  uint64 internal immutable REMOTE_CHAIN_SELECTOR;
  uint64 internal immutable ETH_CHAIN_SELECTOR;
  IGhoToken internal immutable LOCAL_GHO_TOKEN;
  IGhoToken internal immutable REMOTE_GHO_TOKEN;
  IGhoToken internal immutable ETH_GHO_TOKEN;
  IUpgradeableBurnMintTokenPool_1_5_1 internal immutable LOCAL_TOKEN_POOL;
  IUpgradeableBurnMintTokenPool_1_5_1 internal immutable REMOTE_TOKEN_POOL;
  IUpgradeableBurnMintTokenPool_1_5_1 internal immutable ETH_TOKEN_POOL;
  ITokenAdminRegistry internal immutable LOCAL_TOKEN_ADMIN_REGISTRY;
  IRouter internal immutable LOCAL_CCIP_ROUTER;
  IGhoAaveSteward internal immutable LOCAL_GHO_AAVE_CORE_STEWARD;
  IGhoBucketSteward internal immutable LOCAL_GHO_BUCKET_STEWARD;
  IGhoCcipSteward internal immutable LOCAL_GHO_CCIP_STEWARD;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Burned(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address);
  error InvalidSourcePoolAddress(bytes);

  constructor(
    GhoCCIPChains.ChainInfo memory localChainInfo,
    GhoCCIPChains.ChainInfo memory remoteChainInfo,
    string memory rpcAlias,
    uint256 blockNumber
  ) {
    forkRpcAlias = rpcAlias;
    FORK_BLOCK_NUMBER = blockNumber;
    LOCAL_CHAIN_SELECTOR = localChainInfo.chainSelector;
    REMOTE_CHAIN_SELECTOR = remoteChainInfo.chainSelector;
    ETH_CHAIN_SELECTOR = GhoCCIPChains.ETHEREUM().chainSelector;
    LOCAL_GHO_TOKEN = IGhoToken(localChainInfo.ghoToken);
    REMOTE_GHO_TOKEN = IGhoToken(remoteChainInfo.ghoToken);
    ETH_GHO_TOKEN = IGhoToken(GhoCCIPChains.ETHEREUM().ghoToken);
    LOCAL_TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(localChainInfo.ghoCCIPTokenPool);
    REMOTE_TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(remoteChainInfo.ghoCCIPTokenPool);
    LOCAL_TOKEN_ADMIN_REGISTRY = ITokenAdminRegistry(localChainInfo.tokenAdminRegistry);
    ETH_TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(GhoCCIPChains.ETHEREUM().ghoCCIPTokenPool);
    LOCAL_CCIP_ROUTER = IRouter(localChainInfo.ccipRouter);
    LOCAL_GHO_AAVE_CORE_STEWARD = IGhoAaveSteward(localChainInfo.ghoAaveCoreSteward);
    LOCAL_GHO_BUCKET_STEWARD = IGhoBucketSteward(localChainInfo.ghoBucketSteward);
    LOCAL_GHO_CCIP_STEWARD = IGhoCcipSteward(localChainInfo.ghoCCIPSteward);
  }

  ///// Constants to setup

  function _ccipRateLimitCapacity() internal view virtual returns (uint128) {
    return 1_500_000e18;
  }

  function _ccipRateLimitRefillRate() internal view virtual returns (uint128) {
    return 300e18;
  }

  // Local Chain's outbound lane to Ethereum (OnRamp address)
  function _localOutboundLaneToEth() internal view virtual returns (IEVM2EVMOnRamp) {
    return IEVM2EVMOnRamp(_getOnRamp(ETH_CHAIN_SELECTOR));
  }

  // Local Chain's inbound lane from Ethereum (OffRamp address)
  function _localInboundLaneFromEth() internal view virtual returns (IEVM2EVMOffRamp_1_5) {
    return IEVM2EVMOffRamp_1_5(_getOffRamp(ETH_CHAIN_SELECTOR));
  }

  // Local Chain's outbound lane to Remote Chain (OnRamp address)
  function _localOutboundLaneToRemote() internal view virtual returns (IEVM2EVMOnRamp) {
    return IEVM2EVMOnRamp(_getOnRamp(REMOTE_CHAIN_SELECTOR));
  }

  // Local Chain's inbound lane from Remote Chain (OffRamp address)
  function _localInboundLaneFromRemote() internal view virtual returns (IEVM2EVMOffRamp_1_5) {
    return IEVM2EVMOffRamp_1_5(_getOffRamp(REMOTE_CHAIN_SELECTOR));
  }

  function _deployAaveV3GHOLaneProposal() internal virtual returns (AaveV3GHOLane);

  function _expectedSupportedChains()
    internal
    view
    virtual
    returns (GhoCCIPChains.ChainInfo[] memory)
  {
    return GhoCCIPChains.getAllChainsExcept(LOCAL_CHAIN_SELECTOR);
  }

  function _getOnRamp(uint64 chainSelector) internal view virtual returns (address) {
    return LOCAL_CCIP_ROUTER.getOnRamp(chainSelector);
  }

  function _getOnRampFailIfNotFound(uint64 chainSelector) internal view virtual returns (address) {
    address offRamp = _getOffRamp(chainSelector);
    assertNotEq(offRamp, address(0), 'No offRamp found for the supported chain');
    return offRamp;
  }

  function _getOffRamp(uint64 chainSelector) internal view virtual returns (address) {
    IRouter.OffRamp[] memory offRamps = LOCAL_CCIP_ROUTER.getOffRamps();
    for (uint256 i = 0; i < offRamps.length; i++) {
      if (
        offRamps[i].sourceChainSelector == chainSelector &&
        _hasOffRampExpectedVersion(offRamps[i].offRamp)
      ) {
        return offRamps[i].offRamp;
      }
    }
    return address(0);
  }

  function _offRampExpectedVersion() internal view virtual returns (string memory) {
    return 'EVM2EVMOffRamp 1.5.0';
  }

  function _hasOffRampExpectedVersion(address offRamp) internal view virtual returns (bool) {
    return
      keccak256(bytes(IEVM2EVMOffRamp_1_5(offRamp).typeAndVersion())) ==
      keccak256(bytes(_offRampExpectedVersion()));
  }

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl(forkRpcAlias), FORK_BLOCK_NUMBER);
    proposal = _deployAaveV3GHOLaneProposal();
    _validateConstants();
  }

  function _expectedLocalTokenPoolTypeAndVersion() internal view virtual returns (string memory) {
    return 'BurnMintTokenPool 1.5.1';
  }

  function _validateConstants() internal view virtual {
    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory chainLanesToAdd = proposal
      .lanesToAdd();
    assertEq(chainLanesToAdd.length, 1);
    assertEq(proposal.lanesToRemove().length, 0);
    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate memory remoteChainToAdd = chainLanesToAdd[0];

    assertEq(remoteChainToAdd.remoteChainSelector, REMOTE_CHAIN_SELECTOR);
    assertEq(address(proposal.TOKEN_POOL()), address(LOCAL_TOKEN_POOL));
    assertEq(remoteChainToAdd.remotePoolAddresses[0], abi.encode(address(REMOTE_TOKEN_POOL)));
    assertEq(remoteChainToAdd.remoteTokenAddress, abi.encode(address(REMOTE_GHO_TOKEN)));
    assertEq(remoteChainToAdd.outboundRateLimiterConfig.capacity, _ccipRateLimitCapacity());
    assertEq(remoteChainToAdd.outboundRateLimiterConfig.rate, _ccipRateLimitRefillRate());
    assertEq(remoteChainToAdd.inboundRateLimiterConfig.capacity, _ccipRateLimitCapacity());
    assertEq(remoteChainToAdd.inboundRateLimiterConfig.rate, _ccipRateLimitRefillRate());

    assertEq(LOCAL_TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(LOCAL_TOKEN_POOL.typeAndVersion(), _expectedLocalTokenPoolTypeAndVersion());
    assertEq(LOCAL_CCIP_ROUTER.typeAndVersion(), 'Router 1.2.0');

    _assertOnAndOffRamps();
  }

  function _assertOnAndOffRamps() internal view virtual {
    _assertOnRamp(
      _localOutboundLaneToEth(),
      LOCAL_CHAIN_SELECTOR,
      ETH_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOnRamp(
      _localOutboundLaneToRemote(),
      LOCAL_CHAIN_SELECTOR,
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOffRamp(
      _localInboundLaneFromEth(),
      ETH_CHAIN_SELECTOR,
      LOCAL_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOffRamp(
      _localInboundLaneFromRemote(),
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
  }

  function _assertOnRamp(
    IEVM2EVMOnRamp onRamp,
    uint64 srcSelector,
    uint64 dstSelector,
    IRouter router
  ) internal view virtual {
    assertEq(onRamp.typeAndVersion(), 'EVM2EVMOnRamp 1.5.0');
    assertEq(onRamp.getStaticConfig().chainSelector, srcSelector);
    assertEq(onRamp.getStaticConfig().destChainSelector, dstSelector);
    assertEq(onRamp.getDynamicConfig().router, address(router));
    assertEq(router.getOnRamp(dstSelector), address(onRamp));
  }

  function _assertOffRamp(
    IEVM2EVMOffRamp_1_5 offRamp,
    uint64 srcSelector,
    uint64 dstSelector,
    IRouter router
  ) internal view virtual {
    assertEq(offRamp.typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');
    assertEq(offRamp.getStaticConfig().sourceChainSelector, srcSelector);
    assertEq(offRamp.getStaticConfig().chainSelector, dstSelector);
    assertEq(offRamp.getDynamicConfig().router, address(router));
    assertTrue(router.isOffRamp(srcSelector, address(offRamp)));
  }

  function _getTokenMessage(
    CCIPSendParams memory params
  ) internal virtual returns (IClient.EVM2AnyMessage memory, IInternal.EVM2EVMMessage memory) {
    IClient.EVM2AnyMessage memory message = CCIPUtils.generateMessage(params.sender, 1);
    message.tokenAmounts[0] = IClient.EVMTokenAmount({
      token: address(LOCAL_GHO_TOKEN),
      amount: params.amount
    });

    uint256 feeAmount = LOCAL_CCIP_ROUTER.getFee(params.destChainSelector, message);
    deal(params.sender, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: LOCAL_CCIP_ROUTER,
        sourceChainSelector: LOCAL_CHAIN_SELECTOR,
        destChainSelector: params.destChainSelector,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: address(LOCAL_GHO_TOKEN),
        destinationToken: params.destToken
      })
    );

    return (message, eventArg);
  }

  function _tokenBucketToConfig(
    IRateLimiter.TokenBucket memory bucket
  ) internal view virtual returns (IRateLimiter.Config memory) {
    return
      IRateLimiter.Config({
        isEnabled: bucket.isEnabled,
        capacity: bucket.capacity,
        rate: bucket.rate
      });
  }

  function _getDisabledConfig() internal view virtual returns (IRateLimiter.Config memory) {
    return IRateLimiter.Config({isEnabled: false, capacity: 0, rate: 0});
  }

  function _getImplementation(address proxy) internal view virtual returns (address) {
    bytes32 slot = bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1);
    return address(uint160(uint256(vm.load(proxy, slot))));
  }

  function _getProxyAdmin(address proxy) internal view virtual returns (address) {
    bytes32 slot = bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1);
    return address(uint160(uint256(vm.load(proxy, slot))));
  }

  function _readInitialized(address proxy) internal view virtual returns (uint8) {
    return uint8(uint256(vm.load(proxy, bytes32(0))));
  }

  function _getRateLimiterConfig() internal view virtual returns (IRateLimiter.Config memory) {
    return IRateLimiter.Config({isEnabled: true, capacity: 1_500_000e18, rate: 300e18});
  }

  function _getOutboundRefillTime(uint256 amount) internal view virtual returns (uint256) {
    return (amount / _ccipRateLimitRefillRate()) + 1; // account for rounding
  }

  function _getInboundRefillTime(uint256 amount) internal view virtual returns (uint256) {
    return amount / _ccipRateLimitRefillRate() + 1; // account for rounding
  }

  function _min(uint256 a, uint256 b) internal view virtual returns (uint256) {
    return a < b ? a : b;
  }

  function assertEq(
    IRateLimiter.TokenBucket memory bucket,
    IRateLimiter.Config memory config
  ) internal view virtual {
    assertEq(bucket.isEnabled, config.isEnabled);
    assertEq(bucket.capacity, config.capacity);
    assertEq(bucket.rate, config.rate);
  }
}
