// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableBurnMintTokenPool_1_4, IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
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
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {GhoCcipSteward} from 'gho-core/misc/GhoCcipSteward.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';

import {AaveV3Arbitrum_GHOCCIP151Upgrade_20241209} from '../20241209_Multi_GHOCCIP151Upgrade/AaveV3Arbitrum_GHOCCIP151Upgrade_20241209.sol';
import {AaveV3Arbitrum_GHOBaseLaunch_20241223} from './AaveV3Arbitrum_GHOBaseLaunch_20241223.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOBaseLaunch_20241223
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241223_Multi_GHOBaseLaunch/AaveV3Arbitrum_GHOBaseLaunch_20241223.t.sol -vv
 */
contract AaveV3Arbitrum_GHOBaseLaunch_20241223_Test is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    uint64 destChainSelector;
  }

  uint64 internal constant ARB_CHAIN_SELECTOR = 4949039107694359620;
  uint64 internal constant BASE_CHAIN_SELECTOR = 15971525489660198786;
  uint64 internal constant ETH_CHAIN_SELECTOR = 5009297550715157269;

  IGhoToken internal constant GHO = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);
  IEVM2EVMOnRamp internal constant ETH_ON_RAMP =
    IEVM2EVMOnRamp(0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3);
  IEVM2EVMOnRamp internal constant BASE_ON_RAMP =
    IEVM2EVMOnRamp(0xc1b6287A3292d6469F2D8545877E40A2f75CA9a6);

  IEVM2EVMOffRamp_1_5 internal constant ETH_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0x91e46cc5590A4B9182e47f40006140A7077Dec31);
  IEVM2EVMOffRamp_1_5 internal constant BASE_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0xb62178f8198905D0Fa6d640Bdb188E4E8143Ac4b);

  IRouter internal constant ROUTER = IRouter(0x141fa059441E0ca23ce184B6A78bafD2A517DdE8);

  IGhoCcipSteward internal NEW_GHO_CCIP_STEWARD;

  IUpgradeableBurnMintTokenPool_1_5_1 internal NEW_TOKEN_POOL;

  AaveV3Arbitrum_GHOBaseLaunch_20241223 internal proposal;

  address internal NEW_REMOTE_POOL_ETH = makeAddr('ETH: LockReleaseTokenPool 1.5.1');
  address internal NEW_REMOTE_POOL_BASE = makeAddr('BASE: LockReleaseTokenPool 1.5.1');
  address internal NEW_REMOTE_TOKEN_BASE = makeAddr('BASE: GhoToken');
  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Burned(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address);
  error InvalidSourcePoolAddress(bytes);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 287752362);
    NEW_TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(_deployNewTokenPoolArb());
    NEW_GHO_CCIP_STEWARD = IGhoCcipSteward(_deployNewGhoCcipSteward(address(NEW_TOKEN_POOL)));
    _upgradeArbTo1_5_1();
    proposal = new AaveV3Arbitrum_GHOBaseLaunch_20241223(
      address(NEW_TOKEN_POOL),
      NEW_REMOTE_POOL_BASE,
      NEW_REMOTE_TOKEN_BASE
    );

    _validateConstants();

    // execute proposal
    executePayload(vm, address(proposal));
  }

  function _upgradeArbTo1_5_1() internal {
    vm.prank(TOKEN_ADMIN_REGISTRY.owner());
    TOKEN_ADMIN_REGISTRY.transferAdminRole(address(GHO), GovernanceV3Arbitrum.EXECUTOR_LVL_1);

    executePayload(
      vm,
      address(
        new AaveV3Arbitrum_GHOCCIP151Upgrade_20241209(
          address(NEW_TOKEN_POOL),
          NEW_REMOTE_POOL_ETH,
          address(NEW_GHO_CCIP_STEWARD)
        )
      )
    );
  }

  function _deployNewTokenPoolArb() private returns (address) {
    IUpgradeableBurnMintTokenPool_1_4 existingTokenPool = IUpgradeableBurnMintTokenPool_1_4(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    );
    address newTokenPoolImpl = address(
      new UpgradeableBurnMintTokenPool(
        existingTokenPool.getToken(),
        IGhoToken(existingTokenPool.getToken()).decimals(),
        existingTokenPool.getArmProxy(),
        existingTokenPool.getAllowListEnabled()
      )
    );
    return
      address(
        new TransparentUpgradeableProxy(
          newTokenPoolImpl,
          address(MiscArbitrum.PROXY_ADMIN),
          abi.encodeCall(
            IUpgradeableBurnMintTokenPool_1_5_1.initialize,
            (
              GovernanceV3Arbitrum.EXECUTOR_LVL_1, // owner
              existingTokenPool.getAllowList(),
              existingTokenPool.getRouter()
            )
          )
        )
      );
  }

  function _deployNewGhoCcipSteward(address newTokenPool) internal returns (address) {
    return
      address(
        new GhoCcipSteward(
          address(GHO),
          newTokenPool,
          GovernanceV3Arbitrum.EXECUTOR_LVL_1, // riskAdmin, using executor for convenience
          false // bridgeLimitEnabled Whether the bridge limit feature is supported in the GhoTokenPool
        )
      );
  }

  function _validateConstants() private view {
    assertEq(proposal.BASE_CHAIN_SELECTOR(), BASE_CHAIN_SELECTOR);
    assertEq(address(proposal.TOKEN_POOL()), address(NEW_TOKEN_POOL));
    assertEq(proposal.REMOTE_TOKEN_POOL_BASE(), NEW_REMOTE_POOL_BASE);
    assertEq(proposal.REMOTE_GHO_TOKEN_BASE(), NEW_REMOTE_TOKEN_BASE);

    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(NEW_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(ROUTER.typeAndVersion(), 'Router 1.2.0');

    _assertOnRamp(ETH_ON_RAMP, ARB_CHAIN_SELECTOR, ETH_CHAIN_SELECTOR, ROUTER);
    _assertOnRamp(BASE_ON_RAMP, ARB_CHAIN_SELECTOR, BASE_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(ETH_OFF_RAMP, ETH_CHAIN_SELECTOR, ARB_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(BASE_OFF_RAMP, BASE_CHAIN_SELECTOR, ARB_CHAIN_SELECTOR, ROUTER);

    assertEq(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL(), GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN(), AaveV3ArbitrumAssets.GHO_UNDERLYING);
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN_POOL(), address(NEW_TOKEN_POOL));
    assertFalse(NEW_GHO_CCIP_STEWARD.BRIDGE_LIMIT_ENABLED());
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
        sourceChainSelector: ARB_CHAIN_SELECTOR,
        destChainSelector: params.destChainSelector,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: address(GHO),
        destinationToken: address(
          params.destChainSelector == BASE_CHAIN_SELECTOR
            ? NEW_REMOTE_TOKEN_BASE
            : AaveV3EthereumAssets.GHO_UNDERLYING
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

  function assertEq(
    IRateLimiter.TokenBucket memory bucket,
    IRateLimiter.Config memory config
  ) internal pure {
    assertEq(abi.encode(_tokenBucketToConfig(bucket)), abi.encode(config));
  }

  function test_BasePoolConfig() public view {
    assertEq(NEW_TOKEN_POOL.getSupportedChains().length, 2);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[0], ETH_CHAIN_SELECTOR);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[1], BASE_CHAIN_SELECTOR);
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ETH_CHAIN_SELECTOR),
      abi.encode(address(AaveV3EthereumAssets.GHO_UNDERLYING))
    );
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(BASE_CHAIN_SELECTOR),
      abi.encode(address(NEW_REMOTE_TOKEN_BASE))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(BASE_CHAIN_SELECTOR).length, 1);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(BASE_CHAIN_SELECTOR)[0],
      abi.encode(address(NEW_REMOTE_POOL_BASE))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(ETH_CHAIN_SELECTOR).length, 2);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(ETH_CHAIN_SELECTOR)[1], // 0th is the 1.4 token pool
      abi.encode(address(NEW_REMOTE_POOL_ETH))
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(BASE_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(BASE_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
  }

  function test_sendMessageToBaseSucceeds(uint256 amount) public {
    uint256 bridgeableAmount = GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;
    amount = bound(amount, 1, bridgeableAmount);

    deal(address(GHO), alice, amount);
    vm.prank(alice);
    GHO.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO.balanceOf(alice);

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: BASE_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Burned(address(BASE_ON_RAMP), amount);
    vm.expectEmit(address(BASE_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(BASE_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bridgeableAmount - amount);
  }

  function test_sendMessageToEthSucceeds(uint256 amount) public {
    uint256 bridgeableAmount = GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;
    amount = bound(amount, 1, bridgeableAmount);

    deal(address(GHO), alice, amount);
    vm.prank(alice);
    GHO.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO.balanceOf(alice);

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: ETH_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Burned(address(ETH_ON_RAMP), amount);
    vm.expectEmit(address(ETH_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(ETH_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bridgeableAmount - amount);
  }

  function test_offRampViaBaseSucceeds(uint256 amount) public {
    (uint256 bucketCapacity, uint256 bucketLevel) = GHO.getFacilitatorBucket(
      address(NEW_TOKEN_POOL)
    );
    uint256 mintAbleAmount = bucketCapacity - bucketLevel;
    amount = bound(amount, 1, mintAbleAmount);

    uint256 aliceBalance = GHO.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(BASE_OFF_RAMP), alice, amount);

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

    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel + amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
  }

  function test_offRampViaEthSucceeds(uint256 amount) public {
    (uint256 bucketCapacity, uint256 bucketLevel) = GHO.getFacilitatorBucket(
      address(NEW_TOKEN_POOL)
    );
    uint256 mintAbleAmount = bucketCapacity - bucketLevel;
    amount = bound(amount, 1, mintAbleAmount);

    uint256 aliceBalance = GHO.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(ETH_OFF_RAMP), alice, amount);

    vm.prank(address(ETH_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ETH)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel + amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
  }

  function test_cannotUseBaseOffRampForEthMessages() public {
    uint256 amount = 100e18;

    vm.expectRevert(
      abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, address(BASE_OFF_RAMP))
    );
    vm.prank(address(BASE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ETH)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }

  function test_cannotOffRampOtherChainMessages() public {
    uint256 amount = 100e18;

    vm.expectRevert(
      abi.encodeWithSelector(
        InvalidSourcePoolAddress.selector,
        abi.encode(address(NEW_REMOTE_POOL_ETH))
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
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ETH)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    vm.expectRevert(
      abi.encodeWithSelector(
        InvalidSourcePoolAddress.selector,
        abi.encode(address(NEW_REMOTE_POOL_BASE))
      )
    );
    vm.prank(address(ETH_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_BASE)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }
}
