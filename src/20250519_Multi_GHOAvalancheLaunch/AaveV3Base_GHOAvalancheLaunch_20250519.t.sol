// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
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
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
// import {AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';
// import {GhoGnosis} from 'aave-address-book/GhoGnosis.sol';

import {ProxyAdmin, ITransparentUpgradeableProxy} from 'openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOLaunchConstants} from './utils/GHOLaunchConstants.sol';

import {AaveV3Base_GHOAvalancheLaunch_20250519} from './AaveV3Base_GHOAvalancheLaunch_20250519.sol';

/**
 * @dev Test for AaveV3Base_GHOAvalancheLaunch_20250519
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250421_Multi_GHOAvalancheLaunch/AaveV3Base_GHOAvalancheLaunch_20250519.t.sol -vv
 */
contract AaveV3Base_GHOAvalancheLaunch_20250519_Avalanche is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    uint64 destChainSelector;
  }

  uint64 internal constant ARBITRUM_CHAIN_SELECTOR = CCIPUtils.ARBITRUM_CHAIN_SELECTOR;
  uint64 internal constant BASE_CHAIN_SELECTOR = CCIPUtils.BASE_CHAIN_SELECTOR;
  uint64 internal constant ETHEREUM_CHAIN_SELECTOR = CCIPUtils.ETHEREUM_CHAIN_SELECTOR;
  uint64 internal constant GNOSIS_CHAIN_SELECTOR = CCIPUtils.GNOSIS_CHAIN_SELECTOR;
  uint64 internal constant AVALANCHE_CHAIN_SELECTOR = CCIPUtils.AVALANCHE_CHAIN_SELECTOR;
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOLaunchConstants.CCIP_RATE_LIMIT_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOLaunchConstants.CCIP_RATE_LIMIT_REFILL_RATE;

  IGhoToken internal constant GHO = IGhoToken(AaveV3BaseAssets.GHO_UNDERLYING);
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(GHOLaunchConstants.BASE_TOKEN_ADMIN_REGISTRY);
  IEVM2EVMOnRamp internal constant ETHEREUM_ON_RAMP =
    IEVM2EVMOnRamp(GHOLaunchConstants.BASE_ETHEREUM_ON_RAMP);
  IEVM2EVMOnRamp internal constant AVALANCHE_ON_RAMP =
    IEVM2EVMOnRamp(GHOLaunchConstants.BASE_AVALANCHE_ON_RAMP);
  IEVM2EVMOffRamp_1_5 internal constant ETHEREUM_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(GHOLaunchConstants.BASE_ETHEREUM_OFF_RAMP);
  IEVM2EVMOffRamp_1_5 internal constant AVALANCHE_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(GHOLaunchConstants.BASE_AVALANCHE_OFF_RAMP);

  address internal constant RISK_COUNCIL = GHOLaunchConstants.RISK_COUNCIL;
  address public constant NEW_REMOTE_TOKEN_AVALANCHE = GHOLaunchConstants.AVALANCHE_TOKEN;
  IRouter internal constant ROUTER = IRouter(GHOLaunchConstants.BASE_CCIP_ROUTER);
  IGhoCcipSteward internal constant NEW_GHO_CCIP_STEWARD =
    IGhoCcipSteward(GhoBase.GHO_CCIP_STEWARD);
  IUpgradeableBurnMintTokenPool_1_5_1 internal constant NEW_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GhoBase.GHO_CCIP_TOKEN_POOL);
  address internal constant NEW_REMOTE_POOL_ETH = GhoEthereum.GHO_CCIP_TOKEN_POOL;
  address internal constant NEW_REMOTE_POOL_ARBITRUM = GhoArbitrum.GHO_CCIP_TOKEN_POOL;
  //   address internal constant NEW_REMOTE_POOL_GNOSIS = GhGnosis.GHO_CCIP_TOKEN_POOL;
  address internal constant NEW_REMOTE_POOL_AVALANCHE = GHOLaunchConstants.AVALANCHE_TOKEN_POOL;

  AaveV3Base_GHOAvalancheLaunch_20250519 internal proposal;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Burned(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address);
  error InvalidSourcePoolAddress(bytes);

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('base'), 30614935);
    proposal = new AaveV3Base_GHOAvalancheLaunch_20250519();
    _validateConstants();
  }

  function _validateConstants() private view {
    assertEq(proposal.AVALANCHE_CHAIN_SELECTOR(), AVALANCHE_CHAIN_SELECTOR);
    assertEq(address(proposal.TOKEN_POOL()), address(NEW_TOKEN_POOL));
    assertEq(proposal.REMOTE_TOKEN_POOL_AVALANCHE(), NEW_REMOTE_POOL_AVALANCHE);
    assertEq(proposal.REMOTE_GHO_TOKEN_AVALANCHE(), NEW_REMOTE_TOKEN_AVALANCHE);
    assertEq(proposal.CCIP_RATE_LIMIT_CAPACITY(), CCIP_RATE_LIMIT_CAPACITY);
    assertEq(proposal.CCIP_RATE_LIMIT_REFILL_RATE(), CCIP_RATE_LIMIT_REFILL_RATE);

    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(NEW_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(ROUTER.typeAndVersion(), 'Router 1.2.0');

    _assertOnRamp(ETHEREUM_ON_RAMP, BASE_CHAIN_SELECTOR, ETHEREUM_CHAIN_SELECTOR, ROUTER);
    _assertOnRamp(AVALANCHE_ON_RAMP, BASE_CHAIN_SELECTOR, AVALANCHE_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(ETHEREUM_OFF_RAMP, ETHEREUM_CHAIN_SELECTOR, BASE_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(AVALANCHE_OFF_RAMP, AVALANCHE_CHAIN_SELECTOR, BASE_CHAIN_SELECTOR, ROUTER);

    assertEq(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN(), AaveV3BaseAssets.GHO_UNDERLYING);
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
        sourceChainSelector: BASE_CHAIN_SELECTOR,
        destChainSelector: params.destChainSelector,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: address(GHO),
        destinationToken: address(
          params.destChainSelector == AVALANCHE_CHAIN_SELECTOR
            ? NEW_REMOTE_TOKEN_AVALANCHE
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

  function _getProxyAdmin(address proxy) internal view returns (address) {
    bytes32 slot = bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1);
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
}

contract AaveV3Base_GHOAvalancheLaunch_20250519_PostExecution is
  AaveV3Base_GHOAvalancheLaunch_20250519_Avalanche
{
  function setUp() public override {
    super.setUp();
    executePayload(vm, address(proposal));
  }

  function test_basePoolConfig() public view {
    assertEq(NEW_TOKEN_POOL.getSupportedChains().length, 3); // 4 after adding Gnosis
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[0], ETHEREUM_CHAIN_SELECTOR);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[1], ARBITRUM_CHAIN_SELECTOR);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[2], AVALANCHE_CHAIN_SELECTOR);
    // assertEq(NEW_TOKEN_POOL.getSupportedChains()[3], GNOSIS_CHAIN_SELECTOR);

    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ETHEREUM_CHAIN_SELECTOR),
      abi.encode(address(AaveV3EthereumAssets.GHO_UNDERLYING))
    );
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ARBITRUM_CHAIN_SELECTOR),
      abi.encode(address(AaveV3ArbitrumAssets.GHO_UNDERLYING))
    );
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(AVALANCHE_CHAIN_SELECTOR),
      abi.encode(address(NEW_REMOTE_TOKEN_AVALANCHE))
    );
    // assertEq(
    //   NEW_TOKEN_POOL.getRemoteToken(GNOSIS_CHAIN_SELECTOR),
    //   abi.encode(address(AaveV3GnosisAssets.GHO_UNDERLYING))
    // );

    assertEq(NEW_TOKEN_POOL.getRemotePools(ARBITRUM_CHAIN_SELECTOR).length, 1);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(ARBITRUM_CHAIN_SELECTOR)[0],
      abi.encode(address(NEW_REMOTE_POOL_ARBITRUM))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(ETHEREUM_CHAIN_SELECTOR).length, 1);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(ETHEREUM_CHAIN_SELECTOR)[0], // 0th is the 1.4 token pool
      abi.encode(address(NEW_REMOTE_POOL_ETH))
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(AVALANCHE_CHAIN_SELECTOR).length, 1);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(AVALANCHE_CHAIN_SELECTOR)[0],
      abi.encode(address(NEW_REMOTE_POOL_AVALANCHE))
    );
    // assertEq(NEW_TOKEN_POOL.getRemotePools(GNOSIS_CHAIN_SELECTOR).length, 1);
    // assertEq(
    //   NEW_TOKEN_POOL.getRemotePools(GNOSIS_CHAIN_SELECTOR)[0],
    //   abi.encode(address(NEW_REMOTE_POOL_GNOSIS))
    // );

    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(AVALANCHE_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(AVALANCHE_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
  }

  function test_sendMessageToAvalancheSucceeds(uint256 amount) public {
    uint256 bridgeableAmount = _min(
      GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel,
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(GHO), alice, amount);
    vm.prank(alice);
    GHO.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 bucketLevel = GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: AVALANCHE_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Burned(address(AVALANCHE_ON_RAMP), amount);
    vm.expectEmit(address(AVALANCHE_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(AVALANCHE_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
  }

  function test_sendMessageToEthSucceeds(uint256 amount) public {
    IRateLimiter.TokenBucket memory ethRateLimits = NEW_TOKEN_POOL
      .getCurrentInboundRateLimiterState(ETHEREUM_CHAIN_SELECTOR);
    uint256 bridgeableAmount = _min(
      GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel,
      ethRateLimits.capacity
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(GHO), alice, amount);
    vm.prank(alice);
    GHO.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 bucketLevel = GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: ETHEREUM_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Burned(address(ETHEREUM_ON_RAMP), amount);
    vm.expectEmit(address(ETHEREUM_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(ETHEREUM_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
  }

  function test_offRampViaAvalancheSucceeds(uint256 amount) public {
    (uint256 bucketCapacity, uint256 bucketLevel) = GHO.getFacilitatorBucket(
      address(NEW_TOKEN_POOL)
    );
    uint256 mintAbleAmount = _min(bucketCapacity - bucketLevel, CCIP_RATE_LIMIT_CAPACITY);
    amount = bound(amount, 1, mintAbleAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = GHO.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(AVALANCHE_OFF_RAMP), alice, amount);

    vm.prank(address(AVALANCHE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: AVALANCHE_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_AVALANCHE)),
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
    IRateLimiter.TokenBucket memory rateLimits = NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(
      ETHEREUM_CHAIN_SELECTOR
    );
    uint256 mintAbleAmount = _min(bucketCapacity - bucketLevel, rateLimits.tokens);
    amount = bound(amount, 1, mintAbleAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = GHO.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(ETHEREUM_OFF_RAMP), alice, amount);

    vm.prank(address(ETHEREUM_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETHEREUM_CHAIN_SELECTOR,
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

  function test_cannotUseAvalancheOffRampForEthMessages() public {
    uint256 amount = 100e18;
    skip(_getInboundRefillTime(amount));

    vm.expectRevert(
      abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, address(AVALANCHE_OFF_RAMP))
    );
    vm.prank(address(AVALANCHE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETHEREUM_CHAIN_SELECTOR,
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
    skip(_getInboundRefillTime(amount));

    vm.expectRevert(
      abi.encodeWithSelector(
        InvalidSourcePoolAddress.selector,
        abi.encode(address(NEW_REMOTE_POOL_ETH))
      )
    );
    vm.prank(address(AVALANCHE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: AVALANCHE_CHAIN_SELECTOR,
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
        abi.encode(address(NEW_REMOTE_POOL_AVALANCHE))
      )
    );
    vm.prank(address(ETHEREUM_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETHEREUM_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_AVALANCHE)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    // vm.expectRevert(
    //   abi.encodeWithSelector(
    //     InvalidSourcePoolAddress.selector,
    //     abi.encode(address(NEW_REMOTE_POOL_AVALANCHE))
    //   )
    // );
    // vm.prank(address(ARBITRUM_OFF_RAMP));
    // NEW_TOKEN_POOL.releaseOrMint(
    //   IPool_CCIP.ReleaseOrMintInV1({
    //     originalSender: abi.encode(alice),
    //     remoteChainSelector: ETHEREUM_CHAIN_SELECTOR,
    //     receiver: alice,
    //     amount: amount,
    //     localToken: address(GHO),
    //     sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_AVALANCHE)),
    //     sourcePoolData: new bytes(0),
    //     offchainTokenData: new bytes(0)
    //   })
    // );

    // vm.expectRevert(
    //   abi.encodeWithSelector(
    //     InvalidSourcePoolAddress.selector,
    //     abi.encode(address(NEW_REMOTE_POOL_AVALANCHE))
    //   )
    // );
    // vm.prank(address(GNOSIS_OFF_RAMP));
    // NEW_TOKEN_POOL.releaseOrMint(
    //   IPool_CCIP.ReleaseOrMintInV1({
    //     originalSender: abi.encode(alice),
    //     remoteChainSelector: ETHEREUM_CHAIN_SELECTOR,
    //     receiver: alice,
    //     amount: amount,
    //     localToken: address(GHO),
    //     sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_AVALANCHE)),
    //     sourcePoolData: new bytes(0),
    //     offchainTokenData: new bytes(0)
    //   })
    // );
  }
}
