// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IPool as IPool_CCIP} from 'src/interfaces/ccip/tokenPool/IPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {IEVM2EVMOffRamp_1_5} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOAvalancheLaunch} from './utils/GHOAvalancheLaunch.sol';

import {AaveV3Ethereum_GHOAvalancheLaunch_20250519} from './AaveV3Ethereum_GHOAvalancheLaunch_20250519.sol';

/**
 * @dev Test for AaveV3Base_GHOAvalancheLaunch_20250519
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250519_Multi_GHOAvalancheLaunch/AaveV3Base_GHOAvalancheLaunch_20250519.t.sol -vv
 */
contract AaveV3Ethereum_GHOAvalancheLaunch_20250519_Avalanche is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    uint64 destChainSelector;
  }

  uint64 internal constant ARB_CHAIN_SELECTOR = GHOAvalancheLaunch.ARB_CHAIN_SELECTOR;
  uint64 internal constant AVAX_CHAIN_SELECTOR = GHOAvalancheLaunch.AVAX_CHAIN_SELECTOR;
  uint64 internal constant ETH_CHAIN_SELECTOR = GHOAvalancheLaunch.ETH_CHAIN_SELECTOR;
  uint64 internal constant BASE_CHAIN_SELECTOR = GHOAvalancheLaunch.BASE_CHAIN_SELECTOR;
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOAvalancheLaunch.CCIP_RATE_LIMIT_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOAvalancheLaunch.CCIP_RATE_LIMIT_REFILL_RATE;

  IGhoToken internal constant GHO = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING);
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(GHOAvalancheLaunch.ETH_TOKEN_ADMIN_REGISTRY);
  IEVM2EVMOnRamp internal constant BASE_ON_RAMP =
    IEVM2EVMOnRamp(GHOAvalancheLaunch.ETH_BASE_ON_RAMP);
  IEVM2EVMOnRamp internal constant AVAX_ON_RAMP =
    IEVM2EVMOnRamp(GHOAvalancheLaunch.ETH_AVAX_ON_RAMP);
  IEVM2EVMOffRamp_1_5 internal constant BASE_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.ETH_BASE_OFF_RAMP);
  IEVM2EVMOffRamp_1_5 internal constant AVAX_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.ETH_AVAX_OFF_RAMP);

  address public constant NEW_REMOTE_TOKEN_AVAX = GHOAvalancheLaunch.GHO_TOKEN;
  address internal constant NEW_REMOTE_POOL_ARB = GhoArbitrum.GHO_CCIP_TOKEN_POOL;
  address internal constant NEW_REMOTE_POOL_BASE = GhoBase.GHO_CCIP_TOKEN_POOL;
  address internal constant NEW_REMOTE_POOL_AVAX = GHOAvalancheLaunch.GHO_CCIP_TOKEN_POOL;

  address internal constant RISK_COUNCIL = GHOAvalancheLaunch.RISK_COUNCIL; // common across all chains
  IRouter internal constant ROUTER = IRouter(GHOAvalancheLaunch.ETH_CCIP_ROUTER);
  IGhoCcipSteward internal constant NEW_GHO_CCIP_STEWARD =
    IGhoCcipSteward(GhoEthereum.GHO_CCIP_STEWARD);
  IUpgradeableLockReleaseTokenPool_1_5_1 internal constant NEW_TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_5_1(GhoEthereum.GHO_CCIP_TOKEN_POOL);

  AaveV3Ethereum_GHOAvalancheLaunch_20250519 internal proposal;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Locked(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address);
  error InvalidSourcePoolAddress(bytes);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), GHOAvalancheLaunch.ETH_BLOCK_NUMBER);
    proposal = new AaveV3Ethereum_GHOAvalancheLaunch_20250519();
    _validateConstants();
    executePayload(vm, address(proposal));
  }

  function _validateConstants() private view {
    assertEq(proposal.AVAX_CHAIN_SELECTOR(), AVAX_CHAIN_SELECTOR);
    assertEq(address(proposal.TOKEN_POOL()), address(NEW_TOKEN_POOL));
    assertEq(proposal.REMOTE_TOKEN_POOL_AVAX(), NEW_REMOTE_POOL_AVAX);
    assertEq(proposal.REMOTE_GHO_TOKEN_AVAX(), NEW_REMOTE_TOKEN_AVAX);
    assertEq(proposal.CCIP_RATE_LIMIT_CAPACITY(), CCIP_RATE_LIMIT_CAPACITY);
    assertEq(proposal.CCIP_RATE_LIMIT_REFILL_RATE(), CCIP_RATE_LIMIT_REFILL_RATE);

    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(NEW_TOKEN_POOL.typeAndVersion(), 'LockReleaseTokenPool 1.5.1');
    assertEq(ROUTER.typeAndVersion(), 'Router 1.2.0');

    _assertOnRamp(BASE_ON_RAMP, ETH_CHAIN_SELECTOR, BASE_CHAIN_SELECTOR, ROUTER);
    _assertOnRamp(AVAX_ON_RAMP, ETH_CHAIN_SELECTOR, AVAX_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(BASE_OFF_RAMP, BASE_CHAIN_SELECTOR, ETH_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(AVAX_OFF_RAMP, AVAX_CHAIN_SELECTOR, ETH_CHAIN_SELECTOR, ROUTER);

    assertEq(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN(), AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN_POOL(), address(NEW_TOKEN_POOL));
    assertTrue(NEW_GHO_CCIP_STEWARD.BRIDGE_LIMIT_ENABLED());
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

  function _getTokenMessage(
    CCIPSendParams memory params
  ) internal returns (IClient.EVM2AnyMessage memory, IInternal.EVM2EVMMessage memory) {
    IClient.EVM2AnyMessage memory message = CCIPUtils.generateMessage(params.sender, 1);
    message.tokenAmounts[0] = IClient.EVMTokenAmount({token: address(GHO), amount: params.amount});

    uint256 feeAmount = ROUTER.getFee(params.destChainSelector, message);
    deal(params.sender, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: ROUTER,
        sourceChainSelector: ETH_CHAIN_SELECTOR,
        destChainSelector: params.destChainSelector,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: address(GHO),
        destinationToken: address(
          params.destChainSelector == AVAX_CHAIN_SELECTOR
            ? GHOAvalancheLaunch.GHO_TOKEN
            : AaveV3BaseAssets.GHO_UNDERLYING
        )
      })
    );

    return (message, eventArg);
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

  function _getRateLimiterConfig() internal view returns (IRateLimiter.Config memory) {
    return
      IRateLimiter.Config({
        isEnabled: true,
        capacity: proposal.CCIP_RATE_LIMIT_CAPACITY(),
        rate: proposal.CCIP_RATE_LIMIT_REFILL_RATE()
      });
  }

  function _getOutboundRefillTime(uint256 amount) internal pure returns (uint256) {
    return (amount / CCIP_RATE_LIMIT_REFILL_RATE) + 1; // account for rounding
  }

  function _getInboundRefillTime(uint256 amount) internal pure returns (uint256) {
    return amount / CCIP_RATE_LIMIT_REFILL_RATE + 1; // account for rounding
  }

  function _min(uint256 a, uint256 b) internal pure returns (uint256) {
    return a < b ? a : b;
  }

  function assertEq(
    IRateLimiter.TokenBucket memory bucket,
    IRateLimiter.Config memory config
  ) internal pure {
    assertEq(bucket.isEnabled, config.isEnabled);
    assertEq(bucket.capacity, config.capacity);
    assertEq(bucket.rate, config.rate);
  }

  function test_basePoolConfig() public view {
    assertEq(NEW_TOKEN_POOL.getSupportedChains().length, 3);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[0], ARB_CHAIN_SELECTOR);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[1], BASE_CHAIN_SELECTOR);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[2], AVAX_CHAIN_SELECTOR);
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ARB_CHAIN_SELECTOR),
      abi.encode(address(AaveV3ArbitrumAssets.GHO_UNDERLYING))
    );
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(BASE_CHAIN_SELECTOR),
      abi.encode(address(AaveV3BaseAssets.GHO_UNDERLYING))
    );
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(AVAX_CHAIN_SELECTOR),
      abi.encode(address(NEW_REMOTE_TOKEN_AVAX))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(AVAX_CHAIN_SELECTOR).length, 1);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(AVAX_CHAIN_SELECTOR)[0],
      abi.encode(address(NEW_REMOTE_POOL_AVAX))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(ARB_CHAIN_SELECTOR).length, 2);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(ARB_CHAIN_SELECTOR)[1], // 0th is the 1.4 token pool
      abi.encode(address(NEW_REMOTE_POOL_ARB))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(BASE_CHAIN_SELECTOR).length, 1);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(BASE_CHAIN_SELECTOR)[0],
      abi.encode(address(NEW_REMOTE_POOL_BASE))
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(AVAX_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(AVAX_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
  }

  function test_sendMessageToAvaxSucceeds(uint256 amount) public {
    uint256 bridgeableAmount = _min(
      NEW_TOKEN_POOL.getBridgeLimit() - NEW_TOKEN_POOL.getCurrentBridgedAmount(),
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(GHO), alice, amount);
    vm.prank(alice);
    GHO.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 currentBridgedAmount = NEW_TOKEN_POOL.getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: AVAX_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Locked(address(AVAX_ON_RAMP), amount);
    vm.expectEmit(address(AVAX_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(AVAX_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount + amount);
  }

  function test_sendMessageToBaseSucceeds(uint256 amount) public {
    IRateLimiter.TokenBucket memory baseRateLimits = NEW_TOKEN_POOL
      .getCurrentInboundRateLimiterState(BASE_CHAIN_SELECTOR);
    uint256 bridgeableAmount = _min(
      NEW_TOKEN_POOL.getBridgeLimit() - NEW_TOKEN_POOL.getCurrentBridgedAmount(),
      baseRateLimits.capacity
    );

    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(GHO), alice, amount);
    vm.prank(alice);
    GHO.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 currentBridgedAmount = NEW_TOKEN_POOL.getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: BASE_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Locked(address(BASE_ON_RAMP), amount);
    vm.expectEmit(address(BASE_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(BASE_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount + amount);
  }

  function test_offRampViaAvaxSucceeds(uint256 amount) public {
    uint256 bridgeableAmount = _min(
      NEW_TOKEN_POOL.getCurrentBridgedAmount(),
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 poolBalance = GHO.balanceOf(address(NEW_TOKEN_POOL));
    uint256 currentBridgedAmount = NEW_TOKEN_POOL.getCurrentBridgedAmount();

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Released(address(AVAX_OFF_RAMP), alice, amount);

    vm.prank(address(AVAX_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: AVAX_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_AVAX)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), poolBalance - amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), GHO.balanceOf(address(NEW_TOKEN_POOL)));
  }

  function test_offRampViaBaseSucceeds(uint256 amount) public {
    uint256 bridgeableAmount = _min(
      NEW_TOKEN_POOL.getCurrentBridgedAmount(),
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 poolBalance = GHO.balanceOf(address(NEW_TOKEN_POOL));
    uint256 currentBridgedAmount = NEW_TOKEN_POOL.getCurrentBridgedAmount();

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Released(address(BASE_OFF_RAMP), alice, amount);

    vm.prank(address(BASE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: BASE_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_BASE)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), poolBalance - amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), GHO.balanceOf(address(NEW_TOKEN_POOL)));
  }

  function test_cannotUseAvaxOffRampForBaseMessages() public {
    uint256 amount = 100e18;
    skip(_getInboundRefillTime(amount));

    vm.expectRevert(
      abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, address(AVAX_OFF_RAMP))
    );
    vm.prank(address(AVAX_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: BASE_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_BASE)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }

  function test_cannotOffRampOtherChainMessages() public {
    uint256 amount = 100e18;
    skip(_getInboundRefillTime(amount));

    vm.expectRevert(
      abi.encodeWithSelector(
        InvalidSourcePoolAddress.selector,
        abi.encode(address(NEW_REMOTE_POOL_BASE))
      )
    );
    vm.prank(address(AVAX_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: AVAX_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_BASE)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    vm.expectRevert(
      abi.encodeWithSelector(
        InvalidSourcePoolAddress.selector,
        abi.encode(address(NEW_REMOTE_POOL_AVAX))
      )
    );
    vm.prank(address(BASE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: BASE_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_AVAX)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }
}
