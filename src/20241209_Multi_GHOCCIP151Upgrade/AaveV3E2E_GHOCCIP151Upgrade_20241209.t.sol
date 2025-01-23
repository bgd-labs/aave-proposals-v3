// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableLockReleaseTokenPool_1_4, IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IUpgradeableBurnMintTokenPool_1_4, IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {IEVM2EVMOffRamp_1_5} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IPriceRegistry} from 'src/interfaces/ccip/IPriceRegistry.sol';
import {IProxyPool} from 'src/interfaces/ccip/IProxyPool.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {AaveV3Ethereum_GHOCCIP151Upgrade_20241209} from './AaveV3Ethereum_GHOCCIP151Upgrade_20241209.sol';
import {AaveV3Arbitrum_GHOCCIP151Upgrade_20241209} from './AaveV3Arbitrum_GHOCCIP151Upgrade_20241209.sol';

/**
 * @dev Test for AaveV3E2E_GHOCCIP151Upgrade_20241209
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241209_Multi_GHOCCIP151Upgrade/AaveV3E2E_GHOCCIP151Upgrade_20241209.t.sol -vv
 */
contract AaveV3E2E_GHOCCIP151Upgrade_20241209_Base is ProtocolV3TestBase {
  struct CCIPSendParams {
    IRouter router;
    IGhoToken token;
    uint256 amount;
    uint64 sourceChainSelector;
    uint64 destinationChainSelector;
    address sender;
    CCIPUtils.PoolVersion poolVersion;
  }

  struct Common {
    IRouter router;
    IGhoToken token;
    IEVM2EVMOnRamp EVM2EVMOnRamp;
    IEVM2EVMOffRamp_1_5 EVM2EVMOffRamp;
    ITokenAdminRegistry tokenAdminRegistry;
    IGhoCcipSteward newGhoCcipSteward;
    IPriceRegistry priceRegistry;
    address proxyPool;
    uint64 chainSelector;
    uint256 forkId;
  }

  struct L1 {
    AaveV3Ethereum_GHOCCIP151Upgrade_20241209 proposal;
    IUpgradeableLockReleaseTokenPool_1_5_1 newTokenPool;
    IUpgradeableLockReleaseTokenPool_1_4 existingTokenPool;
    Common c;
  }

  struct L2 {
    AaveV3Arbitrum_GHOCCIP151Upgrade_20241209 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 newTokenPool;
    IUpgradeableBurnMintTokenPool_1_4 existingTokenPool;
    Common c;
  }

  L1 internal l1;
  L2 internal l2;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  uint256 internal constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  uint256 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  event CCIPSendRequested(IInternal.EVM2EVMMessage message);
  event Locked(address indexed sender, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);

  function setUp() public virtual {
    l1.c.forkId = vm.createFork(vm.rpcUrl('mainnet'), 21594804);
    l2.c.forkId = vm.createFork(vm.rpcUrl('arbitrum'), 293994020);

    vm.selectFork(l1.c.forkId);
    l1.proposal = new AaveV3Ethereum_GHOCCIP151Upgrade_20241209();
    l1.existingTokenPool = IUpgradeableLockReleaseTokenPool_1_4(
      0x5756880B6a1EAba0175227bf02a7E87c1e02B28C
    ); // MiscEthereum.GHO_CCIP_TOKEN_POOL; will be updated in address-book after AIP
    l1.newTokenPool = IUpgradeableLockReleaseTokenPool_1_5_1(
      0x06179f7C1be40863405f374E7f5F8806c728660A
    );
    l1.c.router = IRouter(l1.existingTokenPool.getRouter());
    l2.c.chainSelector = l1.existingTokenPool.getSupportedChains()[0];
    l1.c.token = IGhoToken(address(l1.existingTokenPool.getToken()));
    l1.c.EVM2EVMOnRamp = IEVM2EVMOnRamp(l1.c.router.getOnRamp(l2.c.chainSelector));
    l1.c.EVM2EVMOffRamp = IEVM2EVMOffRamp_1_5(0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9); // new offramp
    l1.c.tokenAdminRegistry = ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);
    l1.c.priceRegistry = IPriceRegistry(l1.c.EVM2EVMOnRamp.getDynamicConfig().priceRegistry);
    l1.c.proxyPool = l1.existingTokenPool.getProxyPool();

    vm.selectFork(l2.c.forkId);
    l2.proposal = new AaveV3Arbitrum_GHOCCIP151Upgrade_20241209();
    l2.existingTokenPool = IUpgradeableBurnMintTokenPool_1_4(
      0xF168B83598516A532a85995b52504a2Fa058C068
    ); // MiscArbitrum.GHO_CCIP_TOKEN_POOL; will be updated in address-book after AIP
    l2.newTokenPool = IUpgradeableBurnMintTokenPool_1_5_1(
      0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB
    );
    l2.c.router = IRouter(l2.existingTokenPool.getRouter());
    l1.c.chainSelector = l2.existingTokenPool.getSupportedChains()[0];
    l2.c.token = IGhoToken(address(l2.existingTokenPool.getToken()));
    l2.c.EVM2EVMOnRamp = IEVM2EVMOnRamp(l2.c.router.getOnRamp(l1.c.chainSelector));
    l2.c.EVM2EVMOffRamp = IEVM2EVMOffRamp_1_5(0x91e46cc5590A4B9182e47f40006140A7077Dec31); // new offramp
    l2.c.tokenAdminRegistry = ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);
    l2.c.priceRegistry = IPriceRegistry(l2.c.EVM2EVMOnRamp.getDynamicConfig().priceRegistry);
    l2.c.proxyPool = l2.existingTokenPool.getProxyPool();

    _validateConfig({upgraded: false});
  }

  function _getTokenMessage(
    CCIPSendParams memory params
  ) internal returns (IClient.EVM2AnyMessage memory, IInternal.EVM2EVMMessage memory) {
    IClient.EVM2AnyMessage memory message = CCIPUtils.generateMessage(params.sender, 1);
    message.tokenAmounts[0] = IClient.EVMTokenAmount({
      token: address(params.token),
      amount: params.amount
    });

    uint256 feeAmount = params.router.getFee(params.destinationChainSelector, message);
    deal(params.sender, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: params.router,
        sourceChainSelector: params.sourceChainSelector,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: address(params.token),
        destinationToken: address(params.token == l1.c.token ? l2.c.token : l1.c.token),
        poolVersion: params.poolVersion
      })
    );

    return (message, eventArg);
  }

  function _validateConfig(bool upgraded) internal {
    vm.selectFork(l1.c.forkId);
    assertEq(l1.c.chainSelector, 5009297550715157269);
    assertEq(address(l1.c.token), AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(l1.c.router.typeAndVersion(), 'Router 1.2.0');
    assertEq(l1.c.EVM2EVMOnRamp.typeAndVersion(), 'EVM2EVMOnRamp 1.5.0');
    assertEq(l1.c.EVM2EVMOffRamp.typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');
    assertEq(l1.existingTokenPool.typeAndVersion(), 'LockReleaseTokenPool 1.4.0');
    assertEq(l1.newTokenPool.typeAndVersion(), 'LockReleaseTokenPool 1.5.1');
    assertEq(l1.c.tokenAdminRegistry.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(l1.c.priceRegistry.typeAndVersion(), 'PriceRegistry 1.2.0');
    assertEq(
      l1.c.EVM2EVMOnRamp.getDynamicConfig().priceRegistry,
      l1.c.EVM2EVMOffRamp.getDynamicConfig().priceRegistry
    );
    assertTrue(l1.c.router.isOffRamp(l2.c.chainSelector, address(l1.c.EVM2EVMOffRamp)));
    assertEq(l1.c.router.getOnRamp(l2.c.chainSelector), address(l1.c.EVM2EVMOnRamp));

    // proposal constants
    assertEq(address(l1.proposal.TOKEN_ADMIN_REGISTRY()), address(l1.c.tokenAdminRegistry));
    assertEq(l1.proposal.ARB_CHAIN_SELECTOR(), l2.c.chainSelector);
    assertEq(address(l1.proposal.EXISTING_PROXY_POOL()), l1.c.proxyPool);
    assertEq(address(l1.proposal.EXISTING_TOKEN_POOL()), address(l1.existingTokenPool));
    assertEq(address(l1.proposal.EXISTING_REMOTE_POOL_ARB()), l2.c.proxyPool);
    assertEq(address(l1.proposal.NEW_TOKEN_POOL()), address(l1.newTokenPool));
    assertEq(address(l1.proposal.NEW_REMOTE_POOL_ARB()), address(l2.newTokenPool));
    assertEq(l1.proposal.CCIP_RATE_LIMIT_CAPACITY(), CCIP_RATE_LIMIT_CAPACITY);
    assertEq(l1.proposal.CCIP_RATE_LIMIT_REFILL_RATE(), CCIP_RATE_LIMIT_REFILL_RATE);

    if (upgraded) {
      assertEq(IProxyPool(l1.c.proxyPool).owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
      assertEq(l1.newTokenPool.owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);

      assertEq(l1.c.tokenAdminRegistry.getPool(address(l1.c.token)), address(l1.newTokenPool));

      assertEq(l1.c.token.balanceOf(address(l1.existingTokenPool)), 0);
      // we are not resetting currentBridgedAmount on the existing pool, the pool is deprecated by
      // resetting the bridge limit
      assertNotEq(l1.existingTokenPool.getCurrentBridgedAmount(), 0);
      assertEq(l1.existingTokenPool.getBridgeLimit(), 0);

      assertGt(l1.c.token.balanceOf(address(l1.newTokenPool)), 0);
      assertGt(l1.newTokenPool.getCurrentBridgedAmount(), 0);
      assertGt(l1.newTokenPool.getBridgeLimit(), 0);
    } else {
      assertEq(l1.c.tokenAdminRegistry.getPool(address(l1.c.token)), l1.c.proxyPool);

      assertGt(l1.c.token.balanceOf(address(l1.existingTokenPool)), 0);
      assertGt(l1.existingTokenPool.getCurrentBridgedAmount(), 0);
      assertGt(l1.existingTokenPool.getBridgeLimit(), 0);

      assertEq(l1.c.token.balanceOf(address(l1.newTokenPool)), 0);
      assertEq(l1.newTokenPool.getCurrentBridgedAmount(), 0);
      assertGt(l1.newTokenPool.getBridgeLimit(), 0);
    }

    vm.selectFork(l2.c.forkId);
    assertEq(l2.c.chainSelector, 4949039107694359620);
    assertEq(address(l2.c.token), AaveV3ArbitrumAssets.GHO_UNDERLYING);
    assertEq(l2.c.router.typeAndVersion(), 'Router 1.2.0');
    assertEq(l2.c.EVM2EVMOnRamp.typeAndVersion(), 'EVM2EVMOnRamp 1.5.0');
    assertEq(l2.c.EVM2EVMOffRamp.typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');
    assertEq(l2.existingTokenPool.typeAndVersion(), 'BurnMintTokenPool 1.4.0');
    assertEq(l2.newTokenPool.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(l2.c.tokenAdminRegistry.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(l2.c.priceRegistry.typeAndVersion(), 'PriceRegistry 1.2.0');
    assertEq(
      l2.c.EVM2EVMOnRamp.getDynamicConfig().priceRegistry,
      l2.c.EVM2EVMOffRamp.getDynamicConfig().priceRegistry
    );
    assertTrue(l2.c.router.isOffRamp(l1.c.chainSelector, address(l2.c.EVM2EVMOffRamp)));
    assertEq(l2.c.router.getOnRamp(l1.c.chainSelector), address(l2.c.EVM2EVMOnRamp));

    // proposal constants
    assertEq(address(l2.proposal.TOKEN_ADMIN_REGISTRY()), address(l2.c.tokenAdminRegistry));
    assertEq(l2.proposal.ETH_CHAIN_SELECTOR(), l1.c.chainSelector);
    assertEq(address(l2.proposal.EXISTING_PROXY_POOL()), l2.c.proxyPool);
    assertEq(address(l2.proposal.EXISTING_TOKEN_POOL()), address(l2.existingTokenPool));
    assertEq(address(l2.proposal.EXISTING_REMOTE_POOL_ETH()), l1.c.proxyPool);
    assertEq(address(l2.proposal.NEW_TOKEN_POOL()), address(l2.newTokenPool));
    assertEq(address(l2.proposal.NEW_REMOTE_POOL_ETH()), address(l1.newTokenPool));
    assertEq(l2.proposal.CCIP_RATE_LIMIT_CAPACITY(), CCIP_RATE_LIMIT_CAPACITY);
    assertEq(l2.proposal.CCIP_RATE_LIMIT_REFILL_RATE(), CCIP_RATE_LIMIT_REFILL_RATE);

    if (upgraded) {
      assertEq(IProxyPool(l2.c.proxyPool).owner(), GovernanceV3Arbitrum.EXECUTOR_LVL_1);
      assertEq(l2.newTokenPool.owner(), GovernanceV3Arbitrum.EXECUTOR_LVL_1);

      assertEq(l2.c.tokenAdminRegistry.getPool(address(l2.c.token)), address(l2.newTokenPool));
      assertEq(bytes(l2.c.token.getFacilitator(address(l2.existingTokenPool)).label).length, 0);
      assertEq(l2.c.token.getFacilitator(address(l2.newTokenPool)).label, 'CCIP TokenPool v1.5.1');
    } else {
      assertEq(l2.c.tokenAdminRegistry.getPool(address(l2.c.token)), l2.c.proxyPool);
      assertEq(l2.c.token.getFacilitator(address(l2.existingTokenPool)).label, 'CCIP TokenPool');
      assertEq(bytes(l2.c.token.getFacilitator(address(l2.newTokenPool)).label).length, 0);
    }
  }

  function _executeUpgradeAIP() internal {
    vm.selectFork(l1.c.forkId);
    executePayload(vm, address(l1.proposal));
    vm.selectFork(l2.c.forkId);
    executePayload(vm, address(l2.proposal));
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

  // @dev refresh token prices to the last stored such that price is not stale
  // @dev assumed c.forkId is already active
  function _refreshGasAndTokenPrices(Common memory c) internal {
    uint64 destChainSelector = c.forkId == l1.c.forkId ? l2.c.chainSelector : l1.c.chainSelector;
    address bridgeToken = address(c.token);
    address feeToken = c.router.getWrappedNative(); // needed as we do tests with wrapped native as fee token
    address linkToken = c.EVM2EVMOnRamp.getStaticConfig().linkToken; // needed as feeTokenAmount is converted to linkTokenAmount
    IInternal.TokenPriceUpdate[] memory tokenPriceUpdates = new IInternal.TokenPriceUpdate[](3);
    IInternal.GasPriceUpdate[] memory gasPriceUpdates = new IInternal.GasPriceUpdate[](1);

    tokenPriceUpdates[0] = IInternal.TokenPriceUpdate({
      sourceToken: bridgeToken,
      usdPerToken: c.priceRegistry.getTokenPrice(bridgeToken).value
    });
    tokenPriceUpdates[1] = IInternal.TokenPriceUpdate({
      sourceToken: feeToken,
      usdPerToken: c.priceRegistry.getTokenPrice(feeToken).value
    });
    tokenPriceUpdates[2] = IInternal.TokenPriceUpdate({
      sourceToken: linkToken,
      usdPerToken: c.priceRegistry.getTokenPrice(linkToken).value
    });

    gasPriceUpdates[0] = IInternal.GasPriceUpdate({
      destChainSelector: destChainSelector,
      usdPerUnitGas: c.priceRegistry.getDestinationChainGasPrice(destChainSelector).value
    });

    vm.prank(c.priceRegistry.owner());
    c.priceRegistry.updatePrices(
      IInternal.PriceUpdates({
        tokenPriceUpdates: tokenPriceUpdates,
        gasPriceUpdates: gasPriceUpdates
      })
    );
  }

  // post upgrade
  function _runEthToArb(address user, uint256 amount) internal {
    vm.selectFork(l1.c.forkId);

    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill
    _refreshGasAndTokenPrices(l1.c);

    vm.prank(user);
    l1.c.token.approve(address(l1.c.router), amount);

    uint256 tokenPoolBalance = l1.c.token.balanceOf(address(l1.newTokenPool));
    uint256 userBalance = l1.c.token.balanceOf(user);
    uint256 bridgedAmount = l1.newTokenPool.getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({
          router: l1.c.router,
          token: l1.c.token,
          amount: amount,
          sourceChainSelector: l1.c.chainSelector,
          destinationChainSelector: l2.c.chainSelector,
          sender: user,
          poolVersion: CCIPUtils.PoolVersion.V1_5_1
        })
      );

    vm.expectEmit(address(l1.newTokenPool));
    emit Locked(address(l1.c.EVM2EVMOnRamp), amount);

    vm.expectEmit(address(l1.c.EVM2EVMOnRamp));
    emit CCIPSendRequested(eventArg);
    vm.prank(user);
    l1.c.router.ccipSend{value: eventArg.feeTokenAmount}(l2.c.chainSelector, message);

    assertEq(l1.c.token.balanceOf(address(l1.newTokenPool)), tokenPoolBalance + amount);
    assertEq(l1.c.token.balanceOf(user), userBalance - amount);
    assertEq(l1.newTokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

    // ARB executeMessage
    vm.selectFork(l2.c.forkId);

    skip(_getInboundRefillTime(amount));
    _refreshGasAndTokenPrices(l2.c);

    userBalance = l2.c.token.balanceOf(user);
    uint256 bucketLevel = l2.c.token.getFacilitator(address(l2.newTokenPool)).bucketLevel;

    vm.expectEmit(address(l2.newTokenPool));
    emit Minted(address(l2.c.EVM2EVMOffRamp), user, amount);
    vm.prank(address(l2.c.EVM2EVMOffRamp));
    l2.c.EVM2EVMOffRamp.executeSingleMessage(
      eventArg,
      new bytes[](message.tokenAmounts.length),
      new uint32[](0)
    );

    assertEq(l2.c.token.balanceOf(user), userBalance + amount);
    assertEq(l2.c.token.getFacilitator(address(l2.newTokenPool)).bucketLevel, bucketLevel + amount);
  }

  // post upgrade
  function _runArbToEth(address user, uint256 amount) internal {
    vm.selectFork(l2.c.forkId);

    skip(_getOutboundRefillTime(amount));
    _refreshGasAndTokenPrices(l2.c);

    vm.prank(user);
    l2.c.token.approve(address(l2.c.router), amount);

    uint256 userBalance = l2.c.token.balanceOf(user);
    uint256 bucketLevel = l2.c.token.getFacilitator(address(l2.newTokenPool)).bucketLevel;

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({
          router: l2.c.router,
          token: l2.c.token,
          amount: amount,
          sourceChainSelector: l2.c.chainSelector,
          destinationChainSelector: l1.c.chainSelector,
          sender: user,
          poolVersion: CCIPUtils.PoolVersion.V1_5_1
        })
      );

    vm.expectEmit(address(l2.newTokenPool));
    emit Burned(address(l2.c.EVM2EVMOnRamp), amount);

    vm.expectEmit(address(l2.c.EVM2EVMOnRamp));
    emit CCIPSendRequested(eventArg);
    vm.prank(user);
    l2.c.router.ccipSend{value: eventArg.feeTokenAmount}(l1.c.chainSelector, message);

    assertEq(l2.c.token.balanceOf(user), userBalance - amount);
    assertEq(l2.c.token.getFacilitator(address(l2.newTokenPool)).bucketLevel, bucketLevel - amount);

    // ETH executeMessage
    vm.selectFork(l1.c.forkId);

    skip(_getInboundRefillTime(amount));
    _refreshGasAndTokenPrices(l1.c);

    uint256 tokenPoolBalance = l1.c.token.balanceOf(address(l1.newTokenPool));
    uint256 bridgedAmount = l1.newTokenPool.getCurrentBridgedAmount();
    userBalance = l1.c.token.balanceOf(user);

    vm.expectEmit(address(l1.newTokenPool));
    emit Released(address(l1.c.EVM2EVMOffRamp), user, amount);
    vm.prank(address(l1.c.EVM2EVMOffRamp));
    l1.c.EVM2EVMOffRamp.executeSingleMessage(
      eventArg,
      new bytes[](message.tokenAmounts.length),
      new uint32[](1) // tokenGasOverrides
    );

    assertEq(l1.c.token.balanceOf(address(l1.newTokenPool)), tokenPoolBalance - amount);
    assertEq(l1.newTokenPool.getCurrentBridgedAmount(), bridgedAmount - amount);
    assertEq(l1.c.token.balanceOf(user), userBalance + amount);
  }
}

contract AaveV3E2E_GHOCCIP151Upgrade_20241209_PostUpgrade is
  AaveV3E2E_GHOCCIP151Upgrade_20241209_Base
{
  function setUp() public override {
    super.setUp();

    _executeUpgradeAIP();

    _validateConfig({upgraded: true});
  }

  function test_E2E_FromEth(uint256 amount) public {
    vm.selectFork(l1.c.forkId);
    uint256 bridgeableAmount = _min(
      l1.newTokenPool.getBridgeLimit() - l1.newTokenPool.getCurrentBridgedAmount(),
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    deal(address(l1.c.token), alice, amount);

    _runEthToArb(alice, amount);
    _runArbToEth(alice, amount);
  }

  function test_E2E_FromArb(uint256 amount) public {
    vm.selectFork(l2.c.forkId);
    uint256 bridgeableAmount = _min(
      l2.c.token.getFacilitator(address(l2.newTokenPool)).bucketLevel,
      CCIP_RATE_LIMIT_CAPACITY
    );

    amount = bound(amount, 1, bridgeableAmount);
    deal(address(l2.c.token), alice, amount);

    _runArbToEth(alice, amount);
    _runEthToArb(alice, amount);
  }
}

// sendMsg => upgrade => executeMsg
contract AaveV3E2E_GHOCCIP151Upgrade_20241209_InFlightUpgrade is
  AaveV3E2E_GHOCCIP151Upgrade_20241209_Base
{
  function test_E2E_InFlightMsg_FromEth() public {
    vm.selectFork(l1.c.forkId);

    uint256 amount = 100_000e18;
    deal(address(l1.c.token), alice, amount);
    skip(_getOutboundRefillTime(amount));

    vm.prank(alice);
    l1.c.token.approve(address(l1.c.router), amount);

    uint256 tokenPoolBalance = l1.c.token.balanceOf(address(l1.existingTokenPool));
    uint256 aliceBalance = l1.c.token.balanceOf(alice);
    uint256 bridgedAmount = l1.existingTokenPool.getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({
          router: l1.c.router,
          token: l1.c.token,
          amount: amount,
          sourceChainSelector: l1.c.chainSelector,
          destinationChainSelector: l2.c.chainSelector,
          sender: alice,
          poolVersion: CCIPUtils.PoolVersion.V1_5_0 // existing token pool
        })
      );

    // message sent from existing token pool, pre-AIP-execution
    vm.expectEmit(address(l1.existingTokenPool));
    emit Locked(l1.c.proxyPool, amount);
    vm.expectEmit(l1.c.proxyPool);
    emit Locked(address(l1.c.EVM2EVMOnRamp), amount);

    vm.expectEmit(address(l1.c.EVM2EVMOnRamp));
    emit CCIPSendRequested(eventArg);
    vm.prank(alice);
    l1.c.router.ccipSend{value: eventArg.feeTokenAmount}(l2.c.chainSelector, message);

    assertEq(l1.c.token.balanceOf(address(l1.existingTokenPool)), tokenPoolBalance + amount);
    assertEq(l1.c.token.balanceOf(alice), aliceBalance - amount);
    assertEq(l1.existingTokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

    _executeUpgradeAIP(); // token pools upgraded

    // ARB executeMessage
    vm.selectFork(l2.c.forkId);

    skip(_getInboundRefillTime(amount));
    aliceBalance = l2.c.token.balanceOf(alice);
    uint256 bucketLevel = l2.c.token.getFacilitator(address(l2.newTokenPool)).bucketLevel;

    vm.expectEmit(address(l2.newTokenPool));
    emit Minted(address(l2.c.EVM2EVMOffRamp), alice, amount);
    vm.prank(address(l2.c.EVM2EVMOffRamp));
    l2.c.EVM2EVMOffRamp.executeSingleMessage(
      eventArg, // pre-upgrade message
      new bytes[](message.tokenAmounts.length),
      new uint32[](0)
    );

    assertEq(l2.c.token.balanceOf(alice), aliceBalance + amount);
    assertEq(l2.c.token.getFacilitator(address(l2.newTokenPool)).bucketLevel, bucketLevel + amount);

    // send tokens back to eth
    _runArbToEth(alice, amount);
  }

  function test_E2E_InFlightMsg_FromArb() public {
    vm.selectFork(l2.c.forkId);

    uint256 amount = 100_000e18;
    deal(address(l2.c.token), alice, amount);
    skip(_getOutboundRefillTime(amount));

    vm.prank(alice);
    l2.c.token.approve(address(l2.c.router), amount);

    uint256 aliceBalance = l2.c.token.balanceOf(alice);
    uint256 bucketLevel = l2.c.token.getFacilitator(address(l2.existingTokenPool)).bucketLevel;

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({
          router: l2.c.router,
          token: l2.c.token,
          amount: amount,
          sourceChainSelector: l2.c.chainSelector,
          destinationChainSelector: l1.c.chainSelector,
          sender: alice,
          poolVersion: CCIPUtils.PoolVersion.V1_5_0 // existing token pool
        })
      );

    // message sent from existing token pool, pre-AIP-execution
    vm.expectEmit(address(l2.existingTokenPool));
    emit Burned(l2.c.proxyPool, amount);
    vm.expectEmit(l2.c.proxyPool);
    emit Burned(address(l2.c.EVM2EVMOnRamp), amount);

    vm.expectEmit(address(l2.c.EVM2EVMOnRamp));
    emit CCIPSendRequested(eventArg);
    vm.prank(alice);
    l2.c.router.ccipSend{value: eventArg.feeTokenAmount}(l1.c.chainSelector, message);

    assertEq(l2.c.token.balanceOf(alice), aliceBalance - amount);
    assertEq(
      l2.c.token.getFacilitator(address(l2.existingTokenPool)).bucketLevel,
      bucketLevel - amount
    );

    _executeUpgradeAIP(); // token pools upgraded

    // ETH executeMessage
    vm.selectFork(l1.c.forkId);

    skip(_getInboundRefillTime(amount));
    uint256 tokenPoolBalance = l1.c.token.balanceOf(address(l1.newTokenPool));
    uint256 bridgedAmount = l1.newTokenPool.getCurrentBridgedAmount();
    aliceBalance = l1.c.token.balanceOf(alice);

    vm.expectEmit(address(l1.newTokenPool));
    emit Released(address(l1.c.EVM2EVMOffRamp), alice, amount);
    vm.prank(address(l1.c.EVM2EVMOffRamp));
    l1.c.EVM2EVMOffRamp.executeSingleMessage(
      eventArg, // pre-upgrade message
      new bytes[](message.tokenAmounts.length),
      new uint32[](1) // tokenGasOverrides
    );

    assertEq(l1.c.token.balanceOf(address(l1.newTokenPool)), tokenPoolBalance - amount);
    assertEq(l1.newTokenPool.getCurrentBridgedAmount(), bridgedAmount - amount);
    assertEq(l1.c.token.balanceOf(alice), aliceBalance + amount);

    // send tokens back to arb
    _runEthToArb(alice, amount);
  }
}
