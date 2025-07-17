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
import {AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GhoAvalanche} from 'aave-address-book/GhoAvalanche.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOLaunchConstants} from './utils/GHOLaunchConstants.sol';
import {AaveV3Arbitrum_GHOGnosisLaunch_20250421} from './AaveV3Arbitrum_GHOGnosisLaunch_20250421.sol';
import {AaveV3Base_GHOGnosisLaunch_20250421} from './AaveV3Base_GHOGnosisLaunch_20250421.sol';
import {AaveV3Ethereum_GHOGnosisLaunch_20250421} from './AaveV3Ethereum_GHOGnosisLaunch_20250421.sol';
import {AaveV3Gnosis_GHOGnosisLaunch_20250421} from './AaveV3Gnosis_GHOGnosisLaunch_20250421.sol';
import {AaveV3Avalanche_GHOGnosisLaunch_20250421} from './AaveV3Avalanche_GHOGnosisLaunch_20250421.sol';

/**
 * @dev Test for AaveV3Base_GHOGnosisLaunch_20250421
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250421_Multi_GHOGnosisLaunch/AaveV3E2E_GHOGnosisLaunch_20250421.t.sol -vv
 */
contract AaveV3Base_GHOGnosisLaunch_20250421_Base is ProtocolV3TestBase {
  struct Common {
    IRouter router;
    IGhoToken token;
    IEVM2EVMOnRamp arbOnRamp;
    IEVM2EVMOnRamp gnoOnRamp;
    IEVM2EVMOnRamp ethOnRamp;
    IEVM2EVMOnRamp baseOnRamp;
    IEVM2EVMOnRamp avaxOnRamp;
    IEVM2EVMOffRamp_1_5 arbOffRamp;
    IEVM2EVMOffRamp_1_5 gnoOffRamp;
    IEVM2EVMOffRamp_1_5 ethOffRamp;
    IEVM2EVMOffRamp_1_5 baseOffRamp;
    IEVM2EVMOffRamp_1_5 avaxOffRamp;
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
  struct GNO {
    AaveV3Gnosis_GHOGnosisLaunch_20250421 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }
  struct AVAX {
    AaveV3Avalanche_GHOGnosisLaunch_20250421 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }

  address internal constant RISK_COUNCIL = GHOLaunchConstants.RISK_COUNCIL; // common across all chains
  address internal constant RMN_PROXY_GNOSIS = GHOLaunchConstants.GNO_RMN_PROXY;
  address internal constant ROUTER_GNOSIS = GHOLaunchConstants.GNO_CCIP_ROUTER;
  address internal constant GHO_TOKEN_IMPL_GNOSIS = GHOLaunchConstants.GNO_GHO_TOKEN_IMPL;
  IGhoToken internal constant GHO_TOKEN_GNOSIS = IGhoToken(GHOLaunchConstants.GNO_GHO_TOKEN);
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOLaunchConstants.CCIP_RATE_LIMIT_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOLaunchConstants.CCIP_RATE_LIMIT_REFILL_RATE;

  ARB internal arb;
  BASE internal base;
  ETH internal eth;
  GNO internal gno;
  AVAX internal avax;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  IGhoAaveSteward internal GHO_AAVE_STEWARD_GNOSIS;
  IGhoBucketSteward internal GHO_BUCKET_STEWARD_GNOSIS;
  IGhoCcipSteward internal GHO_CCIP_STEWARD_GNOSIS;

  event CCIPSendRequested(IInternal.EVM2EVMMessage message);
  event Locked(address indexed sender, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);

  function setUp() public virtual {
    arb.c.forkId = vm.createFork(vm.rpcUrl('arbitrum'), 355419597);
    base.c.forkId = vm.createFork(vm.rpcUrl('base'), 32579400);
    eth.c.forkId = vm.createFork(vm.rpcUrl('mainnet'), 22872021);
    gno.c.forkId = vm.createFork(vm.rpcUrl('gnosis'), 40977394);
    avax.c.forkId = vm.createFork(vm.rpcUrl('avalanche'), 65115278);

    arb.c.chainSelector = CCIPUtils.ARB_CHAIN_SELECTOR;
    base.c.chainSelector = CCIPUtils.BASE_CHAIN_SELECTOR;
    eth.c.chainSelector = CCIPUtils.ETH_CHAIN_SELECTOR;
    gno.c.chainSelector = CCIPUtils.GNOSIS_CHAIN_SELECTOR;
    avax.c.chainSelector = CCIPUtils.AVAX_CHAIN_SELECTOR;

    vm.selectFork(arb.c.forkId);
    arb.proposal = new AaveV3Arbitrum_GHOGnosisLaunch_20250421();
    arb.c.token = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);
    arb.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(GhoArbitrum.GHO_CCIP_TOKEN_POOL);
    arb.c.tokenAdminRegistry = ITokenAdminRegistry(GHOLaunchConstants.ARB_TOKEN_ADMIN_REGISTRY);
    arb.c.router = IRouter(arb.tokenPool.getRouter());
    arb.c.gnoOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.ARB_GNO_ON_RAMP);
    arb.c.ethOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.ARB_ETH_ON_RAMP);
    arb.c.baseOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.ARB_BASE_ON_RAMP);
    arb.c.avaxOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.ARB_AVAX_ON_RAMP);
    arb.c.gnoOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.ARB_GNO_OFF_RAMP);
    arb.c.ethOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.ARB_ETH_OFF_RAMP);
    arb.c.baseOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.ARB_BASE_OFF_RAMP);
    arb.c.avaxOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.ARB_AVAX_OFF_RAMP);

    vm.selectFork(base.c.forkId);
    base.proposal = new AaveV3Base_GHOGnosisLaunch_20250421();
    base.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(GhoBase.GHO_CCIP_TOKEN_POOL);
    base.c.tokenAdminRegistry = ITokenAdminRegistry(GHOLaunchConstants.BASE_TOKEN_ADMIN_REGISTRY);
    base.c.token = IGhoToken(AaveV3BaseAssets.GHO_UNDERLYING);
    base.c.router = IRouter(base.tokenPool.getRouter());
    base.c.arbOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.BASE_ARB_ON_RAMP);
    base.c.ethOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.BASE_ETH_ON_RAMP);
    base.c.gnoOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.BASE_GNO_ON_RAMP);
    base.c.avaxOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.BASE_AVAX_ON_RAMP);
    base.c.arbOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.BASE_ARB_OFF_RAMP);
    base.c.ethOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.BASE_ETH_OFF_RAMP);
    base.c.gnoOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.BASE_GNO_OFF_RAMP);
    base.c.avaxOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.BASE_AVAX_OFF_RAMP);

    vm.selectFork(eth.c.forkId);
    eth.proposal = new AaveV3Ethereum_GHOGnosisLaunch_20250421();
    eth.c.token = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING);
    eth.tokenPool = IUpgradeableLockReleaseTokenPool_1_5_1(GhoEthereum.GHO_CCIP_TOKEN_POOL);
    eth.c.tokenAdminRegistry = ITokenAdminRegistry(GHOLaunchConstants.ETH_TOKEN_ADMIN_REGISTRY);
    eth.c.router = IRouter(eth.tokenPool.getRouter());
    eth.c.arbOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.ETH_ARB_ON_RAMP);
    eth.c.gnoOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.ETH_GNO_ON_RAMP);
    eth.c.baseOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.ETH_BASE_ON_RAMP);
    eth.c.avaxOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.ETH_AVAX_ON_RAMP);
    eth.c.arbOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.ETH_ARB_OFF_RAMP);
    eth.c.gnoOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.ETH_GNO_OFF_RAMP);
    eth.c.baseOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.ETH_BASE_OFF_RAMP);
    eth.c.avaxOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.ETH_AVAX_OFF_RAMP);

    vm.selectFork(gno.c.forkId);
    gno.proposal = new AaveV3Gnosis_GHOGnosisLaunch_20250421();
    gno.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(GHOLaunchConstants.GNO_TOKEN_POOL);
    gno.c.tokenAdminRegistry = ITokenAdminRegistry(GHOLaunchConstants.GNO_TOKEN_ADMIN_REGISTRY);
    gno.c.token = GHO_TOKEN_GNOSIS;
    gno.c.router = IRouter(gno.tokenPool.getRouter());
    gno.c.arbOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.GNO_ARB_ON_RAMP);
    gno.c.baseOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.GNO_BASE_ON_RAMP);
    gno.c.ethOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.GNO_ETH_ON_RAMP);
    gno.c.avaxOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.GNO_AVAX_ON_RAMP);
    gno.c.arbOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.GNO_ARB_OFF_RAMP);
    gno.c.baseOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.GNO_BASE_OFF_RAMP);
    gno.c.ethOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.GNO_ETH_OFF_RAMP);
    gno.c.avaxOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.GNO_AVAX_OFF_RAMP);

    vm.selectFork(avax.c.forkId);
    avax.proposal = new AaveV3Avalanche_GHOGnosisLaunch_20250421();
    avax.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(GhoAvalanche.GHO_CCIP_TOKEN_POOL);
    avax.c.tokenAdminRegistry = ITokenAdminRegistry(GHOLaunchConstants.AVAX_TOKEN_ADMIN_REGISTRY);
    avax.c.token = IGhoToken(AaveV3AvalancheAssets.GHO_UNDERLYING);
    avax.c.router = IRouter(avax.tokenPool.getRouter());
    avax.c.arbOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.AVAX_ARB_ON_RAMP);
    avax.c.baseOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.AVAX_BASE_ON_RAMP);
    avax.c.ethOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.AVAX_ETH_ON_RAMP);
    avax.c.gnoOnRamp = IEVM2EVMOnRamp(GHOLaunchConstants.AVAX_GNO_ON_RAMP);
    avax.c.arbOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.AVAX_ARB_OFF_RAMP);
    avax.c.baseOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.AVAX_BASE_OFF_RAMP);
    avax.c.ethOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.AVAX_ETH_OFF_RAMP);
    avax.c.gnoOffRamp = IEVM2EVMOffRamp_1_5(GHOLaunchConstants.AVAX_GNO_OFF_RAMP);

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
    assertEq(arb.c.chainSelector, CCIPUtils.ARB_CHAIN_SELECTOR);
    assertEq(address(arb.c.token), AaveV3ArbitrumAssets.GHO_UNDERLYING);
    assertEq(arb.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(arb.c.gnoOnRamp, arb.c.chainSelector, gno.c.chainSelector, arb.c.router);
    _assertOnRamp(arb.c.ethOnRamp, arb.c.chainSelector, eth.c.chainSelector, arb.c.router);
    _assertOnRamp(arb.c.baseOnRamp, arb.c.chainSelector, base.c.chainSelector, arb.c.router);
    _assertOnRamp(arb.c.avaxOnRamp, arb.c.chainSelector, avax.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.gnoOffRamp, gno.c.chainSelector, arb.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.ethOffRamp, eth.c.chainSelector, arb.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.baseOffRamp, base.c.chainSelector, arb.c.chainSelector, arb.c.router);
    _assertOffRamp(arb.c.avaxOffRamp, avax.c.chainSelector, arb.c.chainSelector, arb.c.router);

    // proposal constants
    assertEq(arb.proposal.GNOSIS_CHAIN_SELECTOR(), gno.c.chainSelector);
    assertEq(address(arb.proposal.TOKEN_POOL()), address(arb.tokenPool));
    assertEq(arb.proposal.REMOTE_TOKEN_POOL_GNOSIS(), address(gno.tokenPool));
    assertEq(arb.proposal.REMOTE_GHO_TOKEN_GNOSIS(), address(gno.c.token));

    vm.selectFork(base.c.forkId);
    assertEq(base.c.chainSelector, CCIPUtils.BASE_CHAIN_SELECTOR);
    assertEq(address(base.c.token), AaveV3BaseAssets.GHO_UNDERLYING);
    assertEq(base.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(base.c.arbOnRamp, base.c.chainSelector, arb.c.chainSelector, base.c.router);
    _assertOnRamp(base.c.gnoOnRamp, base.c.chainSelector, gno.c.chainSelector, base.c.router);
    _assertOnRamp(base.c.ethOnRamp, base.c.chainSelector, eth.c.chainSelector, base.c.router);
    _assertOnRamp(base.c.avaxOnRamp, base.c.chainSelector, avax.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.arbOffRamp, arb.c.chainSelector, base.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.gnoOffRamp, gno.c.chainSelector, base.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.ethOffRamp, eth.c.chainSelector, base.c.chainSelector, base.c.router);
    _assertOffRamp(base.c.avaxOffRamp, avax.c.chainSelector, base.c.chainSelector, base.c.router);

    // proposal constants
    assertEq(base.proposal.GNOSIS_CHAIN_SELECTOR(), gno.c.chainSelector);
    assertEq(address(base.proposal.TOKEN_POOL()), address(base.tokenPool));
    assertEq(base.proposal.REMOTE_TOKEN_POOL_GNOSIS(), address(gno.tokenPool));
    assertEq(base.proposal.REMOTE_GHO_TOKEN_GNOSIS(), address(gno.c.token));

    vm.selectFork(gno.c.forkId);
    assertEq(gno.c.chainSelector, CCIPUtils.GNOSIS_CHAIN_SELECTOR);
    assertEq(gno.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(gno.c.arbOnRamp, gno.c.chainSelector, arb.c.chainSelector, gno.c.router);
    _assertOnRamp(gno.c.ethOnRamp, gno.c.chainSelector, eth.c.chainSelector, gno.c.router);
    _assertOnRamp(gno.c.baseOnRamp, gno.c.chainSelector, base.c.chainSelector, gno.c.router);
    _assertOnRamp(gno.c.avaxOnRamp, gno.c.chainSelector, avax.c.chainSelector, gno.c.router);
    _assertOffRamp(gno.c.arbOffRamp, arb.c.chainSelector, gno.c.chainSelector, gno.c.router);
    _assertOffRamp(gno.c.ethOffRamp, eth.c.chainSelector, gno.c.chainSelector, gno.c.router);
    _assertOffRamp(gno.c.baseOffRamp, base.c.chainSelector, gno.c.chainSelector, gno.c.router);
    _assertOffRamp(gno.c.avaxOffRamp, avax.c.chainSelector, gno.c.chainSelector, gno.c.router);

    // proposal constants
    assertEq(gno.proposal.ETH_CHAIN_SELECTOR(), eth.c.chainSelector);
    assertEq(gno.proposal.ARB_CHAIN_SELECTOR(), arb.c.chainSelector);
    assertEq(gno.proposal.CCIP_BUCKET_CAPACITY(), GHOLaunchConstants.CCIP_BUCKET_CAPACITY);
    assertEq(address(gno.proposal.TOKEN_ADMIN_REGISTRY()), address(gno.c.tokenAdminRegistry));
    assertEq(address(gno.proposal.TOKEN_POOL()), address(gno.tokenPool));
    IGhoCcipSteward ghoCcipSteward = IGhoCcipSteward(gno.proposal.GHO_CCIP_STEWARD());
    assertEq(ghoCcipSteward.GHO_TOKEN_POOL(), address(gno.tokenPool));
    assertEq(ghoCcipSteward.GHO_TOKEN(), address(gno.c.token));
    assertEq(gno.proposal.REMOTE_TOKEN_POOL_ETH(), address(eth.tokenPool));
    assertEq(gno.proposal.REMOTE_TOKEN_POOL_ARB(), address(arb.tokenPool));

    vm.selectFork(eth.c.forkId);
    assertEq(eth.c.chainSelector, CCIPUtils.ETH_CHAIN_SELECTOR);
    assertEq(address(eth.c.token), AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(eth.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(eth.c.arbOnRamp, eth.c.chainSelector, arb.c.chainSelector, eth.c.router);
    _assertOnRamp(eth.c.gnoOnRamp, eth.c.chainSelector, gno.c.chainSelector, eth.c.router);
    _assertOnRamp(eth.c.baseOnRamp, eth.c.chainSelector, base.c.chainSelector, eth.c.router);
    _assertOnRamp(eth.c.avaxOnRamp, eth.c.chainSelector, avax.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.arbOffRamp, arb.c.chainSelector, eth.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.gnoOffRamp, gno.c.chainSelector, eth.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.baseOffRamp, base.c.chainSelector, eth.c.chainSelector, eth.c.router);
    _assertOffRamp(eth.c.avaxOffRamp, avax.c.chainSelector, eth.c.chainSelector, eth.c.router);

    // proposal constants
    assertEq(eth.proposal.GNOSIS_CHAIN_SELECTOR(), gno.c.chainSelector);
    assertEq(address(eth.proposal.TOKEN_POOL()), address(eth.tokenPool));
    assertEq(eth.proposal.REMOTE_TOKEN_POOL_GNOSIS(), address(gno.tokenPool));
    assertEq(eth.proposal.REMOTE_GHO_TOKEN_GNOSIS(), address(gno.c.token));

    vm.selectFork(avax.c.forkId);
    assertEq(avax.c.chainSelector, CCIPUtils.AVAX_CHAIN_SELECTOR);
    assertEq(address(avax.c.token), AaveV3AvalancheAssets.GHO_UNDERLYING);
    assertEq(avax.c.router.typeAndVersion(), 'Router 1.2.0');
    _assertOnRamp(avax.c.arbOnRamp, avax.c.chainSelector, arb.c.chainSelector, avax.c.router);
    _assertOnRamp(avax.c.gnoOnRamp, avax.c.chainSelector, gno.c.chainSelector, avax.c.router);
    _assertOnRamp(avax.c.baseOnRamp, avax.c.chainSelector, base.c.chainSelector, avax.c.router);
    _assertOnRamp(avax.c.ethOnRamp, avax.c.chainSelector, eth.c.chainSelector, avax.c.router);
    _assertOffRamp(avax.c.arbOffRamp, arb.c.chainSelector, avax.c.chainSelector, avax.c.router);
    _assertOffRamp(avax.c.gnoOffRamp, gno.c.chainSelector, avax.c.chainSelector, avax.c.router);
    _assertOffRamp(avax.c.baseOffRamp, base.c.chainSelector, avax.c.chainSelector, avax.c.router);
    _assertOffRamp(avax.c.ethOffRamp, eth.c.chainSelector, avax.c.chainSelector, avax.c.router);

    // proposal constants
    assertEq(avax.proposal.GNOSIS_CHAIN_SELECTOR(), gno.c.chainSelector);
    assertEq(address(avax.proposal.TOKEN_POOL()), address(avax.tokenPool));
    assertEq(avax.proposal.REMOTE_TOKEN_POOL_GNOSIS(), address(gno.tokenPool));
    assertEq(avax.proposal.REMOTE_GHO_TOKEN_GNOSIS(), address(gno.c.token));

    if (executed) {
      vm.selectFork(arb.c.forkId);
      assertEq(arb.c.tokenAdminRegistry.getPool(address(arb.c.token)), address(arb.tokenPool));
      assertEq(arb.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(arb.tokenPool.getSupportedChains()[1], base.c.chainSelector);
      assertEq(arb.tokenPool.getSupportedChains()[2], avax.c.chainSelector);
      assertEq(arb.tokenPool.getSupportedChains()[3], gno.c.chainSelector);
      assertEq(arb.tokenPool.getRemoteToken(eth.c.chainSelector), abi.encode(address(eth.c.token)));
      assertEq(arb.tokenPool.getRemoteToken(gno.c.chainSelector), abi.encode(address(gno.c.token)));
      assertEq(arb.tokenPool.getRemotePools(gno.c.chainSelector).length, 1);
      assertEq(
        arb.tokenPool.getRemotePools(gno.c.chainSelector)[0],
        abi.encode(address(gno.tokenPool))
      );
      assertEq(arb.tokenPool.getRemotePools(eth.c.chainSelector).length, 2);
      assertEq(
        arb.tokenPool.getRemotePools(eth.c.chainSelector)[1], // 0th is the 1.4 token pool
        abi.encode(address(eth.tokenPool))
      );

      vm.selectFork(base.c.forkId);
      assertEq(base.c.tokenAdminRegistry.getPool(address(base.c.token)), address(base.tokenPool));
      assertEq(base.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(base.tokenPool.getSupportedChains()[1], arb.c.chainSelector);
      assertEq(base.tokenPool.getSupportedChains()[2], avax.c.chainSelector);
      assertEq(base.tokenPool.getSupportedChains()[3], gno.c.chainSelector);
      assertEq(
        base.tokenPool.getRemoteToken(eth.c.chainSelector),
        abi.encode(address(eth.c.token))
      );
      assertEq(
        base.tokenPool.getRemoteToken(gno.c.chainSelector),
        abi.encode(address(gno.c.token))
      );
      assertEq(base.tokenPool.getRemotePools(gno.c.chainSelector).length, 1);
      assertEq(
        base.tokenPool.getRemotePools(gno.c.chainSelector)[0],
        abi.encode(address(gno.tokenPool))
      );
      assertEq(base.tokenPool.getRemotePools(eth.c.chainSelector).length, 1);
      assertEq(
        base.tokenPool.getRemotePools(eth.c.chainSelector)[0],
        abi.encode(address(eth.tokenPool))
      );
      assertEq(base.tokenPool.getRemotePools(avax.c.chainSelector).length, 1);
      assertEq(
        base.tokenPool.getRemotePools(avax.c.chainSelector)[0],
        abi.encode(address(avax.tokenPool))
      );

      vm.selectFork(gno.c.forkId);
      assertEq(address(gno.proposal.GHO_TOKEN()), address(gno.c.token));
      assertEq(gno.c.tokenAdminRegistry.getPool(address(gno.c.token)), address(gno.tokenPool));
      assertEq(gno.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(gno.tokenPool.getSupportedChains()[1], arb.c.chainSelector);
      assertEq(gno.tokenPool.getSupportedChains()[2], base.c.chainSelector);
      assertEq(gno.tokenPool.getSupportedChains()[3], avax.c.chainSelector);
      assertEq(gno.tokenPool.getRemoteToken(arb.c.chainSelector), abi.encode(address(arb.c.token)));
      assertEq(gno.tokenPool.getRemoteToken(eth.c.chainSelector), abi.encode(address(eth.c.token)));
      assertEq(gno.tokenPool.getRemotePools(arb.c.chainSelector).length, 1);
      assertEq(
        gno.tokenPool.getRemotePools(arb.c.chainSelector)[0],
        abi.encode(address(arb.tokenPool))
      );
      assertEq(gno.tokenPool.getRemotePools(eth.c.chainSelector).length, 1);
      assertEq(
        gno.tokenPool.getRemotePools(eth.c.chainSelector)[0],
        abi.encode(address(eth.tokenPool))
      );
      assertEq(gno.tokenPool.getRemotePools(base.c.chainSelector).length, 1);
      assertEq(
        gno.tokenPool.getRemotePools(base.c.chainSelector)[0],
        abi.encode(address(base.tokenPool))
      );
      _assertSetRateLimit(gno.c, address(gno.tokenPool));

      vm.selectFork(eth.c.forkId);
      assertEq(eth.c.tokenAdminRegistry.getPool(address(eth.c.token)), address(eth.tokenPool));
      assertEq(eth.tokenPool.getSupportedChains()[0], arb.c.chainSelector);
      assertEq(eth.tokenPool.getSupportedChains()[1], base.c.chainSelector);
      assertEq(eth.tokenPool.getSupportedChains()[2], avax.c.chainSelector);
      assertEq(eth.tokenPool.getSupportedChains()[3], gno.c.chainSelector);
      assertEq(eth.tokenPool.getRemoteToken(arb.c.chainSelector), abi.encode(address(arb.c.token)));
      assertEq(eth.tokenPool.getRemoteToken(gno.c.chainSelector), abi.encode(address(gno.c.token)));
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
      assertEq(eth.tokenPool.getRemotePools(gno.c.chainSelector).length, 1);
      assertEq(
        eth.tokenPool.getRemotePools(gno.c.chainSelector)[0],
        abi.encode(address(gno.tokenPool))
      );

      vm.selectFork(avax.c.forkId);
      assertEq(avax.c.tokenAdminRegistry.getPool(address(avax.c.token)), address(avax.tokenPool));
      assertEq(avax.tokenPool.getSupportedChains()[0], eth.c.chainSelector);
      assertEq(avax.tokenPool.getSupportedChains()[1], arb.c.chainSelector);
      assertEq(avax.tokenPool.getSupportedChains()[2], base.c.chainSelector);
      assertEq(avax.tokenPool.getSupportedChains()[3], gno.c.chainSelector);
      assertEq(
        avax.tokenPool.getRemoteToken(eth.c.chainSelector),
        abi.encode(address(eth.c.token))
      );
      assertEq(
        avax.tokenPool.getRemoteToken(arb.c.chainSelector),
        abi.encode(address(arb.c.token))
      );
      assertEq(
        avax.tokenPool.getRemoteToken(base.c.chainSelector),
        abi.encode(address(base.c.token))
      );
      assertEq(
        avax.tokenPool.getRemoteToken(gno.c.chainSelector),
        abi.encode(address(gno.c.token))
      );
      assertEq(avax.tokenPool.getRemotePools(eth.c.chainSelector).length, 1);
      assertEq(
        avax.tokenPool.getRemotePools(eth.c.chainSelector)[0],
        abi.encode(address(eth.tokenPool))
      );
      assertEq(avax.tokenPool.getRemotePools(arb.c.chainSelector).length, 1);
      assertEq(
        avax.tokenPool.getRemotePools(arb.c.chainSelector)[0],
        abi.encode(address(arb.tokenPool))
      );
      assertEq(avax.tokenPool.getRemotePools(base.c.chainSelector).length, 1);
      assertEq(
        avax.tokenPool.getRemotePools(base.c.chainSelector)[0],
        abi.encode(address(base.tokenPool))
      );
      assertEq(avax.tokenPool.getRemotePools(gno.c.chainSelector).length, 1);
      assertEq(
        avax.tokenPool.getRemotePools(gno.c.chainSelector)[0],
        abi.encode(address(gno.tokenPool))
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
    (
      Common memory dst1,
      Common memory dst2,
      Common memory dst3,
      Common memory dst4
    ) = _getDestination(src);
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

    assertEq(
      _tokenPool.getCurrentInboundRateLimiterState(dst3.chainSelector),
      _getRateLimiterConfig()
    );
    assertEq(
      _tokenPool.getCurrentOutboundRateLimiterState(dst3.chainSelector),
      _getRateLimiterConfig()
    );
    assertEq(
      _tokenPool.getCurrentInboundRateLimiterState(dst4.chainSelector),
      _getRateLimiterConfig()
    );
    assertEq(
      _tokenPool.getCurrentOutboundRateLimiterState(dst4.chainSelector),
      _getRateLimiterConfig()
    );
  }

  function _getDestination(
    Common memory src
  ) internal view returns (Common memory, Common memory, Common memory, Common memory) {
    if (src.forkId == arb.c.forkId) return (gno.c, eth.c, avax.c, base.c);
    else if (src.forkId == gno.c.forkId) return (arb.c, eth.c, avax.c, base.c);
    else if (src.forkId == avax.c.forkId) return (gno.c, eth.c, arb.c, base.c);
    else if (src.forkId == base.c.forkId) return (arb.c, gno.c, eth.c, avax.c);
    else return (arb.c, gno.c, avax.c, base.c);
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

    vm.selectFork(gno.c.forkId);
    executePayload(vm, address(gno.proposal));

    vm.selectFork(avax.c.forkId);
    executePayload(vm, address(avax.proposal));

    _validateConfig({executed: true});
  }

  function test_E2E_Eth_Gnosis(uint256 amount) public {
    {
      vm.selectFork(eth.c.forkId);
      uint256 bridgeableAmount = _min(
        eth.tokenPool.getBridgeLimit() - eth.tokenPool.getCurrentBridgedAmount(),
        CCIP_RATE_LIMIT_CAPACITY
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(eth.c, gno.c);

      vm.prank(alice);
      eth.c.token.approve(address(eth.c.router), amount);
      deal(address(eth.c.token), alice, amount);

      uint256 tokenPoolBalance = eth.c.token.balanceOf(address(eth.tokenPool));
      uint256 aliceBalance = eth.c.token.balanceOf(alice);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: eth.c, dst: gno.c, sender: alice, amount: amount}));

      vm.expectEmit(address(eth.tokenPool));
      emit Locked(address(eth.c.gnoOnRamp), amount);
      vm.expectEmit(address(eth.c.gnoOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      eth.c.router.ccipSend{value: eventArg.feeTokenAmount}(gno.c.chainSelector, message);

      assertEq(eth.c.token.balanceOf(address(eth.tokenPool)), tokenPoolBalance + amount);
      assertEq(eth.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

      // base execute message
      vm.selectFork(gno.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(gno.c, eth.c);
      assertEq(gno.c.token.balanceOf(alice), 0);
      assertEq(gno.c.token.totalSupply(), 0); // first bridge
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(gno.tokenPool));
      emit Minted(address(gno.c.ethOffRamp), alice, amount);

      vm.prank(address(gno.c.ethOffRamp));
      gno.c.ethOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(gno.c.token.balanceOf(alice), amount);
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, amount);
    }

    // send amount back to eth
    {
      // send base from base
      vm.selectFork(gno.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(gno.c, eth.c);
      vm.prank(alice);
      gno.c.token.approve(address(gno.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: gno.c, dst: eth.c, sender: alice, amount: amount}));

      vm.expectEmit(address(gno.tokenPool));
      emit Burned(address(gno.c.ethOnRamp), amount);
      vm.expectEmit(address(gno.c.ethOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      gno.c.router.ccipSend{value: eventArg.feeTokenAmount}(eth.c.chainSelector, message);

      assertEq(gno.c.token.balanceOf(alice), 0);
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, 0);

      // eth execute message
      vm.selectFork(eth.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(eth.c, gno.c);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      vm.expectEmit(address(eth.tokenPool));
      emit Released(address(eth.c.gnoOffRamp), alice, amount);
      vm.prank(address(eth.c.gnoOffRamp));
      eth.c.gnoOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(eth.c.token.balanceOf(alice), amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount - amount);
    }
  }

  function test_E2E_Arb_Gnosis(uint256 amount) public {
    {
      vm.selectFork(arb.c.forkId);
      IRateLimiter.TokenBucket memory gnoRateLimits = arb
        .tokenPool
        .getCurrentInboundRateLimiterState(gno.c.chainSelector);
      uint256 bridgeableAmount = _min(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        gnoRateLimits.capacity
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(arb.c, gno.c);

      vm.prank(alice);
      arb.c.token.approve(address(arb.c.router), amount);
      deal(address(arb.c.token), alice, amount);

      uint256 aliceBalance = arb.c.token.balanceOf(alice);
      uint256 facilitatorLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: arb.c, dst: gno.c, sender: alice, amount: amount}));

      vm.expectEmit(address(arb.tokenPool));
      emit Burned(address(arb.c.gnoOnRamp), amount);
      vm.expectEmit(address(arb.c.gnoOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      arb.c.router.ccipSend{value: eventArg.feeTokenAmount}(gno.c.chainSelector, message);

      assertEq(arb.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        facilitatorLevel - amount
      );

      // gno execute message
      vm.selectFork(gno.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(gno.c, arb.c);
      assertEq(gno.c.token.balanceOf(alice), 0);
      assertEq(gno.c.token.totalSupply(), 0); // first bridge
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(gno.tokenPool));
      emit Minted(address(gno.c.arbOffRamp), alice, amount);

      vm.prank(address(gno.c.arbOffRamp));
      gno.c.arbOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(gno.c.token.balanceOf(alice), amount);
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, amount);
    }

    // send amount back to arb
    {
      // send base from gno
      vm.selectFork(gno.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(gno.c, arb.c);
      vm.prank(alice);
      gno.c.token.approve(address(gno.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(CCIPSendParams({src: gno.c, dst: arb.c, sender: alice, amount: amount}));

      vm.expectEmit(address(gno.tokenPool));
      emit Burned(address(gno.c.arbOnRamp), amount);
      vm.expectEmit(address(gno.c.arbOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      gno.c.router.ccipSend{value: eventArg.feeTokenAmount}(arb.c.chainSelector, message);

      assertEq(gno.c.token.balanceOf(alice), 0);
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, 0);

      // arb execute message
      vm.selectFork(arb.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(arb.c, gno.c);
      uint256 facilitatorLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      vm.expectEmit(address(arb.tokenPool));
      emit Minted(address(arb.c.gnoOffRamp), alice, amount);
      vm.prank(address(arb.c.gnoOffRamp));
      arb.c.gnoOffRamp.executeSingleMessage({
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

  function test_E2E_Base_Gnosis(uint256 amount) public {
    {
      vm.selectFork(base.c.forkId);
      IRateLimiter.TokenBucket memory gnoRateLimits = base
        .tokenPool
        .getCurrentInboundRateLimiterState(gno.c.chainSelector);
      uint256 bridgeableAmount = _min(
        base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel,
        gnoRateLimits.capacity
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(base.c, gno.c);

      vm.prank(alice);
      base.c.token.approve(address(base.c.router), amount);
      deal(address(base.c.token), alice, amount);

      uint256 aliceBalance = base.c.token.balanceOf(alice);
      uint256 facilitatorLevel = base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel;

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: base.c, dst: gno.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(base.tokenPool));
      emit Burned(address(base.c.gnoOnRamp), amount);
      vm.expectEmit(address(base.c.gnoOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      base.c.router.ccipSend{value: eventArg.feeTokenAmount}(gno.c.chainSelector, message);

      assertEq(base.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(
        base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel,
        facilitatorLevel - amount
      );

      // gno execute message
      vm.selectFork(gno.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(gno.c, base.c);
      assertEq(gno.c.token.balanceOf(alice), 0);
      assertEq(gno.c.token.totalSupply(), 0); // first bridge
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(gno.tokenPool));
      emit Minted(address(gno.c.baseOffRamp), alice, amount);

      vm.prank(address(gno.c.baseOffRamp));
      gno.c.baseOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(gno.c.token.balanceOf(alice), amount);
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, amount);
    }

    // send amount back to gno
    {
      vm.selectFork(gno.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(gno.c, base.c);
      vm.prank(alice);
      gno.c.token.approve(address(gno.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: gno.c, dst: base.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(gno.tokenPool));
      emit Burned(address(gno.c.baseOnRamp), amount);
      vm.expectEmit(address(gno.c.baseOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      gno.c.router.ccipSend{value: eventArg.feeTokenAmount}(base.c.chainSelector, message);

      assertEq(gno.c.token.balanceOf(alice), 0);
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, 0);

      // base execute message
      vm.selectFork(base.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(base.c, gno.c);
      uint256 facilitatorLevel = base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel;

      vm.expectEmit(address(base.tokenPool));
      emit Minted(address(base.c.gnoOffRamp), alice, amount);
      vm.prank(address(base.c.gnoOffRamp));
      base.c.gnoOffRamp.executeSingleMessage({
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

  function test_E2E_Avax_Gnosis(uint256 amount) public {
    {
      vm.selectFork(avax.c.forkId);
      IRateLimiter.TokenBucket memory gnoRateLimits = avax
        .tokenPool
        .getCurrentInboundRateLimiterState(gno.c.chainSelector);
      uint256 bridgeableAmount = _min(
        avax.c.token.getFacilitator(address(avax.tokenPool)).bucketLevel,
        gnoRateLimits.capacity
      );
      amount = bound(amount, 1, bridgeableAmount);
      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(avax.c, gno.c);

      vm.prank(alice);
      avax.c.token.approve(address(avax.c.router), amount);
      deal(address(avax.c.token), alice, amount);

      uint256 aliceBalance = avax.c.token.balanceOf(alice);
      uint256 facilitatorLevel = avax.c.token.getFacilitator(address(avax.tokenPool)).bucketLevel;

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: avax.c, dst: gno.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(avax.tokenPool));
      emit Burned(address(avax.c.gnoOnRamp), amount);
      vm.expectEmit(address(avax.c.gnoOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      avax.c.router.ccipSend{value: eventArg.feeTokenAmount}(gno.c.chainSelector, message);

      assertEq(avax.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(
        avax.c.token.getFacilitator(address(avax.tokenPool)).bucketLevel,
        facilitatorLevel - amount
      );

      // gno execute message
      vm.selectFork(gno.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(gno.c, avax.c);
      assertEq(gno.c.token.balanceOf(alice), 0);
      assertEq(gno.c.token.totalSupply(), 0); // first bridge
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(gno.tokenPool));
      emit Minted(address(gno.c.avaxOffRamp), alice, amount);

      vm.prank(address(gno.c.avaxOffRamp));
      gno.c.avaxOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(gno.c.token.balanceOf(alice), amount);
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, amount);
    }

    // send amount back to avax
    {
      // send base from gno
      vm.selectFork(gno.c.forkId);

      skip(_getOutboundRefillTime(amount));
      _refreshGasAndTokenPrices(gno.c, avax.c);
      vm.prank(alice);
      gno.c.token.approve(address(gno.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: gno.c, dst: avax.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(gno.tokenPool));
      emit Burned(address(gno.c.avaxOnRamp), amount);
      vm.expectEmit(address(gno.c.avaxOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      gno.c.router.ccipSend{value: eventArg.feeTokenAmount}(avax.c.chainSelector, message);

      assertEq(gno.c.token.balanceOf(alice), 0);
      assertEq(gno.c.token.getFacilitator(address(gno.tokenPool)).bucketLevel, 0);

      // avax execute message
      vm.selectFork(avax.c.forkId);

      skip(_getInboundRefillTime(amount));
      _refreshGasAndTokenPrices(avax.c, gno.c);
      uint256 facilitatorLevel = avax.c.token.getFacilitator(address(avax.tokenPool)).bucketLevel;

      vm.expectEmit(address(avax.tokenPool));
      emit Minted(address(avax.c.gnoOffRamp), alice, amount);
      vm.prank(address(avax.c.gnoOffRamp));
      avax.c.gnoOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(avax.c.token.balanceOf(alice), amount);
      assertEq(
        avax.c.token.getFacilitator(address(avax.tokenPool)).bucketLevel,
        facilitatorLevel + amount
      );
    }
  }

  function test_E2E_Eth_Arb(uint256 amount) public {
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
