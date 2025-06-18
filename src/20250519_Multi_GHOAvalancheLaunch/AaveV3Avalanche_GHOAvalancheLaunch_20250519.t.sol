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
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';

import {ProxyAdmin} from 'openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOAvalancheLaunch} from './utils/GHOAvalancheLaunch.sol';

import {AaveV3Avalanche_GHOAvalancheLaunch_20250519} from './AaveV3Avalanche_GHOAvalancheLaunch_20250519.sol';

/**
 * @dev Test for AaveV3Avalanche_GHOAvalancheListing_20250519
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250519_Multi_GHOAvalancheLaunch/AaveV3Avalanche_GHOAvalancheListing_20250519.t.sol -vv
 */
contract AaveV3Avalanche_GHOAvalancheLaunch_20250519_Base is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    uint64 destChainSelector;
  }

  uint64 internal constant ARB_CHAIN_SELECTOR = GHOAvalancheLaunch.ARB_CHAIN_SELECTOR;
  uint64 internal constant AVAX_CHAIN_SELECTOR = GHOAvalancheLaunch.AVAX_CHAIN_SELECTOR;
  uint64 internal constant ETH_CHAIN_SELECTOR = GHOAvalancheLaunch.ETH_CHAIN_SELECTOR;
  uint64 internal constant BASE_CHAIN_SELECTOR = GHOAvalancheLaunch.BASE_CHAIN_SELECTOR;
  uint128 public constant CCIP_BUCKET_CAPACITY = GHOAvalancheLaunch.CCIP_BUCKET_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOAvalancheLaunch.CCIP_RATE_LIMIT_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOAvalancheLaunch.CCIP_RATE_LIMIT_REFILL_RATE;

  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(GHOAvalancheLaunch.AVAX_TOKEN_ADMIN_REGISTRY);
  IEVM2EVMOnRamp internal constant ARB_ON_RAMP =
    IEVM2EVMOnRamp(GHOAvalancheLaunch.AVAX_ARB_ON_RAMP);
  IEVM2EVMOnRamp internal constant ETH_ON_RAMP =
    IEVM2EVMOnRamp(GHOAvalancheLaunch.AVAX_ETH_ON_RAMP);
  IEVM2EVMOnRamp internal constant BASE_ON_RAMP =
    IEVM2EVMOnRamp(GHOAvalancheLaunch.AVAX_BASE_ON_RAMP);
  IEVM2EVMOffRamp_1_5 internal constant ARB_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.AVAX_ARB_OFF_RAMP);
  IEVM2EVMOffRamp_1_5 internal constant ETH_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.AVAX_ETH_OFF_RAMP);
  IEVM2EVMOffRamp_1_5 internal constant BASE_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(GHOAvalancheLaunch.AVAX_BASE_OFF_RAMP);

  IRouter internal constant ROUTER = IRouter(GHOAvalancheLaunch.AVAX_CCIP_ROUTER);
  address internal constant RMN_PROXY = GHOAvalancheLaunch.AVAX_RMN_PROXY;

  IGhoToken internal constant GHO_TOKEN = IGhoToken(GHOAvalancheLaunch.GHO_TOKEN);
  address internal constant RISK_COUNCIL = GHOAvalancheLaunch.RISK_COUNCIL;

  IGhoAaveSteward internal constant NEW_GHO_AAVE_STEWARD =
    IGhoAaveSteward(GHOAvalancheLaunch.GHO_AAVE_CORE_STEWARD);
  IGhoBucketSteward internal constant NEW_GHO_BUCKET_STEWARD =
    IGhoBucketSteward(GHOAvalancheLaunch.GHO_BUCKET_STEWARD);
  IGhoCcipSteward internal constant NEW_GHO_CCIP_STEWARD =
    IGhoCcipSteward(GHOAvalancheLaunch.GHO_CCIP_STEWARD);
  IUpgradeableBurnMintTokenPool_1_5_1 internal constant NEW_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GHOAvalancheLaunch.GHO_CCIP_TOKEN_POOL);
  address internal constant NEW_REMOTE_POOL_ARB = GhoArbitrum.GHO_CCIP_TOKEN_POOL;
  address internal constant NEW_REMOTE_POOL_ETH = GhoEthereum.GHO_CCIP_TOKEN_POOL;
  address internal constant NEW_REMOTE_POOL_BASE = GhoBase.GHO_CCIP_TOKEN_POOL;

  AaveV3Avalanche_GHOAvalancheLaunch_20250519 internal proposal;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Burned(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address);
  error InvalidSourcePoolAddress(bytes);

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('avalanche'), GHOAvalancheLaunch.AVAX_BLOCK_NUMBER);
    proposal = new AaveV3Avalanche_GHOAvalancheLaunch_20250519();

    _validateConstants();
  }

  function _validateConstants() private view {
    assertEq(proposal.ETH_CHAIN_SELECTOR(), ETH_CHAIN_SELECTOR);
    assertEq(proposal.ARB_CHAIN_SELECTOR(), ARB_CHAIN_SELECTOR);
    assertEq(proposal.BASE_CHAIN_SELECTOR(), BASE_CHAIN_SELECTOR);
    assertEq(proposal.CCIP_BUCKET_CAPACITY(), CCIP_BUCKET_CAPACITY);
    assertEq(address(proposal.TOKEN_ADMIN_REGISTRY()), address(TOKEN_ADMIN_REGISTRY));
    assertEq(address(proposal.TOKEN_POOL()), address(NEW_TOKEN_POOL));
    assertEq(address(proposal.GHO_TOKEN()), address(GHO_TOKEN));
    assertEq(proposal.GHO_AAVE_STEWARD(), address(NEW_GHO_AAVE_STEWARD));
    assertEq(proposal.GHO_BUCKET_STEWARD(), address(NEW_GHO_BUCKET_STEWARD));
    assertEq(proposal.GHO_CCIP_STEWARD(), address(NEW_GHO_CCIP_STEWARD));
    assertEq(proposal.REMOTE_TOKEN_POOL_ARB(), NEW_REMOTE_POOL_ARB);
    assertEq(proposal.REMOTE_TOKEN_POOL_ETH(), NEW_REMOTE_POOL_ETH);
    assertEq(proposal.REMOTE_TOKEN_POOL_BASE(), NEW_REMOTE_POOL_BASE);
    assertEq(proposal.CCIP_RATE_LIMIT_CAPACITY(), CCIP_RATE_LIMIT_CAPACITY);
    assertEq(proposal.CCIP_RATE_LIMIT_REFILL_RATE(), CCIP_RATE_LIMIT_REFILL_RATE);

    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(NEW_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(ROUTER.typeAndVersion(), 'Router 1.2.0');

    _assertOnRamp(ARB_ON_RAMP, AVAX_CHAIN_SELECTOR, ARB_CHAIN_SELECTOR, ROUTER);
    _assertOnRamp(ETH_ON_RAMP, AVAX_CHAIN_SELECTOR, ETH_CHAIN_SELECTOR, ROUTER);
    _assertOnRamp(BASE_ON_RAMP, AVAX_CHAIN_SELECTOR, BASE_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(ARB_OFF_RAMP, ARB_CHAIN_SELECTOR, AVAX_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(ETH_OFF_RAMP, ETH_CHAIN_SELECTOR, AVAX_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(BASE_OFF_RAMP, BASE_CHAIN_SELECTOR, AVAX_CHAIN_SELECTOR, ROUTER);

    assertEq(_getProxyAdmin(address(GHO_TOKEN)).UPGRADE_INTERFACE_VERSION(), '5.0.0');
    assertEq(_getProxyAdmin(address(NEW_TOKEN_POOL)).UPGRADE_INTERFACE_VERSION(), '5.0.0');
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
    message.tokenAmounts[0] = IClient.EVMTokenAmount({
      token: address(GHO_TOKEN),
      amount: params.amount
    });

    uint256 feeAmount = ROUTER.getFee(params.destChainSelector, message);
    deal(params.sender, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: ROUTER,
        sourceChainSelector: AVAX_CHAIN_SELECTOR,
        destChainSelector: params.destChainSelector,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: address(GHO_TOKEN),
        destinationToken: address(
          params.destChainSelector == ARB_CHAIN_SELECTOR
            ? AaveV3ArbitrumAssets.GHO_UNDERLYING
            : params.destChainSelector == BASE_CHAIN_SELECTOR
              ? AaveV3BaseAssets.GHO_UNDERLYING
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

  function _getProxyAdmin(address proxy) internal view returns (ProxyAdmin) {
    bytes32 slot = bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1);
    return ProxyAdmin(address(uint160(uint256(vm.load(proxy, slot)))));
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

contract AaveV3Avalanche_GHOAvalancheLaunch_20250519_PreExecution is
  AaveV3Avalanche_GHOAvalancheLaunch_20250519_Base
{
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_GHOAvalancheLaunch_20250519',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_stewardRoles() public {
    // gho token is deployed in the AIP, does not existing before

    assertFalse(
      AaveV3Avalanche.ACL_MANAGER.hasRole(
        AaveV3Avalanche.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(NEW_GHO_AAVE_STEWARD)
      )
    );
    assertEq(NEW_GHO_BUCKET_STEWARD.getControlledFacilitators().length, 0);
    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(0));

    executePayload(vm, address(proposal));

    assertTrue(
      GHO_TOKEN.hasRole(GHO_TOKEN.FACILITATOR_MANAGER_ROLE(), GovernanceV3Avalanche.EXECUTOR_LVL_1)
    );
    assertTrue(
      GHO_TOKEN.hasRole(GHO_TOKEN.BUCKET_MANAGER_ROLE(), GovernanceV3Avalanche.EXECUTOR_LVL_1)
    );

    IGhoToken.Facilitator memory facilitator = GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL));
    assertEq(facilitator.label, 'CCIP TokenPool v1.5.1');
    assertEq(facilitator.bucketLevel, 0);
    assertEq(facilitator.bucketCapacity, proposal.CCIP_BUCKET_CAPACITY());

    assertTrue(
      AaveV3Avalanche.ACL_MANAGER.hasRole(
        AaveV3Avalanche.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(NEW_GHO_AAVE_STEWARD)
      )
    );

    assertTrue(GHO_TOKEN.hasRole(GHO_TOKEN.BUCKET_MANAGER_ROLE(), address(NEW_GHO_BUCKET_STEWARD)));

    address[] memory facilitatorList = NEW_GHO_BUCKET_STEWARD.getControlledFacilitators();
    assertEq(facilitatorList.length, 1);
    assertEq(facilitatorList[0], address(NEW_TOKEN_POOL));
    assertTrue(NEW_GHO_BUCKET_STEWARD.isControlledFacilitator(address(NEW_TOKEN_POOL)));

    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(NEW_GHO_CCIP_STEWARD));
  }

  function test_stewardsConfig() public view {
    assertEq(IOwnable(address(NEW_GHO_AAVE_STEWARD)).owner(), GovernanceV3Avalanche.EXECUTOR_LVL_1);
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_ADDRESSES_PROVIDER(),
      address(AaveV3Avalanche.POOL_ADDRESSES_PROVIDER)
    );
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_DATA_PROVIDER(),
      address(AaveV3Avalanche.AAVE_PROTOCOL_DATA_PROVIDER)
    );
    assertEq(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    IGhoAaveSteward.BorrowRateConfig memory config = NEW_GHO_AAVE_STEWARD.getBorrowRateConfig();
    assertEq(config.optimalUsageRatioMaxChange, 500);
    assertEq(config.baseVariableBorrowRateMaxChange, 500);
    assertEq(config.variableRateSlope1MaxChange, 500);
    assertEq(config.variableRateSlope2MaxChange, 500);

    assertEq(
      IOwnable(address(NEW_GHO_BUCKET_STEWARD)).owner(),
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    assertEq(NEW_GHO_BUCKET_STEWARD.GHO_TOKEN(), address(GHO_TOKEN));
    assertEq(NEW_GHO_BUCKET_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    assertEq(NEW_GHO_BUCKET_STEWARD.getControlledFacilitators().length, 0); // before AIP, no controlled facilitators are set

    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN(), address(GHO_TOKEN));
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN_POOL(), address(NEW_TOKEN_POOL));
    assertEq(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    assertFalse(NEW_GHO_CCIP_STEWARD.BRIDGE_LIMIT_ENABLED());
    assertEq(
      abi.encode(NEW_GHO_CCIP_STEWARD.getCcipTimelocks()),
      abi.encode(IGhoCcipSteward.CcipDebounce(0, 0))
    );
  }

  function test_newTokenPoolInitialization() public {
    vm.expectRevert('Initializable: contract is already initialized');
    NEW_TOKEN_POOL.initialize(makeAddr('owner'), new address[](0), makeAddr('router'));
    assertEq(_readInitialized(address(NEW_TOKEN_POOL)), 1);

    address IMPL = _getImplementation(address(NEW_TOKEN_POOL));
    vm.expectRevert('Initializable: contract is already initialized');
    IUpgradeableBurnMintTokenPool_1_5_1(IMPL).initialize(
      makeAddr('owner'),
      new address[](0),
      makeAddr('router')
    );
    assertEq(_readInitialized(IMPL), 255);
  }

  function test_tokenPoolConfig() public {
    executePayload(vm, address(proposal));

    assertEq(NEW_TOKEN_POOL.owner(), GovernanceV3Avalanche.EXECUTOR_LVL_1);
    assertEq(
      address(uint160(uint256(vm.load(address(NEW_TOKEN_POOL), bytes32(0))) >> 2)), // pending owner
      address(0)
    );
    assertEq(NEW_TOKEN_POOL.getToken(), address(GHO_TOKEN));
    assertEq(NEW_TOKEN_POOL.getTokenDecimals(), GHO_TOKEN.decimals());
    assertEq(NEW_TOKEN_POOL.getRmnProxy(), RMN_PROXY);
    assertFalse(NEW_TOKEN_POOL.getAllowListEnabled());
    assertEq(abi.encode(NEW_TOKEN_POOL.getAllowList()), abi.encode(new address[](0)));
    assertEq(NEW_TOKEN_POOL.getRouter(), address(ROUTER));

    assertEq(NEW_TOKEN_POOL.getSupportedChains().length, 3);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[0], ETH_CHAIN_SELECTOR);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[1], ARB_CHAIN_SELECTOR);
    assertEq(NEW_TOKEN_POOL.getSupportedChains()[2], BASE_CHAIN_SELECTOR);

    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ETH_CHAIN_SELECTOR),
      abi.encode(AaveV3EthereumAssets.GHO_UNDERLYING)
    );
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ARB_CHAIN_SELECTOR),
      abi.encode(AaveV3ArbitrumAssets.GHO_UNDERLYING)
    );
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(BASE_CHAIN_SELECTOR),
      abi.encode(AaveV3BaseAssets.GHO_UNDERLYING)
    );
    assertEq(NEW_TOKEN_POOL.getRemotePools(ETH_CHAIN_SELECTOR).length, 1);
    assertEq(NEW_TOKEN_POOL.getRemotePools(ETH_CHAIN_SELECTOR)[0], abi.encode(NEW_REMOTE_POOL_ETH));
    assertEq(NEW_TOKEN_POOL.getRemotePools(ARB_CHAIN_SELECTOR).length, 1);
    assertEq(NEW_TOKEN_POOL.getRemotePools(ARB_CHAIN_SELECTOR)[0], abi.encode(NEW_REMOTE_POOL_ARB));
    assertEq(NEW_TOKEN_POOL.getRemotePools(BASE_CHAIN_SELECTOR).length, 1);
    assertEq(
      NEW_TOKEN_POOL.getRemotePools(BASE_CHAIN_SELECTOR)[0],
      abi.encode(NEW_REMOTE_POOL_BASE)
    );

    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getRateLimiterConfig()
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
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(BASE_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(BASE_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
  }
}

contract AaveV3Avalance_GHOAvalanceLaunch_20250519_PostExecution is
  AaveV3Avalanche_GHOAvalancheLaunch_20250519_Base
{
  function setUp() public override {
    super.setUp();

    executePayload(vm, address(proposal));
  }

  function test_sendMessageToArbSucceeds(uint256 amount) public {
    amount = bound(amount, 1, CCIP_RATE_LIMIT_CAPACITY);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill
    // mock previously bridged amount
    vm.prank(address(NEW_TOKEN_POOL));
    GHO_TOKEN.mint(alice, amount); // increase bucket level

    vm.prank(alice);
    GHO_TOKEN.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO_TOKEN.balanceOf(alice);
    uint256 bucketLevel = GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({amount: amount, sender: alice, destChainSelector: ARB_CHAIN_SELECTOR})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Burned(address(ARB_ON_RAMP), amount);
    vm.expectEmit(address(ARB_ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(ARB_CHAIN_SELECTOR, message);

    assertEq(GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
  }

  function test_sendMessageToEthSucceeds(uint256 amount) public {
    amount = bound(amount, 1, CCIP_RATE_LIMIT_CAPACITY);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill
    // mock previously bridged amount
    vm.prank(address(NEW_TOKEN_POOL));
    GHO_TOKEN.mint(alice, amount); // increase bucket level

    deal(address(GHO_TOKEN), alice, amount);
    vm.prank(alice);
    GHO_TOKEN.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO_TOKEN.balanceOf(alice);
    uint256 bucketLevel = GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;

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

    assertEq(GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
  }

  function test_sendMessageToBaseSucceeds(uint256 amount) public {
    amount = bound(amount, 1, CCIP_RATE_LIMIT_CAPACITY);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill
    // mock previously bridged amount
    vm.prank(address(NEW_TOKEN_POOL));
    GHO_TOKEN.mint(alice, amount); // increase bucket level

    vm.prank(alice);
    GHO_TOKEN.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO_TOKEN.balanceOf(alice);
    uint256 bucketLevel = GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;

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

    assertEq(GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
  }

  function test_offRampViaArbSucceeds(uint256 amount) public {
    amount = bound(
      amount,
      1,
      _min(
        GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketCapacity, // initially, bucketLevel == 0
        CCIP_RATE_LIMIT_CAPACITY
      )
    );
    skip(_getInboundRefillTime(amount)); // wait for the rate limiter to refill

    uint256 aliceBalance = GHO_TOKEN.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(ARB_OFF_RAMP), alice, amount);

    vm.prank(address(ARB_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ARB)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, amount);
    assertEq(GHO_TOKEN.balanceOf(alice), aliceBalance + amount);
  }

  function test_offRampViaEthSucceeds(uint256 amount) public {
    amount = bound(
      amount,
      1,
      _min(
        GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketCapacity, // initially, bucketLevel == 0
        CCIP_RATE_LIMIT_CAPACITY
      )
    );
    skip(_getInboundRefillTime(amount)); // wait for the rate limiter to refill

    uint256 aliceBalance = GHO_TOKEN.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(ETH_OFF_RAMP), alice, amount);

    vm.prank(address(ETH_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ETH)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, amount);
    assertEq(GHO_TOKEN.balanceOf(alice), aliceBalance + amount);
  }

  function test_offRampViaBaseSucceeds(uint256 amount) public {
    amount = bound(
      amount,
      1,
      _min(
        GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketCapacity, // initially, bucketLevel == 0
        CCIP_RATE_LIMIT_CAPACITY
      )
    );
    skip(_getInboundRefillTime(amount)); // wait for the rate limiter to refill

    uint256 aliceBalance = GHO_TOKEN.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(BASE_OFF_RAMP), alice, amount);

    vm.prank(address(BASE_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: BASE_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_BASE)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, amount);
    assertEq(GHO_TOKEN.balanceOf(alice), aliceBalance + amount);
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
    vm.prank(address(ARB_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ETH)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    vm.expectRevert(
      abi.encodeWithSelector(
        InvalidSourcePoolAddress.selector,
        abi.encode(address(NEW_REMOTE_POOL_ARB))
      )
    );
    vm.prank(address(ETH_OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ARB)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }
}
