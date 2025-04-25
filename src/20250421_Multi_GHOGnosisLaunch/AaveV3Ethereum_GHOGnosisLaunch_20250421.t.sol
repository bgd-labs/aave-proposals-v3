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
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';

import {AaveV3Ethereum_GHOGnosisLaunch_20250421} from './AaveV3Ethereum_GHOGnosisLaunch_20250421.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOGnosisLaunch_20250421
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250421_Multi_GHOGnosisLaunch/AaveV3Ethereum_GHOGnosisLaunch_20250421.t.sol -vv
 */
contract AaveV3Ethereum_GHOGnosisLaunch_20250421_Test is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    uint64 destChainSelector;
  }

  uint64 internal constant ARB_CHAIN_SELECTOR = CCIPUtils.ARB_CHAIN_SELECTOR;
  uint64 internal constant GNOSIS_CHAIN_SELECTOR = CCIPUtils.GNOSIS_CHAIN_SELECTOR;
  uint64 internal constant ETH_CHAIN_SELECTOR = CCIPUtils.ETH_CHAIN_SELECTOR;
  uint256 internal constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  uint256 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  IGhoToken internal constant GHO = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING);
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);
  IEVM2EVMOnRamp internal constant ARB_ON_RAMP =
    IEVM2EVMOnRamp(0x69eCC4E2D8ea56E2d0a05bF57f4Fd6aEE7f2c284);
  IEVM2EVMOnRamp internal constant BASE_ON_RAMP =
    IEVM2EVMOnRamp(0xb8a882f3B88bd52D1Ff56A873bfDB84b70431937);
  IEVM2EVMOffRamp_1_5 internal constant ARB_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9);
  IEVM2EVMOffRamp_1_5 internal constant BASE_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0x6B4B6359Dd5B47Cdb030E5921456D2a0625a9EbD);

  address public constant NEW_REMOTE_TOKEN_GNOSIS = 0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee;
  address internal constant NEW_REMOTE_POOL_ARB = 0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB;
  address internal constant NEW_REMOTE_POOL_GNOSIS = 0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34;
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60; // common across all chains
  IRouter internal constant ROUTER = IRouter(0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D);
  IGhoCcipSteward internal constant NEW_GHO_CCIP_STEWARD =
    IGhoCcipSteward(0xC5BcC58BE6172769ca1a78B8A45752E3C5059c39);
  IUpgradeableLockReleaseTokenPool_1_5_1 internal constant NEW_TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_5_1(0x06179f7C1be40863405f374E7f5F8806c728660A);

  AaveV3Ethereum_GHOGnosisLaunch_20250421 internal proposal;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Locked(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address);
  error InvalidSourcePoolAddress(bytes);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21722753);
    proposal = new AaveV3Ethereum_GHOGnosisLaunch_20250421();
    _validateConstants();
    executePayload(vm, address(proposal));
  }

  function _validateConstants() private view {
    assertEq(proposal.GNOSIS_CHAIN_SELECTOR(), GNOSIS_CHAIN_SELECTOR);
    assertEq(address(proposal.TOKEN_POOL()), address(NEW_TOKEN_POOL));
    assertEq(proposal.REMOTE_TOKEN_POOL_GNOSIS(), NEW_REMOTE_POOL_GNOSIS);
    assertEq(proposal.REMOTE_GHO_TOKEN_GNOSIS(), NEW_REMOTE_TOKEN_GNOSIS);
    assertEq(proposal.CCIP_RATE_LIMIT_CAPACITY(), CCIP_RATE_LIMIT_CAPACITY);
    assertEq(proposal.CCIP_RATE_LIMIT_REFILL_RATE(), CCIP_RATE_LIMIT_REFILL_RATE);

    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(NEW_TOKEN_POOL.typeAndVersion(), 'LockReleaseTokenPool 1.5.1');
    assertEq(ROUTER.typeAndVersion(), 'Router 1.2.0');

    _assertOnRamp(ARB_ON_RAMP, ETH_CHAIN_SELECTOR, ARB_CHAIN_SELECTOR, ROUTER);
    _assertOnRamp(BASE_ON_RAMP, ETH_CHAIN_SELECTOR, GNOSIS_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(ARB_OFF_RAMP, ARB_CHAIN_SELECTOR, ETH_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(BASE_OFF_RAMP, GNOSIS_CHAIN_SELECTOR, ETH_CHAIN_SELECTOR, ROUTER);

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
          params.destChainSelector == GNOSIS_CHAIN_SELECTOR
            ? NEW_REMOTE_TOKEN_GNOSIS
            : AaveV3ArbitrumAssets.GHO_UNDERLYING
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
    assertEq(NEW_TOKEN_POOL.getSupportedChains().length, 2);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[0], ARB_CHAIN_SELECTOR);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[1], GNOSIS_CHAIN_SELECTOR);
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ARB_CHAIN_SELECTOR),
      abi.encode(address(AaveV3ArbitrumAssets.GHO_UNDERLYING))
    );
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(GNOSIS_CHAIN_SELECTOR),
      abi.encode(address(NEW_REMOTE_TOKEN_GNOSIS))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(GNOSIS_CHAIN_SELECTOR).length, 1);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(GNOSIS_CHAIN_SELECTOR)[0],
      abi.encode(address(NEW_REMOTE_POOL_GNOSIS))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(ARB_CHAIN_SELECTOR).length, 2);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(ARB_CHAIN_SELECTOR)[1], // 0th is the 1.4 token pool
      abi.encode(address(NEW_REMOTE_POOL_ARB))
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(GNOSIS_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(GNOSIS_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
  }

  function test_sendMessageToBaseSucceeds(uint256 amount) public {
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
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: GNOSIS_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Locked(address(BASE_ON_RAMP), amount);
    vm.expectEmit(address(BASE_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(GNOSIS_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount + amount);
  }

  function test_sendMessageToArbSucceeds(uint256 amount) public {
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
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: ARB_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Locked(address(ARB_ON_RAMP), amount);
    vm.expectEmit(address(ARB_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(ARB_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount + amount);
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
        remoteChainSelector: GNOSIS_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_GNOSIS)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), poolBalance - amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), GHO.balanceOf(address(NEW_TOKEN_POOL)));
  }

  function test_offRampViaArbSucceeds(uint256 amount) public {
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
    emit Released(address(ARB_OFF_RAMP), alice, amount);

    vm.prank(address(ARB_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ARB)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), poolBalance - amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), GHO.balanceOf(address(NEW_TOKEN_POOL)));
  }

  function test_cannotUseBaseOffRampForArbMessages() public {
    uint256 amount = 100e18;
    skip(_getInboundRefillTime(amount));

    vm.expectRevert(
      abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, address(BASE_OFF_RAMP))
    );
    vm.prank(address(BASE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ARB)),
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
        abi.encode(address(NEW_REMOTE_POOL_ARB))
      )
    );
    vm.prank(address(BASE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: GNOSIS_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ARB)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    vm.expectRevert(
      abi.encodeWithSelector(
        InvalidSourcePoolAddress.selector,
        abi.encode(address(NEW_REMOTE_POOL_GNOSIS))
      )
    );
    vm.prank(address(ARB_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_GNOSIS)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }
}
