// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {ITypeAndVersion} from 'src/interfaces/ccip/ITypeAndVersion.sol';
import {IProxyPool} from 'src/interfaces/ccip/IProxyPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IEVM2EVMOffRamp_1_2, IEVM2EVMOffRamp_1_5} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IUpgradeableBurnMintTokenPool} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';
import {AaveV3Ethereum_GHOCCIP150Upgrade_20241021} from './AaveV3Ethereum_GHOCCIP150Upgrade_20241021.sol';
import {AaveV3Arbitrum_GHOCCIP150Upgrade_20241021} from './AaveV3Arbitrum_GHOCCIP150Upgrade_20241021.sol';

/**
 * @dev Test for AaveV3E2E_GHOCCIP150Upgrade_20241021
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241021_Multi_GHOCCIP150Upgrade/AaveV3E2E_GHOCCIP150Upgrade_20241021.t.sol -vv
 */
contract AaveV3E2E_GHOCCIP150Upgrade_20241021_Base is ProtocolV3TestBase {
  struct CCIPSendParams {
    IRouter router;
    IERC20 token;
    uint256 amount;
    uint64 sourceChainSelector;
    uint64 destinationChainSelector;
    address sender;
    bool migrated;
  }

  struct Common {
    IRouter router;
    IERC20 token;
    IEVM2EVMOnRamp EVM2EVMOnRamp1_2;
    IEVM2EVMOnRamp EVM2EVMOnRamp1_5;
    IEVM2EVMOffRamp_1_2 EVM2EVMOffRamp1_2;
    IEVM2EVMOffRamp_1_5 EVM2EVMOffRamp1_5;
    ITokenAdminRegistry tokenAdminRegistry;
    IProxyPool proxyPool;
    uint64 chainSelector;
    uint256 forkId;
  }

  struct L1 {
    AaveV3Ethereum_GHOCCIP150Upgrade_20241021 proposal;
    IUpgradeableLockReleaseTokenPool tokenPool;
    IRateLimiter.Config rateLimitConfig;
    Common c;
  }

  struct L2 {
    AaveV3Arbitrum_GHOCCIP150Upgrade_20241021 proposal;
    IUpgradeableBurnMintTokenPool tokenPool;
    IRateLimiter.Config rateLimitConfig;
    Common c;
  }

  L1 internal l1;
  L2 internal l2;
  address internal alice = makeAddr('alice');

  event CCIPSendRequested(IInternal.EVM2EVMMessage message);
  event Locked(address indexed sender, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);

  error CallerIsNotARampOnRouter(address caller);
  error NotACompatiblePool(address pool);

  function setUp() public virtual {
    l1.c.forkId = vm.createFork(vm.rpcUrl('mainnet'), 21131872);
    l2.c.forkId = vm.createFork(vm.rpcUrl('arbitrum'), 271788784);

    vm.selectFork(l1.c.forkId);
    l1.proposal = new AaveV3Ethereum_GHOCCIP150Upgrade_20241021();
    l1.c.proxyPool = IProxyPool(l1.proposal.GHO_CCIP_PROXY_POOL());
    l1.tokenPool = IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL);
    l1.rateLimitConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: l1.proposal.CCIP_RATE_LIMIT_CAPACITY(),
      rate: l1.proposal.CCIP_RATE_LIMIT_REFILL_RATE()
    });
    l1.c.router = IRouter(l1.tokenPool.getRouter());
    l2.c.chainSelector = l1.tokenPool.getSupportedChains()[0];
    l1.c.token = IERC20(address(l1.tokenPool.getToken()));
    l1.c.EVM2EVMOnRamp1_2 = IEVM2EVMOnRamp(l1.c.router.getOnRamp(l2.c.chainSelector));
    l1.c.EVM2EVMOnRamp1_5 = IEVM2EVMOnRamp(0x69eCC4E2D8ea56E2d0a05bF57f4Fd6aEE7f2c284); // new onramp
    l1.c.EVM2EVMOffRamp1_2 = IEVM2EVMOffRamp_1_2(0xeFC4a18af59398FF23bfe7325F2401aD44286F4d);
    l1.c.EVM2EVMOffRamp1_5 = IEVM2EVMOffRamp_1_5(0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9); // new offramp
    l1.c.tokenAdminRegistry = ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);

    vm.selectFork(l2.c.forkId);
    l2.proposal = new AaveV3Arbitrum_GHOCCIP150Upgrade_20241021();
    l2.c.proxyPool = IProxyPool(l2.proposal.GHO_CCIP_PROXY_POOL());
    l2.tokenPool = IUpgradeableBurnMintTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
    l2.rateLimitConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: l2.proposal.CCIP_RATE_LIMIT_CAPACITY(),
      rate: l2.proposal.CCIP_RATE_LIMIT_REFILL_RATE()
    });
    l2.c.router = IRouter(l2.tokenPool.getRouter());
    l1.c.chainSelector = l2.tokenPool.getSupportedChains()[0];
    l2.c.token = IERC20(address(l2.tokenPool.getToken()));
    l2.c.EVM2EVMOnRamp1_2 = IEVM2EVMOnRamp(l2.c.router.getOnRamp(l1.c.chainSelector));
    l2.c.EVM2EVMOnRamp1_5 = IEVM2EVMOnRamp(0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3); // new onramp
    l2.c.EVM2EVMOffRamp1_2 = IEVM2EVMOffRamp_1_2(0x542ba1902044069330e8c5b36A84EC503863722f);
    l2.c.EVM2EVMOffRamp1_5 = IEVM2EVMOffRamp_1_5(0x91e46cc5590A4B9182e47f40006140A7077Dec31); // new offramp
    l2.c.tokenAdminRegistry = ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);

    _validateConfig({migrated: false});
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
        destinationToken: address(params.token == l1.c.token ? l2.c.token : l1.c.token),
        migrated: params.migrated
      })
    );

    return (message, eventArg);
  }

  function _validateConfig(bool migrated) internal {
    vm.selectFork(l1.c.forkId);
    assertEq(l1.c.chainSelector, 5009297550715157269);
    assertEq(address(l1.c.token), MiscEthereum.GHO_TOKEN);
    assertEq(ITypeAndVersion(address(l1.c.router)).typeAndVersion(), 'Router 1.2.0');
    assertEq(
      ITypeAndVersion(address(l1.c.EVM2EVMOnRamp1_2)).typeAndVersion(),
      'EVM2EVMOnRamp 1.2.0'
    );
    assertEq(
      ITypeAndVersion(address(l1.c.EVM2EVMOnRamp1_5)).typeAndVersion(),
      'EVM2EVMOnRamp 1.5.0'
    );
    assertEq(
      ITypeAndVersion(address(l1.c.EVM2EVMOffRamp1_2)).typeAndVersion(),
      'EVM2EVMOffRamp 1.2.0'
    );
    assertEq(
      ITypeAndVersion(address(l1.c.EVM2EVMOffRamp1_5)).typeAndVersion(),
      'EVM2EVMOffRamp 1.5.0'
    );
    assertEq(l1.c.proxyPool.typeAndVersion(), 'LockReleaseTokenPoolAndProxy 1.5.0');
    assertEq(l1.tokenPool.typeAndVersion(), 'LockReleaseTokenPool 1.4.0');
    assertEq(l1.c.tokenAdminRegistry.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertTrue(l1.c.router.isOffRamp(l2.c.chainSelector, address(l1.c.EVM2EVMOffRamp1_2)));
    assertTrue(l1.c.router.isOffRamp(l2.c.chainSelector, address(l1.c.EVM2EVMOffRamp1_5)));

    // ensure only 1.2 & 1.5 offRamps are configured
    IRouter.OffRamp[] memory offRamps = l1.c.router.getOffRamps();
    for (uint256 i; i < offRamps.length; ++i) {
      if (offRamps[i].sourceChainSelector == l2.c.chainSelector) {
        assertTrue(
          offRamps[i].offRamp == address(l1.c.EVM2EVMOffRamp1_2) ||
            offRamps[i].offRamp == address(l1.c.EVM2EVMOffRamp1_5)
        );
      }
    }

    if (migrated) {
      assertEq(l1.c.router.getOnRamp(l2.c.chainSelector), address(l1.c.EVM2EVMOnRamp1_5));
    } else {
      assertEq(l1.c.router.getOnRamp(l2.c.chainSelector), address(l1.c.EVM2EVMOnRamp1_2));
    }

    vm.selectFork(l2.c.forkId);
    assertEq(l2.c.chainSelector, 4949039107694359620);
    assertEq(address(l2.c.token), 0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33);
    assertEq(ITypeAndVersion(address(l2.c.router)).typeAndVersion(), 'Router 1.2.0');
    assertEq(
      ITypeAndVersion(address(l2.c.EVM2EVMOnRamp1_2)).typeAndVersion(),
      'EVM2EVMOnRamp 1.2.0'
    );
    assertEq(
      ITypeAndVersion(address(l2.c.EVM2EVMOnRamp1_5)).typeAndVersion(),
      'EVM2EVMOnRamp 1.5.0'
    );
    assertEq(
      ITypeAndVersion(address(l2.c.EVM2EVMOffRamp1_2)).typeAndVersion(),
      'EVM2EVMOffRamp 1.2.0'
    );
    assertEq(
      ITypeAndVersion(address(l2.c.EVM2EVMOffRamp1_5)).typeAndVersion(),
      'EVM2EVMOffRamp 1.5.0'
    );
    assertEq(l2.c.proxyPool.typeAndVersion(), 'BurnMintTokenPoolAndProxy 1.5.0');
    assertEq(l2.tokenPool.typeAndVersion(), 'BurnMintTokenPool 1.4.0');
    assertEq(l2.c.tokenAdminRegistry.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertTrue(l2.c.router.isOffRamp(l1.c.chainSelector, address(l2.c.EVM2EVMOffRamp1_2)));
    assertTrue(l2.c.router.isOffRamp(l1.c.chainSelector, address(l2.c.EVM2EVMOffRamp1_5)));

    // ensure only 1.2 & 1.5 offRamps are configured
    offRamps = l2.c.router.getOffRamps();
    for (uint256 i; i < offRamps.length; ++i) {
      if (offRamps[i].sourceChainSelector == l1.c.chainSelector) {
        assertTrue(
          offRamps[i].offRamp == address(l2.c.EVM2EVMOffRamp1_2) ||
            offRamps[i].offRamp == address(l2.c.EVM2EVMOffRamp1_5)
        );
      }
    }

    if (migrated) {
      assertEq(l2.c.router.getOnRamp(l1.c.chainSelector), address(l2.c.EVM2EVMOnRamp1_5));
    } else {
      assertEq(l2.c.router.getOnRamp(l1.c.chainSelector), address(l2.c.EVM2EVMOnRamp1_2));
    }
  }

  function _mockCCIPMigration(Common memory src, Common memory dest) internal {
    vm.selectFork(src.forkId);
    assertEq(src.tokenAdminRegistry.getPool(address(src.token)), address(src.proxyPool));
    assertEq(src.proxyPool.getRouter(), address(src.router));
    assertTrue(src.proxyPool.isSupportedChain(dest.chainSelector));
    assertEq(
      src.proxyPool.getCurrentInboundRateLimiterState(dest.chainSelector),
      _getDisabledConfig()
    );
    assertEq(
      src.proxyPool.getCurrentOutboundRateLimiterState(dest.chainSelector),
      _getDisabledConfig()
    );
    assertEq(src.proxyPool.getRemotePool(dest.chainSelector), abi.encode(dest.proxyPool));
    assertEq(src.proxyPool.getRemoteToken(dest.chainSelector), abi.encode(dest.token));

    IRouter.OnRamp[] memory onRampUpdates = new IRouter.OnRamp[](1);
    onRampUpdates[0] = IRouter.OnRamp({
      destChainSelector: dest.chainSelector,
      onRamp: address(src.EVM2EVMOnRamp1_5) // new onRamp
    });
    IRouter.OffRamp[] memory offRampUpdates = new IRouter.OffRamp[](1);
    offRampUpdates[0] = IRouter.OffRamp({
      sourceChainSelector: dest.chainSelector,
      offRamp: address(src.EVM2EVMOffRamp1_5) // new offRamp
    });

    vm.prank(src.router.owner());
    src.router.applyRampUpdates(onRampUpdates, new IRouter.OffRamp[](0), offRampUpdates);
  }

  function _getDisabledConfig() private pure returns (IRateLimiter.Config memory) {
    return IRateLimiter.Config({isEnabled: false, capacity: 0, rate: 0});
  }

  function _tokenBucketToConfig(
    IRateLimiter.TokenBucket memory bucket
  ) private pure returns (IRateLimiter.Config memory) {
    return
      IRateLimiter.Config({
        isEnabled: bucket.isEnabled,
        capacity: bucket.capacity,
        rate: bucket.rate
      });
  }

  function assertEq(
    IRateLimiter.TokenBucket memory bucket,
    IRateLimiter.Config memory config
  ) internal pure {
    assertEq(abi.encode(_tokenBucketToConfig(bucket)), abi.encode(config));
  }
}

contract AaveV3E2E_GHOCCIP150Upgrade_20241021_PreCCIPMigration is
  AaveV3E2E_GHOCCIP150Upgrade_20241021_Base
{
  function setUp() public override {
    super.setUp();

    vm.selectFork(l1.c.forkId);
    executePayload(vm, address(l1.proposal));
    vm.selectFork(l2.c.forkId);
    executePayload(vm, address(l2.proposal));

    _validateConfig({migrated: false});
  }

  function test_E2E() public {
    uint256 amount = l1.rateLimitConfig.capacity;
    // ETH (=> ARB) sendMessage
    {
      vm.selectFork(l1.c.forkId);
      deal(address(l1.c.token), alice, amount, true);
      vm.prank(alice);
      l1.c.token.approve(address(l1.c.router), amount);

      uint128 outBoundRate = l1.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(outBoundRate) + 1); // rate is non zero

      uint256 tokenPoolBalance = l1.c.token.balanceOf(address(l1.tokenPool));
      uint256 bridgedAmount = l1.tokenPool.getCurrentBridgedAmount();

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
            migrated: false
          })
        );

      vm.expectEmit(address(l1.tokenPool));
      emit Locked(address(l1.c.EVM2EVMOnRamp1_2), amount);
      vm.expectEmit(address(l1.c.EVM2EVMOnRamp1_2));
      emit CCIPSendRequested(eventArg);
      vm.prank(alice);
      l1.c.router.ccipSend{value: eventArg.feeTokenAmount}(l2.c.chainSelector, message);

      assertEq(l1.c.token.balanceOf(address(l1.tokenPool)), tokenPoolBalance + amount);
      assertEq(l1.tokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

      // ARB executeMessage
      vm.selectFork(l2.c.forkId);

      uint256 aliceBalanceBefore = l2.c.token.balanceOf(alice);

      uint128 inBoundRate = l2.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

      vm.expectEmit(address(l2.tokenPool));
      emit Minted(address(l2.c.EVM2EVMOffRamp1_2), alice, amount);
      vm.prank(address(l2.c.EVM2EVMOffRamp1_2));
      l2.c.EVM2EVMOffRamp1_2.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length)
      );

      assertEq(l2.c.token.balanceOf(alice), aliceBalanceBefore + amount);
    }

    // ARB (=> ETH) sendMessage
    {
      vm.selectFork(l2.c.forkId);

      vm.prank(alice);
      l2.c.token.approve(address(l2.c.router), amount);
      uint128 outBoundRate = l2.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(outBoundRate) + 1); // rate is non zero

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
            migrated: false
          })
        );

      vm.expectEmit(address(l2.tokenPool));
      emit Burned(address(l2.c.EVM2EVMOnRamp1_2), amount);
      vm.expectEmit(address(l2.c.EVM2EVMOnRamp1_2));
      emit CCIPSendRequested(eventArg);
      vm.prank(alice);
      l2.c.router.ccipSend{value: eventArg.feeTokenAmount}(l1.c.chainSelector, message);

      assertEq(l2.c.token.balanceOf(alice), 0);

      // ETH executeMessage
      vm.selectFork(l1.c.forkId);

      uint256 tokenPoolBalanceBefore = l1.c.token.balanceOf(address(l1.tokenPool));

      uint128 inBoundRate = l1.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

      vm.expectEmit(address(l1.tokenPool));
      emit Released(address(l1.c.EVM2EVMOffRamp1_2), alice, amount);
      vm.prank(address(l1.c.EVM2EVMOffRamp1_2));
      l1.c.EVM2EVMOffRamp1_2.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length)
      );

      assertEq(l1.c.token.balanceOf(address(l1.tokenPool)), tokenPoolBalanceBefore - amount);
      assertEq(l1.c.token.balanceOf(alice), amount);
    }
  }
}

contract AaveV3E2E_GHOCCIP150Upgrade_20241021_PostCCIPMigration is
  AaveV3E2E_GHOCCIP150Upgrade_20241021_Base
{
  function setUp() public override {
    super.setUp();

    // execute proposal
    vm.selectFork(l1.c.forkId);
    executePayload(vm, address(l1.proposal));
    vm.selectFork(l2.c.forkId);
    executePayload(vm, address(l2.proposal));

    _mockCCIPMigration(l1.c, l2.c);
    _mockCCIPMigration(l2.c, l1.c);

    _validateConfig({migrated: true});
  }

  function test_E2E() public {
    uint256 amount = l1.rateLimitConfig.capacity;
    // ETH (=> ARB) sendMessage
    {
      vm.selectFork(l1.c.forkId);
      deal(address(l1.c.token), alice, amount, true);
      vm.prank(alice);
      l1.c.token.approve(address(l1.c.router), amount);

      uint128 outBoundRate = l1.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(outBoundRate) + 1); // rate is non zero

      uint256 tokenPoolBalance = l1.c.token.balanceOf(address(l1.tokenPool));
      uint256 bridgedAmount = l1.tokenPool.getCurrentBridgedAmount();

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
            migrated: true
          })
        );

      /// expected flow: router => onRamp => proxyPool => tokenPool
      vm.expectEmit(address(l1.tokenPool));
      emit Locked(address(l1.c.proxyPool), amount);

      vm.expectEmit(address(l1.c.proxyPool));
      emit Locked(address(l1.c.EVM2EVMOnRamp1_5), amount);

      vm.expectEmit(address(l1.c.EVM2EVMOnRamp1_5)); // @dev caller is now 1.5 onRamp
      emit CCIPSendRequested(eventArg);
      vm.prank(alice);
      l1.c.router.ccipSend{value: eventArg.feeTokenAmount}(l2.c.chainSelector, message);

      assertEq(l1.c.token.balanceOf(address(l1.tokenPool)), tokenPoolBalance + amount);
      assertEq(l1.tokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

      // ARB executeMessage
      vm.selectFork(l2.c.forkId);

      uint128 inBoundRate = l2.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

      vm.expectEmit(address(l2.tokenPool));
      emit Minted(address(l2.c.EVM2EVMOffRamp1_2), alice, amount);
      vm.prank(address(l2.c.EVM2EVMOffRamp1_2));
      l2.c.EVM2EVMOffRamp1_2.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length)
      );

      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

      vm.expectEmit(address(l2.c.proxyPool)); // emitter is proxyPool for 1.5 on ramp
      emit Minted(address(l2.c.EVM2EVMOffRamp1_5), alice, amount);
      vm.prank(address(l2.c.EVM2EVMOffRamp1_5));
      l2.c.EVM2EVMOffRamp1_5.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length),
        new uint32[](1) // tokenGasOverrides
      );
    }

    // ARB (=> ETH) sendMessage
    {
      vm.selectFork(l2.c.forkId);

      vm.prank(alice);
      l2.c.token.approve(address(l2.c.router), amount);
      uint128 outBoundRate = l2.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(outBoundRate) + 1); // rate is non zero

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
            migrated: true
          })
        );

      /// expected flow: router => onRamp => proxyPool => tokenPool
      vm.expectEmit(address(l2.tokenPool));
      emit Burned(address(l2.c.proxyPool), amount); // @dev caller is now 1.5 onRamp

      vm.expectEmit(address(l2.c.proxyPool));
      emit Burned(address(l2.c.EVM2EVMOnRamp1_5), amount); // @dev caller is now 1.5 onRamp

      vm.expectEmit(address(l2.c.EVM2EVMOnRamp1_5));
      emit CCIPSendRequested(eventArg);
      vm.prank(alice);
      l2.c.router.ccipSend{value: eventArg.feeTokenAmount}(l1.c.chainSelector, message);

      // ETH executeMessage
      vm.selectFork(l1.c.forkId);

      uint256 tokenPoolBalanceBefore = l1.c.token.balanceOf(address(l1.tokenPool));

      uint128 inBoundRate = l1.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

      vm.expectEmit(address(l1.c.proxyPool)); // emitter is proxyPool for 1.5 off ramp
      emit Released(address(l1.c.EVM2EVMOffRamp1_5), alice, amount);
      vm.prank(address(l1.c.EVM2EVMOffRamp1_5));
      l1.c.EVM2EVMOffRamp1_5.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length),
        new uint32[](1) // tokenGasOverrides
      );

      assertEq(l1.c.token.balanceOf(address(l1.tokenPool)), tokenPoolBalanceBefore - amount);
      assertEq(l1.c.token.balanceOf(alice), amount);
    }
  }

  function test_SendRevertsWithoutUpgrade() public {
    {
      vm.selectFork(l1.c.forkId);
      uint256 amount = l1.rateLimitConfig.capacity;
      deal(address(l1.c.token), alice, amount, true);
      vm.prank(alice);
      l1.c.token.approve(address(l1.c.router), amount);
      uint128 rate = l1.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(rate) + 1); // rate is non zero

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
            migrated: true
          })
        );

      // mock undo upgrade by setting proxy pool to random address
      vm.prank(l1.tokenPool.owner());
      l1.tokenPool.setProxyPool(address(1337));

      vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, l1.c.proxyPool));
      vm.prank(alice);
      l1.c.router.ccipSend{value: eventArg.feeTokenAmount}(l2.c.chainSelector, message);
    }

    {
      vm.selectFork(l2.c.forkId);
      uint256 amount = l1.rateLimitConfig.capacity;
      deal(address(l2.c.token), alice, amount, true);
      vm.prank(alice);
      l2.c.token.approve(address(l2.c.router), amount);
      uint128 rate = l2.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(rate) + 1); // rate is non zero

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
            migrated: true
          })
        );

      // mock undo upgrade by setting proxy pool to random address
      vm.prank(l2.tokenPool.owner());
      l2.tokenPool.setProxyPool(address(1337));

      vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, l2.c.proxyPool));
      vm.prank(alice);
      l2.c.router.ccipSend{value: eventArg.feeTokenAmount}(l1.c.chainSelector, message);
    }
  }

  function test_ExecuteRevertsWithoutUpgrade() public {
    {
      vm.selectFork(l1.c.forkId);
      uint256 amount = l1.rateLimitConfig.capacity;
      deal(address(l1.c.token), alice, amount, true);
      vm.prank(alice);
      l1.c.token.approve(address(l1.c.router), amount);

      uint128 inBoundRate = l1.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

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
            migrated: true
          })
        );

      // mock undo upgrade by setting proxy pool to random address
      vm.prank(l1.tokenPool.owner());
      l1.tokenPool.setProxyPool(address(1337));

      vm.expectRevert(abi.encodeWithSelector(NotACompatiblePool.selector, address(0)));
      vm.prank(address(l1.c.EVM2EVMOffRamp1_5));
      l1.c.EVM2EVMOffRamp1_5.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length),
        new uint32[](1) // tokenGasOverrides
      );
    }

    {
      vm.selectFork(l2.c.forkId);
      uint256 amount = l1.rateLimitConfig.capacity;
      deal(address(l2.c.token), alice, amount, true);
      vm.prank(alice);
      l2.c.token.approve(address(l2.c.router), amount);

      uint128 inBoundRate = l2.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

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
            migrated: true
          })
        );

      // mock undo upgrade by setting proxy pool to random address
      vm.prank(l2.tokenPool.owner());
      l2.tokenPool.setProxyPool(address(1337));

      vm.expectRevert(abi.encodeWithSelector(NotACompatiblePool.selector, address(0)));
      vm.prank(address(l2.c.EVM2EVMOffRamp1_5));
      l2.c.EVM2EVMOffRamp1_5.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length),
        new uint32[](1) // tokenGasOverrides
      );
    }
  }
}

// sendMsg => CCIP Migration => executeMsg
contract AaveV3E2E_GHOCCIP150Upgrade_20241021_InFlightCCIPMigration is
  AaveV3E2E_GHOCCIP150Upgrade_20241021_Base
{
  function setUp() public override {
    super.setUp();

    // execute proposal
    vm.selectFork(l1.c.forkId);
    executePayload(vm, address(l1.proposal));
    vm.selectFork(l2.c.forkId);
    executePayload(vm, address(l2.proposal));

    _validateConfig({migrated: false});
  }

  function test_SendFlowInFlightCCIPMigrationFromEth() public {
    // ETH => ARB, ccipSend 1.4; CCIP migration, Destination executeMessage
    {
      vm.selectFork(l1.c.forkId);
      uint256 amount = l1.rateLimitConfig.capacity;
      deal(address(l1.c.token), alice, amount, true);
      vm.prank(alice);
      l1.c.token.approve(address(l1.c.router), amount);
      uint128 rate = l1.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(rate) + 1); // rate is non zero

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
            migrated: false
          })
        );

      vm.expectEmit(address(l1.tokenPool));
      emit Locked(address(l1.c.EVM2EVMOnRamp1_2), amount);
      vm.expectEmit(address(l1.c.EVM2EVMOnRamp1_2));
      emit CCIPSendRequested(eventArg);
      vm.prank(alice);
      l1.c.router.ccipSend{value: eventArg.feeTokenAmount}(l2.c.chainSelector, message);

      assertEq(l1.c.token.balanceOf(alice), 0);

      // CCIP Migration
      _mockCCIPMigration(l1.c, l2.c);
      _mockCCIPMigration(l2.c, l1.c);

      vm.selectFork(l2.c.forkId);

      uint128 inBoundRate = l2.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

      // reverts with 1.5 off ramp because eventArg is in CCIP 1.4 message format
      vm.expectRevert();
      vm.prank(address(l2.c.EVM2EVMOffRamp1_5));
      l2.c.EVM2EVMOffRamp1_5.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length),
        new uint32[](0) // tokenGasOverrides
      );

      // system can use legacy 1.2 off ramp after migration
      vm.expectEmit(address(l2.tokenPool));
      emit Minted(address(l2.c.EVM2EVMOffRamp1_2), alice, amount);
      vm.prank(address(l2.c.EVM2EVMOffRamp1_2));
      l2.c.EVM2EVMOffRamp1_2.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length)
      );
    }
  }

  function test_SendFlowInFlightCCIPMigrationFromArb() public {
    // ARB => ETH, ccipSend 1.4; CCIP migration, Destination executeMessage
    {
      vm.selectFork(l2.c.forkId);
      uint256 amount = l1.rateLimitConfig.capacity;
      deal(address(l2.c.token), alice, amount, true);
      vm.prank(alice);
      l2.c.token.approve(address(l2.c.router), amount);
      uint128 outBoundRate = l2.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(outBoundRate) + 1); // rate is non zero

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
            migrated: false
          })
        );

      vm.expectEmit(address(l2.tokenPool));
      emit Burned(address(l2.c.EVM2EVMOnRamp1_2), amount);
      vm.expectEmit(address(l2.c.EVM2EVMOnRamp1_2));
      emit CCIPSendRequested(eventArg);
      vm.prank(alice);
      l2.c.router.ccipSend{value: eventArg.feeTokenAmount}(l1.c.chainSelector, message);

      assertEq(l2.c.token.balanceOf(alice), 0);

      // CCIP Migration
      _mockCCIPMigration(l1.c, l2.c);
      _mockCCIPMigration(l2.c, l1.c);

      vm.selectFork(l1.c.forkId);

      uint128 inBoundRate = l1.rateLimitConfig.rate;
      // wait for the rate limiter to refill
      skip(amount / uint256(inBoundRate) + 1); // rate is non zero

      // reverts with 1.5 off ramp
      vm.expectRevert();
      vm.prank(address(l1.c.EVM2EVMOffRamp1_5));
      l1.c.EVM2EVMOffRamp1_5.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length),
        new uint32[](0) // tokenGasOverrides
      );

      // system can use legacy 1.2 off ramp after migration
      vm.expectEmit(address(l1.tokenPool));
      emit Released(address(l1.c.EVM2EVMOffRamp1_2), alice, amount);
      vm.prank(address(l1.c.EVM2EVMOffRamp1_2));
      l1.c.EVM2EVMOffRamp1_2.executeSingleMessage(
        eventArg,
        new bytes[](message.tokenAmounts.length)
      );
    }
  }
}
