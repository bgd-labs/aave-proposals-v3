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
import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOAvalancheLaunch} from './utils/GHOAvalancheLaunch.sol';
import {AaveV3Arbitrum_GHOAvalancheLaunch_20250519} from './AaveV3Arbitrum_GHOAvalancheLaunch_20250519.sol';
import {AaveV3Base_GHOAvalancheLaunch_20250519} from './AaveV3Base_GHOAvalancheLaunch_20250519.sol';
import {AaveV3Ethereum_GHOAvalancheLaunch_20250519} from './AaveV3Ethereum_GHOAvalancheLaunch_20250519.sol';
import {AaveV3Avalanche_GHOAvalancheLaunch_20250519} from './AaveV3Avalanche_GHOAvalancheLaunch_20250519.sol';

/**
 * @dev Test for AaveV3E2E_GHOAvalancheLaunch_20250519
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250519_Multi_GHOAvalancheLaunch/AaveV3E2E_GHOAvalancheLaunch_20250519.t.sol -vv
 */
contract AaveV3Base_GHOAvalancheLaunch_20250519_Base is ProtocolV3TestBase {
  struct Common {
    IRouter router;
    IGhoToken token;
    IEVM2EVMOnRamp arbOnRamp;
    IEVM2EVMOnRamp avaOnRamp;
    IEVM2EVMOnRamp ethOnRamp;
    IEVM2EVMOnRamp baseOnRamp;
    IEVM2EVMOffRamp_1_5 arbOffRamp;
    IEVM2EVMOffRamp_1_5 avaOffRamp;
    IEVM2EVMOffRamp_1_5 ethOffRamp;
    IEVM2EVMOffRamp_1_5 baseOffRamp;
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

  struct ARBITRUM {
    AaveV3Arbitrum_GHOAvalancheLaunch_20250519 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }
  struct BASE {
    AaveV3Base_GHOAvalancheLaunch_20250519 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }
  struct ETHEREUM {
    AaveV3Ethereum_GHOAvalancheLaunch_20250519 proposal;
    IUpgradeableLockReleaseTokenPool_1_5_1 tokenPool;
    Common c;
  }
  struct AVALANCHE {
    AaveV3Avalanche_GHOAvalancheLaunch_20250519 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }

  address internal constant RISK_COUNCIL = GHOAvalancheLaunch.RISK_COUNCIL; // common across all chains
  address internal constant RMN_PROXY_AVAX = GHOAvalancheLaunch.AVAX_RMN_PROXY;
  address internal constant ROUTER_AVAX = GHOAvalancheLaunch.AVAX_CCIP_ROUTER;
  address internal constant GHO_TOKEN_IMPL_AVAX = GHOAvalancheLaunch.GHO_TOKEN_IMPL;
  IGhoToken internal constant GHO_TOKEN_AVAX = IGhoToken(GHOAvalancheLaunch.GHO_TOKEN);
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOAvalancheLaunch.CCIP_RATE_LIMIT_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOAvalancheLaunch.CCIP_RATE_LIMIT_REFILL_RATE;

  ARBITRUM internal arb;
  BASE internal base;
  ETHEREUM internal eth;
  AVALANCHE internal ava;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  IGhoAaveSteward internal GHO_AAVE_STEWARD_AVAX;
  IGhoBucketSteward internal GHO_BUCKET_STEWARD_AVAX;
  IGhoCcipSteward internal GHO_CCIP_STEWARD_AVAX;

  event CCIPSendRequested(IInternal.EVM2EVMMessage message);
  event Locked(address indexed sender, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);

  function setUp() public virtual {
    arb.c.forkId = vm.createFork(vm.rpcUrl('arbitrum'), GHOAvalancheLaunch.ARB_BLOCK_NUMBER);
    base.c.forkId = vm.createFork(vm.rpcUrl('base'), GHOAvalancheLaunch.BASE_BLOCK_NUMBER);
    eth.c.forkId = vm.createFork(vm.rpcUrl('mainnet'), GHOAvalancheLaunch.ETH_BLOCK_NUMBER);
    ava.c.forkId = vm.createFork(vm.rpcUrl('avalanche'), GHOAvalancheLaunch.AVAX_BLOCK_NUMBER);

    arb.c.chainSelector = GHOAvalancheLaunch.ARB_CHAIN_SELECTOR;
    base.c.chainSelector = GHOAvalancheLaunch.BASE_CHAIN_SELECTOR;
    eth.c.chainSelector = GHOAvalancheLaunch.ETH_CHAIN_SELECTOR;
    ava.c.chainSelector = GHOAvalancheLaunch.AVAX_CHAIN_SELECTOR;

    vm.selectFork(arb.c.forkId);
    arb.proposal = new AaveV3Arbitrum_GHOAvalancheLaunch_20250519();
    arb.c.token = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);
    arb.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(GHOAvalancheLaunch.ARB_GHO_CCIP_TOKEN_POOL);
    arb.c.tokenAdminRegistry = ITokenAdminRegistry(GHOAvalancheLaunch.ARB_TOKEN_ADMIN_REGISTRY);
    arb.c.router = IRouter(arb.tokenPool.getRouter());
    arb.c.avaOnRamp = IEVM2EVMOnRamp(arb.c.router.getOnRamp(ava.c.chainSelector));
    arb.c.ethOnRamp = IEVM2EVMOnRamp(arb.c.router.getOnRamp(eth.c.chainSelector));
    arb.c.baseOnRamp = IEVM2EVMOnRamp(arb.c.router.getOnRamp(base.c.chainSelector));
    arb.c.avaOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.ARB_AVAX_OFF_RAMP);
    arb.c.ethOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.ARB_ETH_OFF_RAMP);
    arb.c.baseOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.ARB_BASE_OFF_RAMP);

    vm.selectFork(base.c.forkId);
    base.proposal = new AaveV3Base_GHOAvalancheLaunch_20250519();
    base.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(
      GHOAvalancheLaunch.BASE_GHO_CCIP_TOKEN_POOL
    );
    base.c.tokenAdminRegistry = ITokenAdminRegistry(GHOAvalancheLaunch.BASE_TOKEN_ADMIN_REGISTRY);
    base.c.token = IGhoToken(AaveV3BaseAssets.GHO_UNDERLYING);
    base.c.router = IRouter(base.tokenPool.getRouter());
    base.c.arbOnRamp = IEVM2EVMOnRamp(base.c.router.getOnRamp(arb.c.chainSelector));
    base.c.ethOnRamp = IEVM2EVMOnRamp(base.c.router.getOnRamp(eth.c.chainSelector));
    base.c.avaOnRamp = IEVM2EVMOnRamp(base.c.router.getOnRamp(ava.c.chainSelector));
    base.c.arbOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.BASE_ARB_OFF_RAMP);
    base.c.ethOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.BASE_ETH_OFF_RAMP);
    base.c.avaOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.BASE_AVAX_OFF_RAMP);

    vm.selectFork(eth.c.forkId);
    eth.proposal = new AaveV3Ethereum_GHOAvalancheLaunch_20250519();
    eth.c.token = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING);
    eth.tokenPool = IUpgradeableLockReleaseTokenPool_1_5_1(
      GHOAvalancheLaunch.ETH_GHO_CCIP_TOKEN_POOL
    );
    eth.c.tokenAdminRegistry = ITokenAdminRegistry(GHOAvalancheLaunch.ETH_TOKEN_ADMIN_REGISTRY);
    eth.c.router = IRouter(eth.tokenPool.getRouter());
    eth.c.arbOnRamp = IEVM2EVMOnRamp(eth.c.router.getOnRamp(arb.c.chainSelector));
    eth.c.avaOnRamp = IEVM2EVMOnRamp(eth.c.router.getOnRamp(ava.c.chainSelector));
    eth.c.baseOnRamp = IEVM2EVMOnRamp(eth.c.router.getOnRamp(base.c.chainSelector));
    eth.c.arbOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.ETH_ARB_OFF_RAMP);
    eth.c.avaOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.ETH_AVAX_OFF_RAMP);
    eth.c.baseOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.ETH_BASE_OFF_RAMP);

    vm.selectFork(ava.c.forkId);
    ava.proposal = new AaveV3Avalanche_GHOAvalancheLaunch_20250519();
    ava.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(GHOAvalancheLaunch.GHO_CCIP_TOKEN_POOL);
    ava.c.tokenAdminRegistry = ITokenAdminRegistry(GHOAvalancheLaunch.AVAX_TOKEN_ADMIN_REGISTRY);
    ava.c.token = GHO_TOKEN_AVAX;
    ava.c.router = IRouter(ava.tokenPool.getRouter());
    ava.c.arbOnRamp = IEVM2EVMOnRamp(ava.c.router.getOnRamp(arb.c.chainSelector));
    ava.c.baseOnRamp = IEVM2EVMOnRamp(ava.c.router.getOnRamp(base.c.chainSelector));
    ava.c.ethOnRamp = IEVM2EVMOnRamp(ava.c.router.getOnRamp(eth.c.chainSelector));
    ava.c.arbOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.AVAX_ARB_OFF_RAMP);
    ava.c.baseOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.AVAX_BASE_OFF_RAMP);
    ava.c.ethOffRamp = IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.AVAX_ETH_OFF_RAMP);

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
    _assertOnRamp(arb.c.avaOnRamp, arb.c.chainSelector, ava.c.chainSelector, arb.c.router);
    _assertOnRamp(arb.c.ethOnRamp, arb.c.chainSelector, eth.c.chainSelector, arb.c.router);
    _assertOnRamp(arb.c.baseOnRamp, arb.c.chainSelector, base.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.avaOffRamp, ava.c.chainSelector, arb.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.ethOffRamp, eth.c.chainSelector, arb.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.baseOffRamp, base.c.chainSelector, arb.c.chainSelector, arb.c.router);

    // proposal constants
    assertEq(arb.proposal.AVAX_CHAIN_SELECTOR(), ava.c.chainSelector);
    assertEq(address(arb.proposal.TOKEN_POOL()), address(arb.tokenPool));
    assertEq(arb.proposal.REMOTE_TOKEN_POOL_AVAX(), address(ava.tokenPool));
    assertEq(arb.proposal.REMOTE_GHO_TOKEN_AVAX(), address(ava.c.token));

    vm.selectFork(base.c.forkId);
    assertEq(base.c.chainSelector, 15971525489660198786);
    assertEq(address(base.c.token), AaveV3BaseAssets.GHO_UNDERLYING);
    assertEq(base.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(base.c.avaOnRamp, base.c.chainSelector, ava.c.chainSelector, base.c.router);
    _assertOnRamp(base.c.ethOnRamp, base.c.chainSelector, eth.c.chainSelector, base.c.router);
    _assertOnRamp(base.c.arbOnRamp, base.c.chainSelector, arb.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.avaOffRamp, ava.c.chainSelector, base.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.ethOffRamp, eth.c.chainSelector, base.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.arbOffRamp, arb.c.chainSelector, base.c.chainSelector, base.c.router);

    // proposal constants
    assertEq(base.proposal.AVAX_CHAIN_SELECTOR(), ava.c.chainSelector);
    assertEq(address(base.proposal.TOKEN_POOL()), address(base.tokenPool));
    assertEq(base.proposal.REMOTE_TOKEN_POOL_AVAX(), address(ava.tokenPool));
    assertEq(base.proposal.REMOTE_GHO_TOKEN_AVAX(), address(ava.c.token));

    vm.selectFork(ava.c.forkId);
    assertEq(ava.c.chainSelector, 6433500567565415381);
    assertEq(ava.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(ava.c.arbOnRamp, ava.c.chainSelector, arb.c.chainSelector, ava.c.router);
    _assertOnRamp(ava.c.ethOnRamp, ava.c.chainSelector, eth.c.chainSelector, ava.c.router);
    _assertOnRamp(ava.c.baseOnRamp, ava.c.chainSelector, base.c.chainSelector, ava.c.router);
    _assertOffRamp(ava.c.arbOffRamp, arb.c.chainSelector, ava.c.chainSelector, ava.c.router);
    _assertOffRamp(ava.c.ethOffRamp, eth.c.chainSelector, ava.c.chainSelector, ava.c.router);
    _assertOffRamp(ava.c.baseOffRamp, base.c.chainSelector, ava.c.chainSelector, ava.c.router);

    // proposal constants
    assertEq(ava.proposal.ETH_CHAIN_SELECTOR(), eth.c.chainSelector);
    assertEq(ava.proposal.ARB_CHAIN_SELECTOR(), arb.c.chainSelector);
    assertEq(ava.proposal.CCIP_BUCKET_CAPACITY(), GHOAvalancheLaunch.CCIP_BUCKET_CAPACITY);
    assertEq(address(ava.proposal.TOKEN_ADMIN_REGISTRY()), address(ava.c.tokenAdminRegistry));
    assertEq(address(ava.proposal.TOKEN_POOL()), address(ava.tokenPool));
    IGhoCcipSteward ghoCcipSteward = IGhoCcipSteward(ava.proposal.GHO_CCIP_STEWARD());
    assertEq(ghoCcipSteward.GHO_TOKEN_POOL(), address(ava.tokenPool));
    assertEq(ghoCcipSteward.GHO_TOKEN(), address(ava.c.token));
    assertEq(ava.proposal.REMOTE_TOKEN_POOL_ETH(), address(eth.tokenPool));
    assertEq(ava.proposal.REMOTE_TOKEN_POOL_ARB(), address(arb.tokenPool));

    vm.selectFork(eth.c.forkId);
    assertEq(eth.c.chainSelector, 5009297550715157269);
    assertEq(address(eth.c.token), AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(eth.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(eth.c.arbOnRamp, eth.c.chainSelector, arb.c.chainSelector, eth.c.router);
    _assertOnRamp(eth.c.avaOnRamp, eth.c.chainSelector, ava.c.chainSelector, eth.c.router);
    _assertOnRamp(eth.c.baseOnRamp, eth.c.chainSelector, base.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.arbOffRamp, arb.c.chainSelector, eth.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.avaOffRamp, ava.c.chainSelector, eth.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.baseOffRamp, base.c.chainSelector, eth.c.chainSelector, eth.c.router);

    // proposal constants
    assertEq(eth.proposal.AVAX_CHAIN_SELECTOR(), ava.c.chainSelector);
    assertEq(address(eth.proposal.TOKEN_POOL()), address(eth.tokenPool));
    assertEq(eth.proposal.REMOTE_TOKEN_POOL_AVAX(), address(ava.tokenPool));
    assertEq(eth.proposal.REMOTE_GHO_TOKEN_AVAX(), address(ava.c.token));

    if (executed) {
      vm.selectFork(arb.c.forkId);
      assertEq(arb.c.tokenAdminRegistry.getPool(address(arb.c.token)), address(arb.tokenPool));
      assertEq(arb.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(arb.tokenPool.getSupportedChains()[1], base.c.chainSelector);
      assertEq(arb.tokenPool.getSupportedChains()[2], ava.c.chainSelector);
      assertEq(arb.tokenPool.getRemoteToken(eth.c.chainSelector), abi.encode(address(eth.c.token)));
      assertEq(arb.tokenPool.getRemoteToken(ava.c.chainSelector), abi.encode(address(ava.c.token)));
      assertEq(
        arb.tokenPool.getRemoteToken(base.c.chainSelector),
        abi.encode(address(base.c.token))
      );
      assertEq(arb.tokenPool.getRemotePools(ava.c.chainSelector).length, 1);
      assertEq(
        arb.tokenPool.getRemotePools(ava.c.chainSelector)[0],
        abi.encode(address(ava.tokenPool))
      );
      assertEq(arb.tokenPool.getRemotePools(eth.c.chainSelector).length, 2);
      assertEq(
        arb.tokenPool.getRemotePools(eth.c.chainSelector)[1], // 0th is the 1.4 token pool
        abi.encode(address(eth.tokenPool))
      );
      assertEq(arb.tokenPool.getRemotePools(base.c.chainSelector).length, 1);
      assertEq(
        arb.tokenPool.getRemotePools(base.c.chainSelector)[0],
        abi.encode(address(base.tokenPool))
      );

      vm.selectFork(base.c.forkId);
      assertEq(base.c.tokenAdminRegistry.getPool(address(base.c.token)), address(base.tokenPool));
      assertEq(base.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(base.tokenPool.getSupportedChains()[1], arb.c.chainSelector);
      assertEq(base.tokenPool.getSupportedChains()[2], ava.c.chainSelector);
      assertEq(
        base.tokenPool.getRemoteToken(eth.c.chainSelector),
        abi.encode(address(eth.c.token))
      );
      assertEq(
        base.tokenPool.getRemoteToken(ava.c.chainSelector),
        abi.encode(address(ava.c.token))
      );
      assertEq(
        base.tokenPool.getRemoteToken(arb.c.chainSelector),
        abi.encode(address(arb.c.token))
      );
      assertEq(base.tokenPool.getRemotePools(ava.c.chainSelector).length, 1);
      assertEq(
        base.tokenPool.getRemotePools(ava.c.chainSelector)[0],
        abi.encode(address(ava.tokenPool))
      );
      assertEq(base.tokenPool.getRemotePools(eth.c.chainSelector).length, 1);
      assertEq(
        base.tokenPool.getRemotePools(eth.c.chainSelector)[0],
        abi.encode(address(eth.tokenPool))
      );
      assertEq(base.tokenPool.getRemotePools(arb.c.chainSelector).length, 1);
      assertEq(
        base.tokenPool.getRemotePools(arb.c.chainSelector)[0],
        abi.encode(address(arb.tokenPool))
      );

      vm.selectFork(ava.c.forkId);
      assertEq(address(ava.proposal.GHO_TOKEN()), address(ava.c.token));
      assertEq(ava.c.tokenAdminRegistry.getPool(address(ava.c.token)), address(ava.tokenPool));
      assertEq(ava.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(ava.tokenPool.getSupportedChains()[1], arb.c.chainSelector);
      assertEq(ava.tokenPool.getSupportedChains()[2], base.c.chainSelector);
      assertEq(ava.tokenPool.getRemoteToken(arb.c.chainSelector), abi.encode(address(arb.c.token)));
      assertEq(ava.tokenPool.getRemoteToken(eth.c.chainSelector), abi.encode(address(eth.c.token)));
      assertEq(
        ava.tokenPool.getRemoteToken(base.c.chainSelector),
        abi.encode(address(base.c.token))
      );
      assertEq(ava.tokenPool.getRemotePools(arb.c.chainSelector).length, 1);
      assertEq(
        ava.tokenPool.getRemotePools(arb.c.chainSelector)[0],
        abi.encode(address(arb.tokenPool))
      );
      assertEq(ava.tokenPool.getRemotePools(eth.c.chainSelector).length, 1);
      assertEq(
        ava.tokenPool.getRemotePools(eth.c.chainSelector)[0],
        abi.encode(address(eth.tokenPool))
      );
      assertEq(ava.tokenPool.getRemotePools(base.c.chainSelector).length, 1);
      assertEq(
        ava.tokenPool.getRemotePools(base.c.chainSelector)[0],
        abi.encode(address(base.tokenPool))
      );
      _assertSetRateLimit(ava.c, address(ava.tokenPool));

      vm.selectFork(eth.c.forkId);
      assertEq(eth.c.tokenAdminRegistry.getPool(address(eth.c.token)), address(eth.tokenPool));
      assertEq(eth.tokenPool.getSupportedChains()[0], arb.c.chainSelector);
      assertEq(eth.tokenPool.getSupportedChains()[1], base.c.chainSelector);
      assertEq(eth.tokenPool.getSupportedChains()[2], ava.c.chainSelector);
      assertEq(eth.tokenPool.getRemoteToken(arb.c.chainSelector), abi.encode(address(arb.c.token)));
      assertEq(eth.tokenPool.getRemoteToken(ava.c.chainSelector), abi.encode(address(ava.c.token)));
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
      assertEq(eth.tokenPool.getRemotePools(ava.c.chainSelector).length, 1);
      assertEq(
        eth.tokenPool.getRemotePools(ava.c.chainSelector)[0],
        abi.encode(address(ava.tokenPool))
      );
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
    if (src.forkId == arb.c.forkId) return (ava.c, eth.c);
    else if (src.forkId == ava.c.forkId) return (arb.c, eth.c);
    else return (arb.c, ava.c);
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

contract AaveV3Base_GHOAvalancheLaunch_20250519_PostExecution is
  AaveV3Base_GHOAvalancheLaunch_20250519_Base
{
  function setUp() public override {
    super.setUp();

    vm.selectFork(arb.c.forkId);
    executePayload(vm, address(arb.proposal));

    vm.selectFork(eth.c.forkId);
    executePayload(vm, address(eth.proposal));

    vm.selectFork(base.c.forkId);
    executePayload(vm, address(base.proposal));

    vm.selectFork(ava.c.forkId);
    executePayload(vm, address(ava.proposal));

    _validateConfig({executed: true});
  }

  function test_E2eEthAvax(uint256 amount) public {
    {
      vm.selectFork(eth.c.forkId);
      uint256 bridgeableAmount = _min(
        eth.tokenPool.getBridgeLimit() - eth.tokenPool.getCurrentBridgedAmount(),
        CCIP_RATE_LIMIT_CAPACITY
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(eth.c, ava.c);

      vm.prank(alice);
      eth.c.token.approve(address(eth.c.router), amount);
      deal(address(eth.c.token), alice, amount);

      uint256 tokenPoolBalance = eth.c.token.balanceOf(address(eth.tokenPool));
      uint256 aliceBalance = eth.c.token.balanceOf(alice);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: eth.c, dst: ava.c, sender: alice, amount: amount}));

      vm.expectEmit(address(eth.tokenPool));
      emit Locked(address(eth.c.avaOnRamp), amount);
      vm.expectEmit(address(eth.c.avaOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      eth.c.router.ccipSend{value: eventArg.feeTokenAmount}(ava.c.chainSelector, message);

      assertEq(eth.c.token.balanceOf(address(eth.tokenPool)), tokenPoolBalance + amount);
      assertEq(eth.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

      // base execute message
      vm.selectFork(ava.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(ava.c, eth.c);
      assertEq(ava.c.token.balanceOf(alice), 0);
      assertEq(ava.c.token.totalSupply(), 0); // first bridge
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(ava.tokenPool));
      emit Minted(address(ava.c.ethOffRamp), alice, amount);

      vm.prank(address(ava.c.ethOffRamp));
      ava.c.ethOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(ava.c.token.balanceOf(alice), amount);
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, amount);
    }

    // send amount back to eth
    {
      // send base from base
      vm.selectFork(ava.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(ava.c, eth.c);
      vm.prank(alice);
      ava.c.token.approve(address(ava.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: ava.c, dst: eth.c, sender: alice, amount: amount}));

      vm.expectEmit(address(ava.tokenPool));
      emit Burned(address(ava.c.ethOnRamp), amount);
      vm.expectEmit(address(ava.c.ethOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      ava.c.router.ccipSend{value: eventArg.feeTokenAmount}(eth.c.chainSelector, message);

      assertEq(ava.c.token.balanceOf(alice), 0);
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, 0);

      // eth execute message
      vm.selectFork(eth.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(eth.c, ava.c);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      vm.expectEmit(address(eth.tokenPool));
      emit Released(address(eth.c.avaOffRamp), alice, amount);
      vm.prank(address(eth.c.avaOffRamp));
      eth.c.avaOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(eth.c.token.balanceOf(alice), amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount - amount);
    }
  }

  function test_E2eArbAvax(uint256 amount) public {
    {
      vm.selectFork(arb.c.forkId);
      IRateLimiter.TokenBucket memory avaRateLimits = arb
        .tokenPool
        .getCurrentInboundRateLimiterState(ava.c.chainSelector);
      uint256 bridgeableAmount = _min(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        avaRateLimits.capacity
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(arb.c, ava.c);

      vm.prank(alice);
      arb.c.token.approve(address(arb.c.router), amount);
      deal(address(arb.c.token), alice, amount);

      uint256 aliceBalance = arb.c.token.balanceOf(alice);
      uint256 facilitatorLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: arb.c, dst: ava.c, sender: alice, amount: amount}));

      vm.expectEmit(address(arb.tokenPool));
      emit Burned(address(arb.c.avaOnRamp), amount);
      vm.expectEmit(address(arb.c.avaOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      arb.c.router.ccipSend{value: eventArg.feeTokenAmount}(ava.c.chainSelector, message);

      assertEq(arb.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        facilitatorLevel - amount
      );

      // avalanche execute message
      vm.selectFork(ava.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(ava.c, arb.c);
      assertEq(ava.c.token.balanceOf(alice), 0);
      assertEq(ava.c.token.totalSupply(), 0); // first bridge
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(ava.tokenPool));
      emit Minted(address(ava.c.arbOffRamp), alice, amount);

      vm.prank(address(ava.c.arbOffRamp));
      ava.c.arbOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(ava.c.token.balanceOf(alice), amount);
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, amount);
    }

    // send amount back to arb
    {
      // send base from avalanche
      vm.selectFork(ava.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(ava.c, arb.c);
      vm.prank(alice);
      ava.c.token.approve(address(ava.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: ava.c, dst: arb.c, sender: alice, amount: amount}));

      vm.expectEmit(address(ava.tokenPool));
      emit Burned(address(ava.c.arbOnRamp), amount);
      vm.expectEmit(address(ava.c.arbOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      ava.c.router.ccipSend{value: eventArg.feeTokenAmount}(arb.c.chainSelector, message);

      assertEq(ava.c.token.balanceOf(alice), 0);
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, 0);

      // arb execute message
      vm.selectFork(arb.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(arb.c, ava.c);
      uint256 facilitatorLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      vm.expectEmit(address(arb.tokenPool));
      emit Minted(address(arb.c.avaOffRamp), alice, amount);
      vm.prank(address(arb.c.avaOffRamp));
      arb.c.avaOffRamp.executeSingleMessage({
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

  function test_E2eBaseAvax(uint256 amount) public {
    {
      vm.selectFork(base.c.forkId);
      IRateLimiter.TokenBucket memory avaRateLimits = base
        .tokenPool
        .getCurrentInboundRateLimiterState(ava.c.chainSelector);
      uint256 bridgeableAmount = _min(
        base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel,
        avaRateLimits.capacity
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(base.c, ava.c);

      vm.prank(alice);
      base.c.token.approve(address(base.c.router), amount);
      deal(address(base.c.token), alice, amount);

      uint256 aliceBalance = base.c.token.balanceOf(alice);
      uint256 facilitatorLevel = base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel;

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: base.c, dst: ava.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(base.tokenPool));
      emit Burned(address(base.c.avaOnRamp), amount);
      vm.expectEmit(address(base.c.avaOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      base.c.router.ccipSend{value: eventArg.feeTokenAmount}(ava.c.chainSelector, message);

      assertEq(base.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(
        base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel,
        facilitatorLevel - amount
      );

      // avalanche execute message
      vm.selectFork(ava.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(ava.c, base.c);
      assertEq(ava.c.token.balanceOf(alice), 0);
      assertEq(ava.c.token.totalSupply(), 0); // first bridge
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(ava.tokenPool));
      emit Minted(address(ava.c.baseOffRamp), alice, amount);

      vm.prank(address(ava.c.baseOffRamp));
      ava.c.baseOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(ava.c.token.balanceOf(alice), amount);
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, amount);
    }

    // send amount back to avalanche
    {
      vm.selectFork(ava.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(ava.c, base.c);
      vm.prank(alice);
      ava.c.token.approve(address(ava.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: ava.c, dst: base.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(ava.tokenPool));
      emit Burned(address(ava.c.baseOnRamp), amount);
      vm.expectEmit(address(ava.c.baseOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      ava.c.router.ccipSend{value: eventArg.feeTokenAmount}(base.c.chainSelector, message);

      assertEq(ava.c.token.balanceOf(alice), 0);
      assertEq(ava.c.token.getFacilitator(address(ava.tokenPool)).bucketLevel, 0);

      // base execute message
      vm.selectFork(base.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(base.c, ava.c);
      uint256 facilitatorLevel = base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel;

      vm.expectEmit(address(base.tokenPool));
      emit Minted(address(base.c.avaOffRamp), alice, amount);
      vm.prank(address(base.c.avaOffRamp));
      base.c.avaOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(base.c.token.balanceOf(alice), amount);
      assertEq(
        base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel,
        facilitatorLevel + amount
      );
    }
  }

  function test_E2eEthArb(uint256 amount) public {
    {
      vm.selectFork(eth.c.forkId);
      IRateLimiter.TokenBucket memory rateLimits = eth.tokenPool.getCurrentInboundRateLimiterState(
        arb.c.chainSelector
      );
      uint256 bridgeableAmount = _min(
        eth.tokenPool.getBridgeLimit() - eth.tokenPool.getCurrentBridgedAmount(),
        rateLimits.capacity
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
