// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {IEVM2EVMOffRamp_1_5} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IPriceRegistry} from 'src/interfaces/ccip/IPriceRegistry.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {AaveV3Arbitrum_GHOGnosisLaunch_20250421} from './AaveV3Arbitrum_GHOGnosisLaunch_20250421.sol';
import {AaveV3Base_GHOGnosisLaunch_20250421} from './AaveV3Base_GHOGnosisLaunch_20250421.sol';
import {AaveV3Ethereum_GHOGnosisLaunch_20250421} from './AaveV3Ethereum_GHOGnosisLaunch_20250421.sol';

/**
 * @dev Test for AaveV3Base_GHOGnosisLaunch_20250421
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250421_Multi_GHOGnosisLaunch/AaveV3E2E_GHOGnosisLaunch_20250421.t.sol -vv
 */
contract AaveV3Base_GHOGnosisLaunch_20250421_Base is ProtocolV3TestBase {
  struct Common {
    IRouter router;
    IGhoToken token;
    IEVM2EVMOnRamp arbOnRamp;
    IEVM2EVMOnRamp baseOnRamp;
    IEVM2EVMOnRamp ethOnRamp;
    IEVM2EVMOffRamp_1_5 arbOffRamp;
    IEVM2EVMOffRamp_1_5 baseOffRamp;
    IEVM2EVMOffRamp_1_5 ethOffRamp;
    ITokenAdminRegistry tokenAdminRegistry;
    uint64 chainSelector;
    uint256 forkId;
  }

  struct CCIPSendParams {
    Common src;
    Common dst;
    uint256 amount;
    address sender;
  }

  struct ARB {
    AaveV3Arbitrum_GHOGnosisLaunch_20250421 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }
  struct BASE {
    AaveV3Base_GHOGnosisLaunch_20250421 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }
  struct ETH {
    AaveV3Ethereum_GHOGnosisLaunch_20250421 proposal;
    IUpgradeableLockReleaseTokenPool_1_5_1 tokenPool;
    Common c;
  }

  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60; // common across all chains
  address internal constant RMN_PROXY_BASE = 0xC842c69d54F83170C42C4d556B4F6B2ca53Dd3E8;
  address internal constant ROUTER_BASE = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;
  address internal constant GHO_TOKEN_IMPL_BASE = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;
  IGhoToken internal constant GHO_TOKEN_BASE =
    IGhoToken(0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee);
  uint256 internal constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  uint256 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  ARB internal arb;
  BASE internal base;
  ETH internal eth;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  IGhoAaveSteward internal GHO_AAVE_STEWARD_BASE;
  IGhoBucketSteward internal GHO_BUCKET_STEWARD_BASE;
  IGhoCcipSteward internal GHO_CCIP_STEWARD_BASE;

  event CCIPSendRequested(IInternal.EVM2EVMMessage message);
  event Locked(address indexed sender, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);

  function setUp() public virtual {
    arb.c.forkId = vm.createFork(vm.rpcUrl('arbitrum'), 300142041);
    base.c.forkId = vm.createFork(vm.rpcUrl('base'), 25645172);
    eth.c.forkId = vm.createFork(vm.rpcUrl('mainnet'), 21722753);

    arb.c.chainSelector = 4949039107694359620;
    base.c.chainSelector = 15971525489660198786;
    eth.c.chainSelector = 5009297550715157269;

    vm.selectFork(arb.c.forkId);
    arb.proposal = new AaveV3Arbitrum_GHOGnosisLaunch_20250421();
    arb.c.token = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);
    arb.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB);
    arb.c.tokenAdminRegistry = ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);
    arb.c.router = IRouter(arb.tokenPool.getRouter());
    arb.c.baseOnRamp = IEVM2EVMOnRamp(arb.c.router.getOnRamp(base.c.chainSelector));
    arb.c.ethOnRamp = IEVM2EVMOnRamp(arb.c.router.getOnRamp(eth.c.chainSelector));
    arb.c.baseOffRamp = IEVM2EVMOffRamp_1_5(0xb62178f8198905D0Fa6d640Bdb188E4E8143Ac4b);
    arb.c.ethOffRamp = IEVM2EVMOffRamp_1_5(0x91e46cc5590A4B9182e47f40006140A7077Dec31);

    vm.selectFork(base.c.forkId);
    base.proposal = new AaveV3Base_GHOGnosisLaunch_20250421();
    base.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(
      0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34
    );
    base.c.tokenAdminRegistry = ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);
    base.c.token = GHO_TOKEN_BASE;
    base.c.router = IRouter(base.tokenPool.getRouter());
    base.c.arbOnRamp = IEVM2EVMOnRamp(base.c.router.getOnRamp(arb.c.chainSelector));
    base.c.ethOnRamp = IEVM2EVMOnRamp(base.c.router.getOnRamp(eth.c.chainSelector));
    base.c.arbOffRamp = IEVM2EVMOffRamp_1_5(0x7D38c6363d5E4DFD500a691Bc34878b383F58d93);
    base.c.ethOffRamp = IEVM2EVMOffRamp_1_5(0xCA04169671A81E4fB8768cfaD46c347ae65371F1);

    vm.selectFork(eth.c.forkId);
    eth.proposal = new AaveV3Ethereum_GHOGnosisLaunch_20250421();
    eth.c.token = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING);
    eth.tokenPool = IUpgradeableLockReleaseTokenPool_1_5_1(
      0x06179f7C1be40863405f374E7f5F8806c728660A
    );
    eth.c.tokenAdminRegistry = ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);
    eth.c.router = IRouter(eth.tokenPool.getRouter());
    eth.c.arbOnRamp = IEVM2EVMOnRamp(eth.c.router.getOnRamp(arb.c.chainSelector));
    eth.c.baseOnRamp = IEVM2EVMOnRamp(eth.c.router.getOnRamp(base.c.chainSelector));
    eth.c.arbOffRamp = IEVM2EVMOffRamp_1_5(0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9);
    eth.c.baseOffRamp = IEVM2EVMOffRamp_1_5(0x6B4B6359Dd5B47Cdb030E5921456D2a0625a9EbD);

    _validateConfig({executed: false});
  }

  function _getTokenMessage(
    CCIPSendParams memory params
  ) internal returns (IClient.EVM2AnyMessage memory, IInternal.EVM2EVMMessage memory) {
    IClient.EVM2AnyMessage memory message = CCIPUtils.generateMessage(params.sender, 1);
    message.tokenAmounts[0] = IClient.EVMTokenAmount({
      token: address(params.src.token),
      amount: params.amount
    });

    uint256 feeAmount = params.src.router.getFee(params.dst.chainSelector, message);
    deal(params.sender, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: params.src.router,
        sourceChainSelector: params.src.chainSelector,
        destChainSelector: params.dst.chainSelector,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: address(params.src.token),
        destinationToken: address(params.dst.token)
      })
    );

    return (message, eventArg);
  }

  function _validateConfig(bool executed) internal {
    vm.selectFork(arb.c.forkId);
    assertEq(arb.c.chainSelector, 4949039107694359620);
    assertEq(address(arb.c.token), AaveV3ArbitrumAssets.GHO_UNDERLYING);
    assertEq(arb.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(arb.c.baseOnRamp, arb.c.chainSelector, base.c.chainSelector, arb.c.router);
    _assertOnRamp(arb.c.ethOnRamp, arb.c.chainSelector, eth.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.baseOffRamp, base.c.chainSelector, arb.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.ethOffRamp, eth.c.chainSelector, arb.c.chainSelector, arb.c.router);

    // proposal constants
    assertEq(arb.proposal.BASE_CHAIN_SELECTOR(), base.c.chainSelector);
    assertEq(address(arb.proposal.TOKEN_POOL()), address(arb.tokenPool));
    assertEq(arb.proposal.REMOTE_TOKEN_POOL_BASE(), address(base.tokenPool));
    assertEq(arb.proposal.REMOTE_GHO_TOKEN_BASE(), address(base.c.token));

    vm.selectFork(base.c.forkId);
    assertEq(base.c.chainSelector, 15971525489660198786);
    assertEq(base.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(base.c.arbOnRamp, base.c.chainSelector, arb.c.chainSelector, base.c.router);
    _assertOnRamp(base.c.ethOnRamp, base.c.chainSelector, eth.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.arbOffRamp, arb.c.chainSelector, base.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.ethOffRamp, eth.c.chainSelector, base.c.chainSelector, base.c.router);

    // proposal constants
    assertEq(base.proposal.ETH_CHAIN_SELECTOR(), eth.c.chainSelector);
    assertEq(base.proposal.ARB_CHAIN_SELECTOR(), arb.c.chainSelector);
    assertEq(base.proposal.CCIP_BUCKET_CAPACITY(), 20_000_000e18);
    assertEq(address(base.proposal.TOKEN_ADMIN_REGISTRY()), address(base.c.tokenAdminRegistry));
    assertEq(address(base.proposal.TOKEN_POOL()), address(base.tokenPool));
    IGhoCcipSteward ghoCcipSteward = IGhoCcipSteward(base.proposal.GHO_CCIP_STEWARD());
    assertEq(ghoCcipSteward.GHO_TOKEN_POOL(), address(base.tokenPool));
    assertEq(ghoCcipSteward.GHO_TOKEN(), address(base.c.token));
    assertEq(base.proposal.REMOTE_TOKEN_POOL_ETH(), address(eth.tokenPool));
    assertEq(base.proposal.REMOTE_TOKEN_POOL_ARB(), address(arb.tokenPool));

    vm.selectFork(eth.c.forkId);
    assertEq(eth.c.chainSelector, 5009297550715157269);
    assertEq(address(eth.c.token), AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(eth.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(eth.c.arbOnRamp, eth.c.chainSelector, arb.c.chainSelector, eth.c.router);
    _assertOnRamp(eth.c.baseOnRamp, eth.c.chainSelector, base.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.arbOffRamp, arb.c.chainSelector, eth.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.baseOffRamp, base.c.chainSelector, eth.c.chainSelector, eth.c.router);

    // proposal constants
    assertEq(eth.proposal.BASE_CHAIN_SELECTOR(), base.c.chainSelector);
    assertEq(address(eth.proposal.TOKEN_POOL()), address(eth.tokenPool));
    assertEq(eth.proposal.REMOTE_TOKEN_POOL_BASE(), address(base.tokenPool));
    assertEq(eth.proposal.REMOTE_GHO_TOKEN_BASE(), address(base.c.token));

    if (executed) {
      vm.selectFork(arb.c.forkId);
      assertEq(arb.c.tokenAdminRegistry.getPool(address(arb.c.token)), address(arb.tokenPool));
      assertEq(arb.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(arb.tokenPool.getSupportedChains()[1], base.c.chainSelector);
      assertEq(arb.tokenPool.getRemoteToken(eth.c.chainSelector), abi.encode(address(eth.c.token)));
      assertEq(
        arb.tokenPool.getRemoteToken(base.c.chainSelector),
        abi.encode(address(base.c.token))
      );
      assertEq(arb.tokenPool.getRemotePools(base.c.chainSelector).length, 1);
      assertEq(
        arb.tokenPool.getRemotePools(base.c.chainSelector)[0],
        abi.encode(address(base.tokenPool))
      );
      assertEq(arb.tokenPool.getRemotePools(eth.c.chainSelector).length, 2);
      assertEq(
        arb.tokenPool.getRemotePools(eth.c.chainSelector)[1], // 0th is the 1.4 token pool
        abi.encode(address(eth.tokenPool))
      );
      _assertSetRateLimit(arb.c, address(arb.tokenPool));

      vm.selectFork(base.c.forkId);
      assertEq(address(base.proposal.GHO_TOKEN()), address(base.c.token));
      assertEq(base.c.tokenAdminRegistry.getPool(address(base.c.token)), address(base.tokenPool));
      assertEq(base.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(base.tokenPool.getSupportedChains()[1], arb.c.chainSelector);
      assertEq(
        base.tokenPool.getRemoteToken(arb.c.chainSelector),
        abi.encode(address(arb.c.token))
      );
      assertEq(
        base.tokenPool.getRemoteToken(eth.c.chainSelector),
        abi.encode(address(eth.c.token))
      );
      assertEq(base.tokenPool.getRemotePools(arb.c.chainSelector).length, 1);
      assertEq(
        base.tokenPool.getRemotePools(arb.c.chainSelector)[0],
        abi.encode(address(arb.tokenPool))
      );
      assertEq(base.tokenPool.getRemotePools(eth.c.chainSelector).length, 1);
      assertEq(
        base.tokenPool.getRemotePools(eth.c.chainSelector)[0],
        abi.encode(address(eth.tokenPool))
      );
      _assertSetRateLimit(base.c, address(base.tokenPool));

      vm.selectFork(eth.c.forkId);
      assertEq(eth.c.tokenAdminRegistry.getPool(address(eth.c.token)), address(eth.tokenPool));
      assertEq(eth.tokenPool.getSupportedChains()[0], arb.c.chainSelector);
      assertEq(eth.tokenPool.getSupportedChains()[1], base.c.chainSelector);
      assertEq(eth.tokenPool.getRemoteToken(arb.c.chainSelector), abi.encode(address(arb.c.token)));
      assertEq(
        eth.tokenPool.getRemoteToken(base.c.chainSelector),
        abi.encode(address(base.c.token))
      );
      assertEq(eth.tokenPool.getRemotePools(arb.c.chainSelector).length, 2);
      assertEq(
        eth.tokenPool.getRemotePools(arb.c.chainSelector)[1], // 0th is the 1.4 token pool
        abi.encode(address(arb.tokenPool))
      );
      assertEq(eth.tokenPool.getRemotePools(base.c.chainSelector).length, 1);
      assertEq(
        eth.tokenPool.getRemotePools(base.c.chainSelector)[0],
        abi.encode(address(base.tokenPool))
      );
      _assertSetRateLimit(eth.c, address(eth.tokenPool));
    }
  }

  function _assertOnRamp(
    IEVM2EVMOnRamp onRamp,
    uint64 srcSelector,
    uint64 dstSelector,
    IRouter router
  ) internal view {
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
  ) internal view {
    assertEq(offRamp.typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');
    assertEq(offRamp.getStaticConfig().sourceChainSelector, srcSelector);
    assertEq(offRamp.getStaticConfig().chainSelector, dstSelector);
    assertEq(offRamp.getDynamicConfig().router, address(router));
    assertTrue(router.isOffRamp(srcSelector, address(offRamp)));
  }

  function _assertSetRateLimit(Common memory src, address tokenPool) internal view {
    (Common memory dst1, Common memory dst2) = _getDestination(src);
    IUpgradeableLockReleaseTokenPool_1_5_1 _tokenPool = IUpgradeableLockReleaseTokenPool_1_5_1(
      tokenPool
    );
    assertEq(
      _tokenPool.getCurrentInboundRateLimiterState(dst1.chainSelector),
      _getRateLimiterConfig()
    );
    assertEq(
      _tokenPool.getCurrentOutboundRateLimiterState(dst1.chainSelector),
      _getRateLimiterConfig()
    );

    assertEq(
      _tokenPool.getCurrentInboundRateLimiterState(dst2.chainSelector),
      _getRateLimiterConfig()
    );
    assertEq(
      _tokenPool.getCurrentOutboundRateLimiterState(dst2.chainSelector),
      _getRateLimiterConfig()
    );
  }

  function _getDestination(Common memory src) internal view returns (Common memory, Common memory) {
    if (src.forkId == arb.c.forkId) return (base.c, eth.c);
    else if (src.forkId == base.c.forkId) return (arb.c, eth.c);
    else return (arb.c, base.c);
  }

  function _tokenBucketToConfig(
    IRateLimiter.TokenBucket memory bucket
  ) internal pure returns (IRateLimiter.Config memory) {
    return
      IRateLimiter.Config({
        isEnabled: bucket.isEnabled,
        capacity: bucket.capacity,
        rate: bucket.rate
      });
  }

  function _getDisabledConfig() internal pure returns (IRateLimiter.Config memory) {
    return IRateLimiter.Config({isEnabled: false, capacity: 0, rate: 0});
  }

  function _getImplementation(address proxy) internal view returns (address) {
    bytes32 slot = bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1);
    return address(uint160(uint256(vm.load(proxy, slot))));
  }

  function _readInitialized(address proxy) internal view returns (uint8) {
    return uint8(uint256(vm.load(proxy, bytes32(0))));
  }

  function _getRateLimiterConfig() internal pure returns (IRateLimiter.Config memory) {
    return
      IRateLimiter.Config({
        isEnabled: true,
        capacity: uint128(CCIP_RATE_LIMIT_CAPACITY),
        rate: uint128(CCIP_RATE_LIMIT_REFILL_RATE)
      });
  }

  function _getOutboundRefillTime(uint256 amount) internal pure returns (uint256) {
    return (amount / CCIP_RATE_LIMIT_REFILL_RATE) + 1; // account for rounding
  }

  function _getInboundRefillTime(uint256 amount) internal pure returns (uint256) {
    return (amount / CCIP_RATE_LIMIT_REFILL_RATE) + 1; // account for rounding
  }

  function _min(uint256 a, uint256 b) internal pure returns (uint256) {
    return a < b ? a : b;
  }

  function assertEq(
    IRateLimiter.TokenBucket memory bucket,
    IRateLimiter.Config memory config
  ) internal pure {
    assertEq(abi.encode(_tokenBucketToConfig(bucket)), abi.encode(config));
  }

  // @dev refresh token prices to the last stored such that price is not stale
  // @dev assumed src.forkId is already active
  function _refreshGasAndTokenPrices(Common memory src, Common memory dst) internal {
    uint64 destChainSelector = dst.chainSelector;
    IEVM2EVMOnRamp srcOnRamp = IEVM2EVMOnRamp(src.router.getOnRamp(destChainSelector));
    address bridgeToken = address(src.token);
    address feeToken = src.router.getWrappedNative(); // needed as we do tests with wrapped native as fee token
    address linkToken = srcOnRamp.getStaticConfig().linkToken; // needed as feeTokenAmount is converted to linkTokenAmount
    IInternal.TokenPriceUpdate[] memory tokenPriceUpdates = new IInternal.TokenPriceUpdate[](3);
    IInternal.GasPriceUpdate[] memory gasPriceUpdates = new IInternal.GasPriceUpdate[](1);
    IPriceRegistry priceRegistry = IPriceRegistry(srcOnRamp.getDynamicConfig().priceRegistry); // both ramps have the same price registry

    tokenPriceUpdates[0] = IInternal.TokenPriceUpdate({
      sourceToken: bridgeToken,
      usdPerToken: priceRegistry.getTokenPrice(bridgeToken).value
    });
    tokenPriceUpdates[1] = IInternal.TokenPriceUpdate({
      sourceToken: feeToken,
      usdPerToken: priceRegistry.getTokenPrice(feeToken).value
    });
    tokenPriceUpdates[2] = IInternal.TokenPriceUpdate({
      sourceToken: linkToken,
      usdPerToken: priceRegistry.getTokenPrice(linkToken).value
    });

    gasPriceUpdates[0] = IInternal.GasPriceUpdate({
      destChainSelector: destChainSelector,
      usdPerUnitGas: priceRegistry.getDestinationChainGasPrice(destChainSelector).value
    });

    vm.prank(priceRegistry.owner());
    priceRegistry.updatePrices(
      IInternal.PriceUpdates({
        tokenPriceUpdates: tokenPriceUpdates,
        gasPriceUpdates: gasPriceUpdates
      })
    );
  }
}

contract AaveV3Base_GHOGnosisLaunch_20250421_PostExecution is
  AaveV3Base_GHOGnosisLaunch_20250421_Base
{
  function setUp() public override {
    super.setUp();

    vm.selectFork(arb.c.forkId);
    executePayload(vm, address(arb.proposal));

    vm.selectFork(eth.c.forkId);
    executePayload(vm, address(eth.proposal));

    vm.selectFork(base.c.forkId);
    executePayload(vm, address(base.proposal));

    _validateConfig({executed: true});
  }

  function test_E2E_Eth_Base(uint256 amount) public {
    {
      vm.selectFork(eth.c.forkId);
      uint256 bridgeableAmount = _min(
        eth.tokenPool.getBridgeLimit() - eth.tokenPool.getCurrentBridgedAmount(),
        CCIP_RATE_LIMIT_CAPACITY
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(eth.c, base.c);

      vm.prank(alice);
      eth.c.token.approve(address(eth.c.router), amount);
      deal(address(eth.c.token), alice, amount);

      uint256 tokenPoolBalance = eth.c.token.balanceOf(address(eth.tokenPool));
      uint256 aliceBalance = eth.c.token.balanceOf(alice);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: eth.c, dst: base.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(eth.tokenPool));
      emit Locked(address(eth.c.baseOnRamp), amount);
      vm.expectEmit(address(eth.c.baseOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      eth.c.router.ccipSend{value: eventArg.feeTokenAmount}(base.c.chainSelector, message);

      assertEq(eth.c.token.balanceOf(address(eth.tokenPool)), tokenPoolBalance + amount);
      assertEq(eth.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

      // base execute message
      vm.selectFork(base.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(base.c, eth.c);
      assertEq(base.c.token.balanceOf(alice), 0);
      assertEq(base.c.token.totalSupply(), 0); // first bridge
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(base.tokenPool));
      emit Minted(address(base.c.ethOffRamp), alice, amount);

      vm.prank(address(base.c.ethOffRamp));
      base.c.ethOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(base.c.token.balanceOf(alice), amount);
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, amount);
    }

    // send amount back to eth
    {
      // send base from base
      vm.selectFork(base.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(base.c, eth.c);
      vm.prank(alice);
      base.c.token.approve(address(base.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: base.c, dst: eth.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(base.tokenPool));
      emit Burned(address(base.c.ethOnRamp), amount);
      vm.expectEmit(address(base.c.ethOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      base.c.router.ccipSend{value: eventArg.feeTokenAmount}(eth.c.chainSelector, message);

      assertEq(base.c.token.balanceOf(alice), 0);
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, 0);

      // eth execute message
      vm.selectFork(eth.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(eth.c, base.c);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      vm.expectEmit(address(eth.tokenPool));
      emit Released(address(eth.c.baseOffRamp), alice, amount);
      vm.prank(address(eth.c.baseOffRamp));
      eth.c.baseOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(eth.c.token.balanceOf(alice), amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount - amount);
    }
  }

  function test_E2E_Arb_Base(uint256 amount) public {
    {
      vm.selectFork(arb.c.forkId);
      uint256 bridgeableAmount = _min(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        CCIP_RATE_LIMIT_CAPACITY
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(arb.c, base.c);

      vm.prank(alice);
      arb.c.token.approve(address(arb.c.router), amount);
      deal(address(arb.c.token), alice, amount);

      uint256 aliceBalance = arb.c.token.balanceOf(alice);
      uint256 facilitatorLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: arb.c, dst: base.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(arb.tokenPool));
      emit Burned(address(arb.c.baseOnRamp), amount);
      vm.expectEmit(address(arb.c.baseOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      arb.c.router.ccipSend{value: eventArg.feeTokenAmount}(base.c.chainSelector, message);

      assertEq(arb.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        facilitatorLevel - amount
      );

      // base execute message
      vm.selectFork(base.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(base.c, arb.c);
      assertEq(base.c.token.balanceOf(alice), 0);
      assertEq(base.c.token.totalSupply(), 0); // first bridge
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(base.tokenPool));
      emit Minted(address(base.c.arbOffRamp), alice, amount);

      vm.prank(address(base.c.arbOffRamp));
      base.c.arbOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(base.c.token.balanceOf(alice), amount);
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, amount);
    }

    // send amount back to arb
    {
      // send base from base
      vm.selectFork(base.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(base.c, arb.c);
      vm.prank(alice);
      base.c.token.approve(address(base.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: base.c, dst: arb.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(base.tokenPool));
      emit Burned(address(base.c.arbOnRamp), amount);
      vm.expectEmit(address(base.c.arbOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      base.c.router.ccipSend{value: eventArg.feeTokenAmount}(arb.c.chainSelector, message);

      assertEq(base.c.token.balanceOf(alice), 0);
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, 0);

      // arb execute message
      vm.selectFork(arb.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(arb.c, base.c);
      uint256 facilitatorLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      vm.expectEmit(address(arb.tokenPool));
      emit Minted(address(arb.c.baseOffRamp), alice, amount);
      vm.prank(address(arb.c.baseOffRamp));
      arb.c.baseOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(arb.c.token.balanceOf(alice), amount);
      assertEq(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        facilitatorLevel + amount
      );
    }
  }

  function test_E2E_Eth_Arb(uint256 amount) public {
    {
      vm.selectFork(eth.c.forkId);
      uint256 bridgeableAmount = _min(
        eth.tokenPool.getBridgeLimit() - eth.tokenPool.getCurrentBridgedAmount(),
        CCIP_RATE_LIMIT_CAPACITY
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(eth.c, arb.c);

      vm.prank(alice);
      eth.c.token.approve(address(eth.c.router), amount);
      deal(address(eth.c.token), alice, amount);

      uint256 tokenPoolBalance = eth.c.token.balanceOf(address(eth.tokenPool));
      uint256 aliceBalance = eth.c.token.balanceOf(alice);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: eth.c, dst: arb.c, sender: alice, amount: amount}));

      vm.expectEmit(address(eth.tokenPool));
      emit Locked(address(eth.c.arbOnRamp), amount);
      vm.expectEmit(address(eth.c.arbOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      eth.c.router.ccipSend{value: eventArg.feeTokenAmount}(arb.c.chainSelector, message);

      assertEq(eth.c.token.balanceOf(address(eth.tokenPool)), tokenPoolBalance + amount);
      assertEq(eth.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

      // arb execute message
      vm.selectFork(arb.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(arb.c, eth.c);
      aliceBalance = arb.c.token.balanceOf(alice);
      uint256 bucketLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      vm.expectEmit(address(arb.tokenPool));
      emit Minted(address(arb.c.ethOffRamp), alice, amount);

      vm.prank(address(arb.c.ethOffRamp));
      arb.c.ethOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(arb.c.token.balanceOf(alice), aliceBalance + amount);
      assertEq(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        bucketLevel + amount
      );
    }

    // send amount back to eth
    {
      // send back from arb
      vm.selectFork(arb.c.forkId);
      vm.prank(alice);
      arb.c.token.approve(address(arb.c.router), amount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(arb.c, eth.c);

      uint256 aliceBalance = arb.c.token.balanceOf(alice);
      uint256 bucketLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: arb.c, dst: eth.c, sender: alice, amount: amount}));

      vm.expectEmit(address(arb.tokenPool));
      emit Burned(address(arb.c.ethOnRamp), amount);
      vm.expectEmit(address(arb.c.ethOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      arb.c.router.ccipSend{value: eventArg.feeTokenAmount}(eth.c.chainSelector, message);

      assertEq(arb.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        bucketLevel - amount
      );

      // eth execute message
      vm.selectFork(eth.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(eth.c, arb.c);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      vm.expectEmit(address(eth.tokenPool));
      emit Released(address(eth.c.arbOffRamp), alice, amount);
      vm.prank(address(eth.c.arbOffRamp));
      eth.c.arbOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(eth.c.token.balanceOf(alice), amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount - amount);
    }
  }
}
