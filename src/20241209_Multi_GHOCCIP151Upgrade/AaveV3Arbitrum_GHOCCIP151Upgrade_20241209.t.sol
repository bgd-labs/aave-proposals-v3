// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableBurnMintTokenPool_1_4, IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
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
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';
import {DataTypes, IDefaultInterestRateStrategyV2} from 'aave-address-book/AaveV3.sol';

import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';

import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';
import {AaveV3Arbitrum_GHOCCIP151Upgrade_20241209} from './AaveV3Arbitrum_GHOCCIP151Upgrade_20241209.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOCCIP151Upgrade_20241209
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241209_Multi_GHOCCIP151Upgrade/AaveV3Arbitrum_GHOCCIP151Upgrade_20241209.t.sol -vv
 */
contract AaveV3Arbitrum_GHOCCIP151Upgrade_20241209_Base is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    CCIPUtils.PoolVersion poolVersion;
  }

  uint64 internal constant ETH_CHAIN_SELECTOR = CCIPUtils.ETH_CHAIN_SELECTOR;
  uint64 internal constant ARB_CHAIN_SELECTOR = CCIPUtils.ARB_CHAIN_SELECTOR;
  uint256 internal constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  uint256 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  IGhoToken internal constant GHO = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);
  address internal constant ETH_PROXY_POOL = 0x9Ec9F9804733df96D1641666818eFb5198eC50f0;
  IEVM2EVMOnRamp internal constant ON_RAMP =
    IEVM2EVMOnRamp(0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3);
  IEVM2EVMOffRamp_1_5 internal constant OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0x91e46cc5590A4B9182e47f40006140A7077Dec31);
  IRouter internal constant ROUTER = IRouter(0x141fa059441E0ca23ce184B6A78bafD2A517DdE8);

  IGhoAaveSteward public constant EXISTING_GHO_AAVE_STEWARD =
    IGhoAaveSteward(0xCd04D93bEA13921DaD05240D577090b5AC36DfCA);
  IGhoAaveSteward public constant NEW_GHO_AAVE_STEWARD =
    IGhoAaveSteward(0xd2D586f849620ef042FE3aF52eAa10e9b78bf7De);
  IGhoBucketSteward internal constant GHO_BUCKET_STEWARD =
    IGhoBucketSteward(0xa9afaE6A53E90f9E4CE0717162DF5Bc3d9aBe7B2);
  IGhoCcipSteward internal constant EXISTING_GHO_CCIP_STEWARD =
    IGhoCcipSteward(0xb329CEFF2c362F315900d245eC88afd24C4949D5);
  IGhoCcipSteward internal constant NEW_GHO_CCIP_STEWARD =
    IGhoCcipSteward(0xCd5ab470AaC5c13e1063ee700503f3346b7C90Db);

  IProxyPool internal constant EXISTING_PROXY_POOL =
    IProxyPool(0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50);
  IUpgradeableBurnMintTokenPool_1_4 internal constant EXISTING_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_4(0xF168B83598516A532a85995b52504a2Fa058C068); // GhoArbitrum.GHO_CCIP_TOKEN_POOL; will be updated in address-book after AIP
  IUpgradeableBurnMintTokenPool_1_5_1 internal constant NEW_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB);
  address internal constant NEW_REMOTE_POOL_ETH = 0x06179f7C1be40863405f374E7f5F8806c728660A;

  AaveV3Arbitrum_GHOCCIP151Upgrade_20241209 internal proposal;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Burned(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 293994020);
    proposal = new AaveV3Arbitrum_GHOCCIP151Upgrade_20241209();
    _validateConstants();
  }

  function _validateConstants() private view {
    assertEq(address(proposal.TOKEN_ADMIN_REGISTRY()), address(TOKEN_ADMIN_REGISTRY));
    assertEq(proposal.ETH_CHAIN_SELECTOR(), ETH_CHAIN_SELECTOR);
    assertEq(address(proposal.EXISTING_PROXY_POOL()), address(EXISTING_PROXY_POOL));
    assertEq(address(proposal.EXISTING_TOKEN_POOL()), address(EXISTING_TOKEN_POOL));
    assertEq(address(proposal.EXISTING_REMOTE_POOL_ETH()), ETH_PROXY_POOL);
    assertEq(address(proposal.NEW_TOKEN_POOL()), address(NEW_TOKEN_POOL));
    assertEq(address(proposal.EXISTING_GHO_AAVE_STEWARD()), address(EXISTING_GHO_AAVE_STEWARD));
    assertEq(address(proposal.NEW_GHO_AAVE_STEWARD()), address(NEW_GHO_AAVE_STEWARD));
    assertEq(address(proposal.GHO_BUCKET_STEWARD()), address(GHO_BUCKET_STEWARD));
    assertEq(address(proposal.NEW_GHO_CCIP_STEWARD()), address(NEW_GHO_CCIP_STEWARD));
    assertEq(address(proposal.NEW_REMOTE_POOL_ETH()), NEW_REMOTE_POOL_ETH);
    assertEq(proposal.CCIP_RATE_LIMIT_CAPACITY(), CCIP_RATE_LIMIT_CAPACITY);
    assertEq(proposal.CCIP_RATE_LIMIT_REFILL_RATE(), CCIP_RATE_LIMIT_REFILL_RATE);

    assertEq(address(proposal.EXISTING_PROXY_POOL()), EXISTING_TOKEN_POOL.getProxyPool());

    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(NEW_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(EXISTING_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.4.0');
    assertEq(
      ITypeAndVersion(EXISTING_TOKEN_POOL.getProxyPool()).typeAndVersion(),
      'BurnMintTokenPoolAndProxy 1.5.0'
    );
    assertEq(ON_RAMP.typeAndVersion(), 'EVM2EVMOnRamp 1.5.0');
    assertEq(OFF_RAMP.typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');

    assertEq(ROUTER.typeAndVersion(), 'Router 1.2.0');
    assertEq(EXISTING_TOKEN_POOL.getRouter(), address(ROUTER));

    assertEq(ROUTER.getOnRamp(ETH_CHAIN_SELECTOR), address(ON_RAMP));
    assertTrue(ROUTER.isOffRamp(ETH_CHAIN_SELECTOR, address(OFF_RAMP)));

    assertEq(EXISTING_TOKEN_POOL.getRateLimitAdmin(), address(EXISTING_GHO_CCIP_STEWARD));

    assertTrue(
      AaveV3Arbitrum.ACL_MANAGER.hasRole(
        AaveV3Arbitrum.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(EXISTING_GHO_AAVE_STEWARD)
      )
    );

    assertTrue(GHO.hasRole(GHO.BUCKET_MANAGER_ROLE(), address(GHO_BUCKET_STEWARD)));

    assertEq(IOwnable(address(NEW_GHO_AAVE_STEWARD)).owner(), GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_ADDRESSES_PROVIDER(),
      address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER)
    );
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_DATA_PROVIDER(),
      address(AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER)
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
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN(), AaveV3ArbitrumAssets.GHO_UNDERLYING);
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN_POOL(), address(NEW_TOKEN_POOL));
    assertFalse(NEW_GHO_CCIP_STEWARD.BRIDGE_LIMIT_ENABLED()); // *not present* on remote token pool, only on eth
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
      token: AaveV3ArbitrumAssets.GHO_UNDERLYING,
      amount: params.amount
    });

    uint256 feeAmount = ROUTER.getFee(ETH_CHAIN_SELECTOR, message);
    deal(params.sender, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: ROUTER,
        sourceChainSelector: ARB_CHAIN_SELECTOR,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: AaveV3ArbitrumAssets.GHO_UNDERLYING,
        destinationToken: AaveV3EthereumAssets.GHO_UNDERLYING,
        poolVersion: params.poolVersion
      })
    );

    return (message, eventArg);
  }

  function _getStaticParams(address tokenPool) internal view returns (bytes memory) {
    IUpgradeableBurnMintTokenPool_1_4 ghoTokenPool = IUpgradeableBurnMintTokenPool_1_4(tokenPool);
    return
      abi.encode(
        ghoTokenPool.getToken(),
        ghoTokenPool.getAllowListEnabled(),
        ghoTokenPool.getAllowList(),
        ghoTokenPool.getRouter()
      );
  }

  function _getDynamicParams(address tokenPool) internal view returns (bytes memory) {
    IUpgradeableBurnMintTokenPool_1_4 ghoTokenPool = IUpgradeableBurnMintTokenPool_1_4(tokenPool);
    return abi.encode(ghoTokenPool.owner(), ghoTokenPool.getSupportedChains());
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

contract AaveV3Arbitrum_GHOCCIP151Upgrade_20241209_SetupAndProposalActions is
  AaveV3Arbitrum_GHOCCIP151Upgrade_20241209_Base
{
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_GHOCCIP151Upgrade_20241209',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_tokenPoolOwnershipTransfer() public {
    assertFalse(
      TOKEN_ADMIN_REGISTRY.isAdministrator(address(GHO), GovernanceV3Arbitrum.EXECUTOR_LVL_1)
    );
    ITokenAdminRegistry.TokenConfig memory tokenConfig = TOKEN_ADMIN_REGISTRY.getTokenConfig(
      address(GHO)
    );
    assertNotEq(tokenConfig.administrator, GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    assertEq(tokenConfig.pendingAdministrator, GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    assertEq(tokenConfig.tokenPool, address(EXISTING_PROXY_POOL));

    assertEq(EXISTING_TOKEN_POOL.owner(), GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    assertEq(EXISTING_PROXY_POOL.owner(), TOKEN_ADMIN_REGISTRY.owner());
    assertEq(NEW_TOKEN_POOL.owner(), address(0));

    executePayload(vm, address(proposal));

    tokenConfig = TOKEN_ADMIN_REGISTRY.getTokenConfig(address(GHO));
    assertEq(tokenConfig.administrator, GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    assertEq(tokenConfig.pendingAdministrator, address(0));
    assertEq(tokenConfig.tokenPool, address(NEW_TOKEN_POOL));

    assertEq(EXISTING_TOKEN_POOL.owner(), GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    assertEq(EXISTING_PROXY_POOL.owner(), GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    assertEq(NEW_TOKEN_POOL.owner(), GovernanceV3Arbitrum.EXECUTOR_LVL_1);
  }

  function test_tokenPoolLiquidityMigration() public {
    IGhoToken.Facilitator memory existingFacilitator = GHO.getFacilitator(
      address(EXISTING_TOKEN_POOL)
    );
    IGhoToken.Facilitator memory newFacilitator = GHO.getFacilitator(address(NEW_TOKEN_POOL));

    assertEq(bytes(newFacilitator.label).length, 0);
    assertEq(newFacilitator.bucketCapacity, 0);
    assertEq(newFacilitator.bucketLevel, 0);

    assertEq(existingFacilitator.label, 'CCIP TokenPool');
    assertGt(existingFacilitator.bucketCapacity, 0);
    assertGt(existingFacilitator.bucketLevel, 0);

    executePayload(vm, address(proposal));

    newFacilitator = GHO.getFacilitator(address(NEW_TOKEN_POOL));

    assertEq(newFacilitator.label, 'CCIP TokenPool v1.5.1');
    assertEq(newFacilitator.bucketCapacity, existingFacilitator.bucketCapacity);
    assertEq(newFacilitator.bucketLevel, existingFacilitator.bucketLevel);

    existingFacilitator = GHO.getFacilitator(address(EXISTING_TOKEN_POOL));

    assertEq(bytes(existingFacilitator.label).length, 0);
    assertEq(existingFacilitator.bucketCapacity, 0);
    assertEq(existingFacilitator.bucketLevel, 0);
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

    assertEq(NEW_TOKEN_POOL.getRemotePools(ETH_CHAIN_SELECTOR).length, 2);
    assertTrue(NEW_TOKEN_POOL.isRemotePool(ETH_CHAIN_SELECTOR, abi.encode(ETH_PROXY_POOL)));
    assertTrue(NEW_TOKEN_POOL.isRemotePool(ETH_CHAIN_SELECTOR, abi.encode(NEW_REMOTE_POOL_ETH)));
    assertEq(
      NEW_TOKEN_POOL.getRemoteToken(ETH_CHAIN_SELECTOR),
      abi.encode(AaveV3EthereumAssets.GHO_UNDERLYING)
    );
    assertEq(NEW_TOKEN_POOL.getSupportedChains().length, 1);
    assertTrue(NEW_TOKEN_POOL.isSupportedChain(ETH_CHAIN_SELECTOR));

    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
  }

  function test_newTokenPoolInitialization() public {
    vm.expectRevert('Initializable: contract is already initialized');
    NEW_TOKEN_POOL.initialize(makeAddr('owner'), new address[](0), makeAddr('router'));
    assertEq(_readInitialized(address(NEW_TOKEN_POOL)), 1);
    assertEq(_readInitialized(_getImplementation(address(NEW_TOKEN_POOL))), 255);
  }

  function test_stewardRolesAndConfig() public {
    bytes32 RISK_ADMIN_ROLE = AaveV3Arbitrum.ACL_MANAGER.RISK_ADMIN_ROLE();
    assertTrue(
      AaveV3Arbitrum.ACL_MANAGER.hasRole(RISK_ADMIN_ROLE, address(EXISTING_GHO_AAVE_STEWARD))
    );
    assertFalse(AaveV3Arbitrum.ACL_MANAGER.hasRole(RISK_ADMIN_ROLE, address(NEW_GHO_AAVE_STEWARD)));

    assertEq(GHO_BUCKET_STEWARD.getControlledFacilitators().length, 1);
    assertTrue(GHO_BUCKET_STEWARD.isControlledFacilitator(address(EXISTING_TOKEN_POOL)));
    assertFalse(GHO_BUCKET_STEWARD.isControlledFacilitator(address(NEW_TOKEN_POOL)));

    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(0));

    executePayload(vm, address(proposal));

    assertFalse(
      AaveV3Arbitrum.ACL_MANAGER.hasRole(RISK_ADMIN_ROLE, address(EXISTING_GHO_AAVE_STEWARD))
    );
    assertTrue(AaveV3Arbitrum.ACL_MANAGER.hasRole(RISK_ADMIN_ROLE, address(NEW_GHO_AAVE_STEWARD)));

    assertEq(GHO_BUCKET_STEWARD.getControlledFacilitators().length, 1);
    assertFalse(GHO_BUCKET_STEWARD.isControlledFacilitator(address(EXISTING_TOKEN_POOL)));
    assertTrue(GHO_BUCKET_STEWARD.isControlledFacilitator(address(NEW_TOKEN_POOL)));

    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(NEW_GHO_CCIP_STEWARD));
  }
}

contract AaveV3Arbitrum_GHOCCIP151Upgrade_20241209_PostUpgrade is
  AaveV3Arbitrum_GHOCCIP151Upgrade_20241209_Base
{
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  function setUp() public override {
    super.setUp();

    executePayload(vm, address(proposal));
  }

  function test_sendMessageSucceedsAndRoutesViaNewPool(uint256 amount) public {
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
        CCIPSendParams({amount: amount, sender: alice, poolVersion: CCIPUtils.PoolVersion.V1_5_1})
      );

    vm.expectEmit(address(NEW_TOKEN_POOL)); // new token pool
    emit Burned(address(ON_RAMP), amount);

    vm.expectEmit(address(ON_RAMP));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    ROUTER.ccipSend{value: eventArg.feeTokenAmount}(ETH_CHAIN_SELECTOR, message);

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
  }

  // existing pool can no longer on ramp
  function test_lockOrBurnRevertsOnExistingPool() public {
    uint256 amount = 100_000e18;
    skip(_getOutboundRefillTime(amount));

    // router pulls tokens from the user & sends to the token pool during onRamps
    deal(address(GHO), address(EXISTING_TOKEN_POOL), amount);

    vm.prank(EXISTING_TOKEN_POOL.getProxyPool());
    // underflow expected at GHO.burn() => bucketLevel - amount
    vm.expectRevert(stdError.arithmeticError);
    EXISTING_TOKEN_POOL.lockOrBurn(
      alice,
      abi.encode(alice),
      amount,
      ETH_CHAIN_SELECTOR,
      new bytes(0)
    );
  }

  // on-ramp via new pool
  function test_lockOrBurnSucceedsOnNewPool(uint256 amount) public {
    uint256 bridgeableAmount = _min(
      GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel,
      CCIP_RATE_LIMIT_CAPACITY
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount));

    // router pulls tokens from the user & sends to the token pool during onRamps
    deal(address(GHO), address(NEW_TOKEN_POOL), amount);

    uint256 bucketLevel = GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Burned(address(ON_RAMP), amount);

    vm.prank(address(ON_RAMP));
    NEW_TOKEN_POOL.lockOrBurn(
      IPool_CCIP.LockOrBurnInV1({
        receiver: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        originalSender: alice,
        amount: amount,
        localToken: address(GHO)
      })
    );

    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
    assertEq(GHO.balanceOf(address(NEW_TOKEN_POOL)), 0); // dealt amount is burned
  }

  // existing pool can no longer off ramp
  function test_releaseOrMintRevertsOnExistingPool() public {
    uint256 amount = 100_000e18;
    skip(_getInboundRefillTime(amount)); // wait for the rate limiter to refill

    vm.prank(EXISTING_TOKEN_POOL.getProxyPool());
    vm.expectRevert('FACILITATOR_BUCKET_CAPACITY_EXCEEDED');
    EXISTING_TOKEN_POOL.releaseOrMint(
      abi.encode(alice),
      alice,
      amount,
      ETH_CHAIN_SELECTOR,
      new bytes(0)
    );
  }

  // off-ramp messages sent from new eth token pool (v1.5.1)
  function test_releaseOrMintSucceedsOnNewPoolOffRampedViaNewTokenPoolEth(uint256 amount) public {
    (uint256 bucketCapacity, uint256 bucketLevel) = GHO.getFacilitatorBucket(
      address(NEW_TOKEN_POOL)
    );
    uint256 mintAbleAmount = _min(bucketCapacity - bucketLevel, CCIP_RATE_LIMIT_CAPACITY);
    amount = bound(amount, 1, mintAbleAmount);
    skip(_getInboundRefillTime(amount)); // wait for the rate limiter to refill

    uint256 aliceBalance = GHO.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(OFF_RAMP), alice, amount);

    vm.prank(address(OFF_RAMP));
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

  // off-ramp messages sent from existing eth token pool (v1.4) ie ProxyPool
  function test_releaseOrMintSucceedsOnNewPoolOffRampedViaExistingTokenPoolEth(
    uint256 amount
  ) public {
    (uint256 bucketCapacity, uint256 bucketLevel) = GHO.getFacilitatorBucket(
      address(NEW_TOKEN_POOL)
    );
    uint256 mintAbleAmount = _min(bucketCapacity - bucketLevel, CCIP_RATE_LIMIT_CAPACITY);
    amount = bound(amount, 1, mintAbleAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = GHO.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(OFF_RAMP), alice, amount);

    vm.prank(address(OFF_RAMP));
    NEW_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(ETH_PROXY_POOL)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel + amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
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

    // we assert the steward can change the rate limit
    vm.prank(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL());
    NEW_GHO_CCIP_STEWARD.updateRateLimit(
      ETH_CHAIN_SELECTOR,
      outboundConfig.isEnabled,
      outboundConfig.capacity,
      outboundConfig.rate,
      inboundConfig.isEnabled,
      inboundConfig.capacity,
      inboundConfig.rate
    );

    assertEq(NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR), outboundConfig);
    assertEq(NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR), inboundConfig);
    assertEq(NEW_GHO_CCIP_STEWARD.getCcipTimelocks().rateLimitLastUpdate, vm.getBlockTimestamp());

    skip(NEW_GHO_CCIP_STEWARD.MINIMUM_DELAY() + 1);

    // now we assert the steward can disable the rate limit
    vm.prank(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL());
    NEW_GHO_CCIP_STEWARD.updateRateLimit(ETH_CHAIN_SELECTOR, false, 0, 0, false, 0, 0);

    assertEq(
      NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(
      NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(NEW_GHO_CCIP_STEWARD.getCcipTimelocks().rateLimitLastUpdate, vm.getBlockTimestamp());
  }

  function test_aaveStewardCanUpdateBorrowRate() public {
    IDefaultInterestRateStrategyV2 irStrategy = IDefaultInterestRateStrategyV2(
      AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getInterestRateStrategyAddress(address(GHO))
    );

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRateData = IDefaultInterestRateStrategyV2.InterestRateData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 12_50,
        variableRateSlope2: 40_00
      });

    assertEq(irStrategy.getInterestRateDataBps(address(GHO)), currentRateData);

    currentRateData.variableRateSlope1 -= 4_00;
    currentRateData.variableRateSlope2 -= 3_00;

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
    uint256 currentBorrowCap = AaveV3Arbitrum.POOL.getConfiguration(address(GHO)).getBorrowCap();
    assertEq(currentBorrowCap, 22_500_000);
    vm.assume(
      newBorrowCap != currentBorrowCap &&
        _isDifferenceLowerThanMax(currentBorrowCap, newBorrowCap, currentBorrowCap)
    );

    vm.prank(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL());
    NEW_GHO_AAVE_STEWARD.updateGhoBorrowCap(newBorrowCap);

    assertEq(AaveV3Arbitrum.POOL.getConfiguration(address(GHO)).getBorrowCap(), newBorrowCap);
    assertEq(NEW_GHO_AAVE_STEWARD.getGhoTimelocks().ghoBorrowCapLastUpdate, vm.getBlockTimestamp());
  }

  function test_aaveStewardCanUpdateSupplyCap(uint256 newSupplyCap) public {
    uint256 currentSupplyCap = AaveV3Arbitrum.POOL.getConfiguration(address(GHO)).getSupplyCap();
    assertEq(currentSupplyCap, 25_000_000);
    vm.assume(
      currentSupplyCap != newSupplyCap &&
        _isDifferenceLowerThanMax(currentSupplyCap, newSupplyCap, currentSupplyCap)
    );

    vm.prank(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL());
    NEW_GHO_AAVE_STEWARD.updateGhoSupplyCap(newSupplyCap);

    assertEq(AaveV3Arbitrum.POOL.getConfiguration(address(GHO)).getSupplyCap(), newSupplyCap);
    assertEq(NEW_GHO_AAVE_STEWARD.getGhoTimelocks().ghoSupplyCapLastUpdate, vm.getBlockTimestamp());
  }
}
