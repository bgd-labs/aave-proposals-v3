// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableLockReleaseTokenPool_1_4, IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IPool as IPool_CCIP} from 'src/interfaces/ccip/tokenPool/IPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IProxyPool} from 'src/interfaces/ccip/IProxyPool.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {ITypeAndVersion} from 'src/interfaces/ccip/ITypeAndVersion.sol';
import {IEVM2EVMOffRamp_1_5} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';
import {DataTypes, IDefaultInterestRateStrategyV2} from 'aave-address-book/AaveV3.sol';

import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';
import {AaveV3Ethereum_GHOCCIP151Upgrade_20241209} from './AaveV3Ethereum_GHOCCIP151Upgrade_20241209.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOCCIP151Upgrade_20241209
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241209_Multi_GHOCCIP151Upgrade/AaveV3Ethereum_GHOCCIP151Upgrade_20241209.t.sol -vv
 */
contract AaveV3Ethereum_GHOCCIP151Upgrade_20241209_Base is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    CCIPUtils.PoolVersion poolVersion;
  }

  uint64 internal constant ETH_CHAIN_SELECTOR = CCIPUtils.ETH_CHAIN_SELECTOR;
  uint64 internal constant ARB_CHAIN_SELECTOR = CCIPUtils.ARB_CHAIN_SELECTOR;
  uint256 internal constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  uint256 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  IGhoToken internal constant GHO = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING);
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);
  address internal constant ARB_PROXY_POOL = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50;
  IEVM2EVMOnRamp internal constant ON_RAMP =
    IEVM2EVMOnRamp(0x69eCC4E2D8ea56E2d0a05bF57f4Fd6aEE7f2c284);
  IEVM2EVMOffRamp_1_5 internal constant OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9);
  IRouter internal constant ROUTER = IRouter(0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D);

  IGhoAaveSteward public constant EXISTING_GHO_AAVE_STEWARD =
    IGhoAaveSteward(0xFEb4e54591660F42288312AE8eB59e9f2B746b66);
  IGhoAaveSteward public constant NEW_GHO_AAVE_STEWARD =
    IGhoAaveSteward(0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34);
  IGhoCcipSteward internal constant EXISTING_GHO_CCIP_STEWARD =
    IGhoCcipSteward(0x101Efb7b9Beb073B1219Cd5473a7C8A2f2EB84f4);
  IGhoCcipSteward internal constant NEW_GHO_CCIP_STEWARD =
    IGhoCcipSteward(0xC5BcC58BE6172769ca1a78B8A45752E3C5059c39);

  IProxyPool internal constant EXISTING_PROXY_POOL =
    IProxyPool(0x9Ec9F9804733df96D1641666818eFb5198eC50f0);
  IUpgradeableLockReleaseTokenPool_1_4 internal constant EXISTING_TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_4(0x5756880B6a1EAba0175227bf02a7E87c1e02B28C); // GhoEthereum.GHO_CCIP_TOKEN_POOL; will be updated in address-book after AIP
  IUpgradeableLockReleaseTokenPool_1_5_1 internal constant NEW_TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_5_1(0x06179f7C1be40863405f374E7f5F8806c728660A);
  address internal constant NEW_REMOTE_POOL_ARB = 0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB;

  AaveV3Ethereum_GHOCCIP151Upgrade_20241209 internal proposal;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Locked(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error BridgeLimitExceeded(uint256 limit);

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21594804);
    proposal = new AaveV3Ethereum_GHOCCIP151Upgrade_20241209();
    _validateConstants();
  }

  function _validateConstants() private view {
    assertEq(address(proposal.TOKEN_ADMIN_REGISTRY()), address(TOKEN_ADMIN_REGISTRY));
    assertEq(proposal.ARB_CHAIN_SELECTOR(), ARB_CHAIN_SELECTOR);
    assertEq(address(proposal.EXISTING_PROXY_POOL()), address(EXISTING_PROXY_POOL));
    assertEq(address(proposal.EXISTING_TOKEN_POOL()), address(EXISTING_TOKEN_POOL));
    assertEq(address(proposal.EXISTING_REMOTE_POOL_ARB()), ARB_PROXY_POOL);
    assertEq(address(proposal.NEW_TOKEN_POOL()), address(NEW_TOKEN_POOL));
    assertEq(address(proposal.EXISTING_GHO_AAVE_STEWARD()), address(EXISTING_GHO_AAVE_STEWARD));
    assertEq(address(proposal.NEW_GHO_AAVE_STEWARD()), address(NEW_GHO_AAVE_STEWARD));
    assertEq(address(proposal.NEW_GHO_CCIP_STEWARD()), address(NEW_GHO_CCIP_STEWARD));
    assertEq(address(proposal.NEW_REMOTE_POOL_ARB()), NEW_REMOTE_POOL_ARB);
    assertEq(proposal.CCIP_RATE_LIMIT_CAPACITY(), CCIP_RATE_LIMIT_CAPACITY);
    assertEq(proposal.CCIP_RATE_LIMIT_REFILL_RATE(), CCIP_RATE_LIMIT_REFILL_RATE);

    assertEq(address(proposal.EXISTING_PROXY_POOL()), EXISTING_TOKEN_POOL.getProxyPool());

    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(NEW_TOKEN_POOL.typeAndVersion(), 'LockReleaseTokenPool 1.5.1');
    assertEq(EXISTING_TOKEN_POOL.typeAndVersion(), 'LockReleaseTokenPool 1.4.0');
    assertEq(
      ITypeAndVersion(EXISTING_TOKEN_POOL.getProxyPool()).typeAndVersion(),
      'LockReleaseTokenPoolAndProxy 1.5.0'
    );
    assertEq(ON_RAMP.typeAndVersion(), 'EVM2EVMOnRamp 1.5.0');
    assertEq(OFF_RAMP.typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');

    assertEq(ROUTER.typeAndVersion(), 'Router 1.2.0');
    assertEq(EXISTING_TOKEN_POOL.getRouter(), address(ROUTER));

    assertEq(ROUTER.getOnRamp(ARB_CHAIN_SELECTOR), address(ON_RAMP));
    assertTrue(ROUTER.isOffRamp(ARB_CHAIN_SELECTOR, address(OFF_RAMP)));

    assertTrue(
      AaveV3Ethereum.ACL_MANAGER.hasRole(
        AaveV3Ethereum.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(EXISTING_GHO_AAVE_STEWARD)
      )
    );
    assertEq(IOwnable(address(NEW_GHO_AAVE_STEWARD)).owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_ADDRESSES_PROVIDER(),
      address(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER)
    );
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_DATA_PROVIDER(),
      address(AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER)
    );
    assertEq(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL(), EXISTING_GHO_AAVE_STEWARD.RISK_COUNCIL());
    assertEq(
      NEW_GHO_AAVE_STEWARD.getBorrowRateConfig(),
      IGhoAaveSteward.BorrowRateConfig({
        optimalUsageRatioMaxChange: 5_00,
        baseVariableBorrowRateMaxChange: 5_00,
        variableRateSlope1MaxChange: 5_00,
        variableRateSlope2MaxChange: 5_00
      })
    );

    assertEq(EXISTING_TOKEN_POOL.getRateLimitAdmin(), address(EXISTING_GHO_CCIP_STEWARD));
    assertEq(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL(), EXISTING_GHO_CCIP_STEWARD.RISK_COUNCIL());
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN(), AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN_POOL(), address(NEW_TOKEN_POOL));
    assertTrue(NEW_GHO_CCIP_STEWARD.BRIDGE_LIMIT_ENABLED()); // *present* on eth token pool
    assertEq(
      abi.encode(NEW_GHO_CCIP_STEWARD.getCcipTimelocks()),
      abi.encode(IGhoCcipSteward.CcipDebounce(0, 0))
    );

    assertEq(_getProxyAdmin(address(NEW_TOKEN_POOL)).UPGRADE_INTERFACE_VERSION(), '5.0.0');
  }

  function _getTokenMessage(
    CCIPSendParams memory params
  ) internal returns (IClient.EVM2AnyMessage memory, IInternal.EVM2EVMMessage memory) {
    IClient.EVM2AnyMessage memory message = CCIPUtils.generateMessage(params.sender, 1);
    message.tokenAmounts[0] = IClient.EVMTokenAmount({
      token: AaveV3EthereumAssets.GHO_UNDERLYING,
      amount: params.amount
    });

    uint256 feeAmount = ROUTER.getFee(ARB_CHAIN_SELECTOR, message);
    deal(params.sender, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: ROUTER,
        sourceChainSelector: ETH_CHAIN_SELECTOR,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: AaveV3EthereumAssets.GHO_UNDERLYING,
        destinationToken: AaveV3ArbitrumAssets.GHO_UNDERLYING,
        poolVersion: params.poolVersion
      })
    );

    return (message, eventArg);
  }

  function _getStaticParams(address tokenPool) internal view returns (bytes memory) {
    IUpgradeableLockReleaseTokenPool_1_4 ghoTokenPool = IUpgradeableLockReleaseTokenPool_1_4(
      tokenPool
    );
    return
      abi.encode(
        ghoTokenPool.getToken(),
        ghoTokenPool.getAllowListEnabled(),
        ghoTokenPool.getAllowList(),
        ghoTokenPool.canAcceptLiquidity(),
        ghoTokenPool.getRouter()
      );
  }

  function _getDynamicParams(address tokenPool) internal view returns (bytes memory) {
    IUpgradeableLockReleaseTokenPool_1_4 ghoTokenPool = IUpgradeableLockReleaseTokenPool_1_4(
      tokenPool
    );
    return
      abi.encode(
        ghoTokenPool.owner(),
        ghoTokenPool.getSupportedChains(),
        ghoTokenPool.getRebalancer(),
        ghoTokenPool.getBridgeLimit()
      );
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
  function _getProxyAdmin(address proxy) internal view returns (ProxyAdmin) {
    bytes32 slot = bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1);
    return ProxyAdmin(address(uint160(uint256(vm.load(proxy, slot)))));
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
    return amount / CCIP_RATE_LIMIT_REFILL_RATE + 1; // account for rounding
  }

  function _getInboundRefillTime(uint256 amount) internal pure returns (uint256) {
    return amount / CCIP_RATE_LIMIT_REFILL_RATE + 1; // account for rounding
  }

  function _min(uint256 a, uint256 b) internal pure returns (uint256) {
    return a < b ? a : b;
  }

  function _isDifferenceLowerThanMax(
    uint256 from,
    uint256 to,
    uint256 max
  ) internal pure returns (bool) {
    return from < to ? to - from <= max : from - to <= max;
  }

  function assertEq(
    IDefaultInterestRateStrategyV2.InterestRateData memory a,
    IDefaultInterestRateStrategyV2.InterestRateData memory b
  ) internal pure {
    assertEq(a.optimalUsageRatio, b.optimalUsageRatio);
    assertEq(a.baseVariableBorrowRate, b.baseVariableBorrowRate);
    assertEq(a.variableRateSlope1, b.variableRateSlope1);
    assertEq(a.variableRateSlope2, b.variableRateSlope2);
    assertEq(abi.encode(a), abi.encode(b)); // sanity check
  }

  function assertEq(
    IGhoAaveSteward.BorrowRateConfig memory a,
    IGhoAaveSteward.BorrowRateConfig memory b
  ) internal pure {
    assertEq(a.optimalUsageRatioMaxChange, b.optimalUsageRatioMaxChange);
    assertEq(a.baseVariableBorrowRateMaxChange, b.baseVariableBorrowRateMaxChange);
    assertEq(a.variableRateSlope1MaxChange, b.variableRateSlope1MaxChange);
    assertEq(a.variableRateSlope2MaxChange, b.variableRateSlope2MaxChange);
    assertEq(abi.encode(a), abi.encode(b)); // sanity check
  }

  function assertEq(
    IRateLimiter.TokenBucket memory bucket,
    IRateLimiter.Config memory config
  ) internal pure {
    assertEq(bucket.isEnabled, config.isEnabled);
    assertEq(bucket.capacity, config.capacity);
    assertEq(bucket.rate, config.rate);
    assertEq(abi.encode(_tokenBucketToConfig(bucket)), abi.encode(config)); // sanity check
  }
}

contract AaveV3Ethereum_GHOCCIP151Upgrade_20241209_SetupAndProposalActions is
  AaveV3Ethereum_GHOCCIP151Upgrade_20241209_Base
{
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOCCIP151Upgrade_20241209',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_tokenPoolOwnershipTransfer() public {
    assertFalse(
      TOKEN_ADMIN_REGISTRY.isAdministrator(address(GHO), GovernanceV3Ethereum.EXECUTOR_LVL_1)
    );
    ITokenAdminRegistry.TokenConfig memory tokenConfig = TOKEN_ADMIN_REGISTRY.getTokenConfig(
      address(GHO)
    );
    assertNotEq(tokenConfig.administrator, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(tokenConfig.pendingAdministrator, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(tokenConfig.tokenPool, address(EXISTING_PROXY_POOL));

    assertEq(EXISTING_TOKEN_POOL.owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(EXISTING_PROXY_POOL.owner(), TOKEN_ADMIN_REGISTRY.owner());
    assertEq(NEW_TOKEN_POOL.owner(), address(0));

    executePayload(vm, address(proposal));

    tokenConfig = TOKEN_ADMIN_REGISTRY.getTokenConfig(address(GHO));
    assertEq(tokenConfig.administrator, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(tokenConfig.pendingAdministrator, address(0));
    assertEq(tokenConfig.tokenPool, address(NEW_TOKEN_POOL));

    assertEq(EXISTING_TOKEN_POOL.owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(EXISTING_PROXY_POOL.owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(NEW_TOKEN_POOL.owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
  }

  function test_tokenPoolLiquidityMigration() public {
    assertEq(EXISTING_TOKEN_POOL.getRebalancer(), address(0));
    uint256 balance = GHO.balanceOf(address(EXISTING_TOKEN_POOL));
    uint256 bridgedAmount = EXISTING_TOKEN_POOL.getCurrentBridgedAmount();

    assertGt(balance, 0);
    assertGt(bridgedAmount, 0);

    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), 0);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), 0);

    assertEq(bridgedAmount, balance); // bridgedAmountInvariant

    executePayload(vm, address(proposal));

    assertEq(EXISTING_TOKEN_POOL.getRebalancer(), address(NEW_TOKEN_POOL));

    assertEq(GHO.balanceOf(address(EXISTING_TOKEN_POOL)), 0);
    // we do not reset bridgedAmount in the existing token pool, since bridge limit is reset
    assertNotEq(EXISTING_TOKEN_POOL.getCurrentBridgedAmount(), 0);
    assertEq(EXISTING_TOKEN_POOL.getBridgeLimit(), 0);

    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), balance);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), bridgedAmount);
  }

  function test_newTokenPoolSetupAndRegistration() public {
    bytes memory staticParams = _getStaticParams(address(EXISTING_TOKEN_POOL));
    bytes memory dynamicParams = _getDynamicParams(address(EXISTING_TOKEN_POOL));
    assertEq(EXISTING_TOKEN_POOL.getRateLimitAdmin(), address(EXISTING_GHO_CCIP_STEWARD));

    assertEq(TOKEN_ADMIN_REGISTRY.getPool(address(GHO)), EXISTING_TOKEN_POOL.getProxyPool());

    executePayload(vm, address(proposal));

    assertEq(staticParams, _getStaticParams(address(NEW_TOKEN_POOL)));
    assertEq(dynamicParams, _getDynamicParams(address(NEW_TOKEN_POOL)));
    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(NEW_GHO_CCIP_STEWARD));

    assertEq(TOKEN_ADMIN_REGISTRY.getPool(address(GHO)), address(NEW_TOKEN_POOL));

    assertEq(NEW_TOKEN_POOL.getRemotePools(ARB_CHAIN_SELECTOR).length, 2);
    assertTrue(NEW_TOKEN_POOL.isRemotePool(ARB_CHAIN_SELECTOR, abi.encode(ARB_PROXY_POOL)));
    assertTrue(NEW_TOKEN_POOL.isRemotePool(ARB_CHAIN_SELECTOR, abi.encode(NEW_REMOTE_POOL_ARB)));
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ARB_CHAIN_SELECTOR),
      abi.encode(AaveV3ArbitrumAssets.GHO_UNDERLYING)
    );
    assertEq(NEW_TOKEN_POOL.getSupportedChains().length, 1);
    assertTrue(NEW_TOKEN_POOL.isSupportedChain(ARB_CHAIN_SELECTOR));

    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
  }

  function test_newTokenPoolInitialization() public {
    vm.expectRevert('Initializable: contract is already initialized');
    NEW_TOKEN_POOL.initialize(makeAddr('owner'), new address[](0), makeAddr('router'), 13e7);
    assertEq(_readInitialized(address(NEW_TOKEN_POOL)), 1);
    assertEq(_readInitialized(_getImplementation(address(NEW_TOKEN_POOL))), 255);
  }

  function test_stewardRolesAndConfig() public {
    bytes32 RISK_ADMIN_ROLE = AaveV3Ethereum.ACL_MANAGER.RISK_ADMIN_ROLE();
    assertTrue(
      AaveV3Ethereum.ACL_MANAGER.hasRole(RISK_ADMIN_ROLE, address(EXISTING_GHO_AAVE_STEWARD))
    );
    assertFalse(AaveV3Ethereum.ACL_MANAGER.hasRole(RISK_ADMIN_ROLE, address(NEW_GHO_AAVE_STEWARD)));

    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(0));
    assertEq(NEW_TOKEN_POOL.getBridgeLimitAdmin(), address(0));

    executePayload(vm, address(proposal));

    assertFalse(
      AaveV3Ethereum.ACL_MANAGER.hasRole(RISK_ADMIN_ROLE, address(EXISTING_GHO_AAVE_STEWARD))
    );
    assertTrue(AaveV3Ethereum.ACL_MANAGER.hasRole(RISK_ADMIN_ROLE, address(NEW_GHO_AAVE_STEWARD)));

    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(NEW_GHO_CCIP_STEWARD));
    assertEq(NEW_TOKEN_POOL.getBridgeLimitAdmin(), address(NEW_GHO_CCIP_STEWARD));
  }
}

contract AaveV3Ethereum_GHOCCIP151Upgrade_20241209_PostUpgrade is
  AaveV3Ethereum_GHOCCIP151Upgrade_20241209_Base
{
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  function setUp() public override {
    super.setUp();

    executePayload(vm, address(proposal));
  }

  function test_sendMessageSucceedsAndRoutesViaNewPool(uint256 amount) public {
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
    uint256 tokenPoolBalance = GHO.balanceOf(address(NEW_TOKEN_POOL));
    uint256 bridgedAmount = NEW_TOKEN_POOL.getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({amount: amount, sender: alice, poolVersion: CCIPUtils.PoolVersion.V1_5_1})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL)); // new token pool
    emit Locked(address(ON_RAMP), amount);

    vm.expectEmit(address(ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(ARB_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), tokenPoolBalance + amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), bridgedAmount + amount);
  }

  // existing pool can no longer on ramp
  function test_lockOrBurnRevertsOnExistingPool() public {
    uint256 amount = 100_000e18;
    skip(_getOutboundRefillTime(amount));

    // router pulls tokens from the user & sends to the token pool during onRamps
    deal(address(GHO), address(EXISTING_TOKEN_POOL), amount);

    vm.prank(EXISTING_TOKEN_POOL.getProxyPool());
    // since we disable the bridge by resetting the bridge limit to 0
    vm.expectRevert(abi.encodeWithSelector(BridgeLimitExceeded.selector, 0));
    EXISTING_TOKEN_POOL.lockOrBurn(
      alice,
      abi.encode(alice),
      amount,
      ARB_CHAIN_SELECTOR,
      new bytes(0)
    );
  }

  // on-ramp via new pool
  function test_lockOrBurnSucceedsOnNewPool(uint256 amount) public {
    uint256 bridgeableAmount = _min(
      NEW_TOKEN_POOL.getBridgeLimit() - NEW_TOKEN_POOL.getCurrentBridgedAmount(),
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    // router pulls tokens from the user & sends to the token pool during onRamps
    // we don't override NEW_TOKEN_POOL balance here & instead transfer because we want
    // to check the invariant GHO.balanceOf(tokenPool) >= tokenPool.currentBridgedAmount()
    deal(address(GHO), address(alice), amount);
    vm.prank(alice);
    GHO.transfer(address(NEW_TOKEN_POOL), amount);

    uint256 bridgedAmount = NEW_TOKEN_POOL.getCurrentBridgedAmount();

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Locked(address(ON_RAMP), amount);

    vm.prank(address(ON_RAMP));
    NEW_TOKEN_POOL.lockOrBurn(
      IPool_CCIP.LockOrBurnInV1({
        receiver: abi.encode(alice),
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        originalSender: alice,
        amount: amount,
        localToken: address(GHO)
      })
    );

    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), NEW_TOKEN_POOL.getCurrentBridgedAmount());
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), bridgedAmount + amount);
  }

  // existing pool can no longer off ramp
  function test_releaseOrMintRevertsOnExistingPool() public {
    uint256 amount = 100_000e18;
    skip(_getInboundRefillTime(amount));

    assertEq(GHO.balanceOf(address(EXISTING_TOKEN_POOL)), 0);

    vm.prank(EXISTING_TOKEN_POOL.getProxyPool());
    // underflow expected at tokenPool.GHO.transfer() since existing
    // token pool does not hold any gho
    vm.expectRevert(stdError.arithmeticError);
    EXISTING_TOKEN_POOL.releaseOrMint(
      abi.encode(alice),
      alice,
      amount,
      ARB_CHAIN_SELECTOR,
      new bytes(0)
    );
  }

  // off-ramp messages sent from new eth token pool (v1.5.1)
  function test_releaseOrMintSucceedsOnNewPoolOffRampedViaNewTokenPoolEth(uint256 amount) public {
    uint256 bridgeableAmount = _min(
      NEW_TOKEN_POOL.getCurrentBridgedAmount(),
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 tokenPoolBalance = GHO.balanceOf(address(NEW_TOKEN_POOL));
    uint256 bridgedAmount = NEW_TOKEN_POOL.getCurrentBridgedAmount();

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Released(address(OFF_RAMP), alice, amount);

    vm.prank(address(OFF_RAMP));
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

    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), tokenPoolBalance - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), bridgedAmount - amount);
  }

  // off-ramp messages sent from existing arb token pool (v1.4) ie ProxyPool
  function test_releaseOrMintSucceedsOnNewPoolOffRampedViaExistingTokenPoolArb(
    uint256 amount
  ) public {
    uint256 bridgeableAmount = _min(
      NEW_TOKEN_POOL.getCurrentBridgedAmount(),
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 tokenPoolBalance = GHO.balanceOf(address(NEW_TOKEN_POOL));
    uint256 bridgedAmount = NEW_TOKEN_POOL.getCurrentBridgedAmount();

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Released(address(OFF_RAMP), alice, amount);

    vm.prank(address(OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(ARB_PROXY_POOL)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), tokenPoolBalance - amount);
    assertEq(NEW_TOKEN_POOL.getCurrentBridgedAmount(), bridgedAmount - amount);
  }

  function test_ccipStewardCanChangeAndDisableRateLimit() public {
    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(NEW_GHO_CCIP_STEWARD)); // sanity

    IRateLimiter.Config memory outboundConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: 500_000e18,
      rate: 100e18
    });
    IRateLimiter.Config memory inboundConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: 100_000e18,
      rate: 50e18
    });

    // we assert the new steward can change the rate limit
    vm.prank(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL());
    NEW_GHO_CCIP_STEWARD.updateRateLimit(
      ARB_CHAIN_SELECTOR,
      outboundConfig.isEnabled,
      outboundConfig.capacity,
      outboundConfig.rate,
      inboundConfig.isEnabled,
      inboundConfig.capacity,
      inboundConfig.rate
    );

    assertEq(NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR), outboundConfig);
    assertEq(NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR), inboundConfig);
    assertEq(NEW_GHO_CCIP_STEWARD.getCcipTimelocks().rateLimitLastUpdate, vm.getBlockTimestamp());

    skip(NEW_GHO_CCIP_STEWARD.MINIMUM_DELAY() + 1);

    // now we assert the new steward can disable the rate limit
    vm.prank(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL());
    NEW_GHO_CCIP_STEWARD.updateRateLimit(ARB_CHAIN_SELECTOR, false, 0, 0, false, 0, 0);

    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(NEW_GHO_CCIP_STEWARD.getCcipTimelocks().rateLimitLastUpdate, vm.getBlockTimestamp());
  }

  function test_ccipStewardCanSetBridgeLimit(uint256 newBridgeLimit) public {
    uint256 currentBridgeLimit = NEW_TOKEN_POOL.getBridgeLimit();
    vm.assume(
      newBridgeLimit != currentBridgeLimit &&
        _isDifferenceLowerThanMax(currentBridgeLimit, newBridgeLimit, currentBridgeLimit)
    );
    vm.prank(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL());
    NEW_GHO_CCIP_STEWARD.updateBridgeLimit(newBridgeLimit);

    assertEq(NEW_TOKEN_POOL.getBridgeLimit(), newBridgeLimit);
    assertEq(NEW_GHO_CCIP_STEWARD.getCcipTimelocks().bridgeLimitLastUpdate, vm.getBlockTimestamp());
  }

  function test_aaveStewardCanUpdateBorrowRate() public {
    IDefaultInterestRateStrategyV2 irStrategy = IDefaultInterestRateStrategyV2(
      AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getInterestRateStrategyAddress(address(GHO))
    );

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRateData = IDefaultInterestRateStrategyV2.InterestRateData({
        optimalUsageRatio: 99_00,
        baseVariableBorrowRate: 11_50,
        variableRateSlope1: 0,
        variableRateSlope2: 0
      });

    assertEq(irStrategy.getInterestRateDataBps(address(GHO)), currentRateData);

    currentRateData.baseVariableBorrowRate += 4_00;

    vm.prank(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL());
    NEW_GHO_AAVE_STEWARD.updateGhoBorrowRate(
      currentRateData.optimalUsageRatio,
      currentRateData.baseVariableBorrowRate,
      currentRateData.variableRateSlope1,
      currentRateData.variableRateSlope2
    );

    assertEq(irStrategy.getInterestRateDataBps(address(GHO)), currentRateData);
    assertEq(
      NEW_GHO_AAVE_STEWARD.getGhoTimelocks().ghoBorrowRateLastUpdate,
      vm.getBlockTimestamp()
    );
  }

  function test_aaveStewardCanUpdateBorrowCap(uint256 newBorrowCap) public {
    uint256 currentBorrowCap = AaveV3Ethereum.POOL.getConfiguration(address(GHO)).getBorrowCap();
    assertEq(currentBorrowCap, 155_000_000);
    vm.assume(
      newBorrowCap != currentBorrowCap &&
        _isDifferenceLowerThanMax(currentBorrowCap, newBorrowCap, currentBorrowCap)
    );

    vm.prank(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL());
    NEW_GHO_AAVE_STEWARD.updateGhoBorrowCap(newBorrowCap);

    assertEq(AaveV3Ethereum.POOL.getConfiguration(address(GHO)).getBorrowCap(), newBorrowCap);
    assertEq(NEW_GHO_AAVE_STEWARD.getGhoTimelocks().ghoBorrowCapLastUpdate, vm.getBlockTimestamp());

    // @dev gho cannot be supplied on ethereum
    assertEq(AaveV3Ethereum.POOL.getConfiguration(address(GHO)).getSupplyCap(), 0);
  }
}
