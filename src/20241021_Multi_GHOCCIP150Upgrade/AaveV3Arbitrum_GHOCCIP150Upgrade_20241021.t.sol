// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {ITypeAndVersion} from 'src/interfaces/ccip/ITypeAndVersion.sol';
import {IProxyPool} from 'src/interfaces/ccip/IProxyPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IUpgradeableBurnMintTokenPool} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';

import {AaveV3Arbitrum_GHOCCIP150Upgrade_20241021} from './AaveV3Arbitrum_GHOCCIP150Upgrade_20241021.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOCCIP150Upgrade_20241021
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241021_Multi_GHOCCIP150Upgrade/AaveV3Arbitrum_GHOCCIP150Upgrade_20241021.t.sol -vv
 */
contract AaveV3Arbitrum_GHOCCIP150Upgrade_20241021_Test is ProtocolV3TestBase {
  struct CCIPSendParams {
    IRouter router;
    uint256 amount;
    bool migrated;
  }

  AaveV3Arbitrum_GHOCCIP150Upgrade_20241021 internal proposal;
  IUpgradeableBurnMintTokenPool internal ghoTokenPool;
  IProxyPool internal proxyPool;

  address internal alice = makeAddr('alice');

  uint64 internal constant ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 internal constant ARB_CHAIN_SELECTOR = 4949039107694359620;
  address internal constant ARB_GHO_TOKEN = AaveV3ArbitrumAssets.GHO_UNDERLYING;
  address internal constant ETH_PROXY_POOL = 0x9Ec9F9804733df96D1641666818eFb5198eC50f0;
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);

  address internal constant ON_RAMP_1_2 = 0xCe11020D56e5FDbfE46D9FC3021641FfbBB5AdEE;
  address internal constant ON_RAMP_1_5 = 0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3;
  address internal constant OFF_RAMP_1_2 = 0x542ba1902044069330e8c5b36A84EC503863722f;
  address internal constant OFF_RAMP_1_5 = 0x91e46cc5590A4B9182e47f40006140A7077Dec31;

  IGhoCcipSteward internal constant GHO_CCIP_STEWARD =
    IGhoCcipSteward(0xb329CEFF2c362F315900d245eC88afd24C4949D5);

  event Burned(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address caller);
  error NotACompatiblePool(address pool);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 271788784);
    proposal = new AaveV3Arbitrum_GHOCCIP150Upgrade_20241021();
    ghoTokenPool = IUpgradeableBurnMintTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
    proxyPool = IProxyPool(proposal.GHO_CCIP_PROXY_POOL());

    _validateConstants();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    assertEq(
      ghoTokenPool.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(
      ghoTokenPool.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getDisabledConfig()
    );

    bytes memory dynamicParamsBefore = _getDynamicParams();
    bytes memory staticParamsBefore = _getStaticParams();

    defaultTest(
      'AaveV3Arbitrum_GHOCCIP150Upgrade_20241021',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );

    assertEq(keccak256(_getDynamicParams()), keccak256(dynamicParamsBefore));
    assertEq(keccak256(_getStaticParams()), keccak256(staticParamsBefore));

    assertEq(
      ghoTokenPool.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      ghoTokenPool.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
  }

  function test_getProxyPool() public {
    // proxyPool getter does not exist before the upgrade
    vm.expectRevert();
    ghoTokenPool.getProxyPool();

    executePayload(vm, address(proposal));

    assertEq(ghoTokenPool.getProxyPool(), address(proxyPool));
  }

  function test_tokenPoolCannotBeInitializedAgain() public {
    vm.expectRevert('Initializable: contract is already initialized');
    ghoTokenPool.initialize(makeAddr('owner'), new address[](0), makeAddr('router'));
    /// proxy implementation is initialized
    assertEq(_readInitialized(address(ghoTokenPool)), 1);
    assertEq(_readInitialized(_getImplementation(address(ghoTokenPool))), 255);

    executePayload(vm, address(proposal));

    vm.expectRevert('Initializable: contract is already initialized');
    ghoTokenPool.initialize(makeAddr('owner'), new address[](0), makeAddr('router'));
    assertEq(_readInitialized(address(ghoTokenPool)), 1);
    /// proxy implementation is initialized
    assertEq(_readInitialized(_getImplementation(address(ghoTokenPool))), 255);
  }

  function test_sendMessagePreCCIPMigration(uint256 amount) public {
    executePayload(vm, address(proposal));

    IRouter router = IRouter(ghoTokenPool.getRouter());
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);
    uint256 facilitatorLevelBefore = _getFacilitatorLevel(address(ghoTokenPool));

    // wait for the rate limiter to refill
    skip(_getOutboundRefillTime(amount));

    vm.prank(alice);
    IERC20(ARB_GHO_TOKEN).approve(address(router), amount);
    deal(ARB_GHO_TOKEN, alice, amount);

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(CCIPSendParams({router: router, amount: amount, migrated: false}));

    vm.expectEmit(address(ghoTokenPool));
    emit Burned(ON_RAMP_1_2, amount);
    vm.expectEmit(ON_RAMP_1_2);
    emit CCIPSendRequested(eventArg);
    vm.prank(alice);
    router.ccipSend{value: eventArg.feeTokenAmount}(ETH_CHAIN_SELECTOR, message);

    assertEq(IERC20(ARB_GHO_TOKEN).balanceOf(alice), 0);
    assertEq(_getFacilitatorLevel(address(ghoTokenPool)), facilitatorLevelBefore - amount);
  }

  function test_sendMessagePostCCIPMigration(uint256 amount) public {
    executePayload(vm, address(proposal));

    _mockCCIPMigration();

    IRouter router = IRouter(ghoTokenPool.getRouter());
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);
    uint256 facilitatorLevelBefore = _getFacilitatorLevel(address(ghoTokenPool));

    // wait for the rate limiter to refill
    skip(_getOutboundRefillTime(amount));

    vm.prank(alice);
    IERC20(ARB_GHO_TOKEN).approve(address(router), amount);
    deal(ARB_GHO_TOKEN, alice, amount);

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(CCIPSendParams({router: router, amount: amount, migrated: true}));

    vm.expectEmit(address(ghoTokenPool));
    emit Burned(address(proxyPool), amount);
    vm.expectEmit(address(proxyPool));
    emit Burned(ON_RAMP_1_5, amount);
    vm.expectEmit(ON_RAMP_1_5);
    emit CCIPSendRequested(eventArg);
    vm.prank(alice);
    router.ccipSend{value: eventArg.feeTokenAmount}(ETH_CHAIN_SELECTOR, message);

    assertEq(IERC20(ARB_GHO_TOKEN).balanceOf(alice), 0);
    assertEq(_getFacilitatorLevel(address(ghoTokenPool)), facilitatorLevelBefore - amount);
  }

  function test_executeMessagePreCCIPMigration(uint256 amount) public {
    executePayload(vm, address(proposal));

    amount = bound(amount, 1, _getRateLimiterConfig().capacity);
    uint256 facilitatorLevelBefore = _getFacilitatorLevel(address(ghoTokenPool));

    // wait for the rate limiter to refill
    skip(_getInboundRefillTime(amount));

    vm.expectEmit(address(ghoTokenPool));
    emit Minted(OFF_RAMP_1_2, alice, amount);
    vm.prank(OFF_RAMP_1_2);
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ETH_CHAIN_SELECTOR, '');

    assertEq(IERC20(ARB_GHO_TOKEN).balanceOf(alice), amount);
    assertEq(_getFacilitatorLevel(address(ghoTokenPool)), facilitatorLevelBefore + amount);
  }

  function test_executeMessagePostCCIPMigration(uint256 amount) public {
    executePayload(vm, address(proposal));

    _mockCCIPMigration();

    amount = bound(amount, 1, _getRateLimiterConfig().capacity);
    uint256 facilitatorLevelBefore = _getFacilitatorLevel(address(ghoTokenPool));

    // wait for the rate limiter to refill
    skip(_getInboundRefillTime(amount));

    vm.expectEmit(address(ghoTokenPool));
    emit Minted(OFF_RAMP_1_5, alice, amount);
    vm.prank(OFF_RAMP_1_5);
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ETH_CHAIN_SELECTOR, '');

    assertEq(IERC20(ARB_GHO_TOKEN).balanceOf(alice), amount);
    assertEq(_getFacilitatorLevel(address(ghoTokenPool)), facilitatorLevelBefore + amount);
  }

  function test_executeMessagePostCCIPMigrationViaLegacyOffRamp(uint256 amount) public {
    executePayload(vm, address(proposal));

    _mockCCIPMigration();

    amount = bound(amount, 1, _getRateLimiterConfig().capacity);
    uint256 facilitatorLevelBefore = _getFacilitatorLevel(address(ghoTokenPool));

    // wait for the rate limiter to refill
    skip(_getInboundRefillTime(amount));

    vm.expectEmit(address(ghoTokenPool));
    emit Minted(OFF_RAMP_1_2, alice, amount);
    vm.prank(OFF_RAMP_1_2);
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ETH_CHAIN_SELECTOR, '');

    assertEq(IERC20(ARB_GHO_TOKEN).balanceOf(alice), amount);
    assertEq(_getFacilitatorLevel(address(ghoTokenPool)), facilitatorLevelBefore + amount);
  }

  function test_proxyPoolCanOnRamp(uint256 amount) public {
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);

    vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, proxyPool));
    vm.prank(address(proxyPool));
    ghoTokenPool.lockOrBurn(alice, abi.encode(alice), amount, ETH_CHAIN_SELECTOR, new bytes(0));

    executePayload(vm, address(proposal));
    // router is responsible for transferring liquidity, so we mock router.token.transferFrom(user, tokenPool)
    deal(ARB_GHO_TOKEN, address(ghoTokenPool), amount);
    uint256 facilitatorLevelBefore = _getFacilitatorLevel(address(ghoTokenPool));

    // wait for the rate limiter to refill
    skip(_getOutboundRefillTime(amount));

    vm.expectEmit(address(ghoTokenPool));
    emit Burned(address(proxyPool), amount);
    vm.prank(address(proxyPool));
    ghoTokenPool.lockOrBurn(alice, abi.encode(alice), amount, ETH_CHAIN_SELECTOR, new bytes(0));

    assertEq(IERC20(ARB_GHO_TOKEN).balanceOf(alice), 0);
    assertEq(_getFacilitatorLevel(address(ghoTokenPool)), facilitatorLevelBefore - amount);
  }

  function test_proxyPoolCanOffRamp(uint256 amount) public {
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);

    vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, proxyPool));
    vm.prank(address(proxyPool));
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ETH_CHAIN_SELECTOR, new bytes(0));

    executePayload(vm, address(proposal));
    uint256 facilitatorLevelBefore = _getFacilitatorLevel(address(ghoTokenPool));

    // wait for the rate limiter to refill
    skip(_getInboundRefillTime(amount));

    vm.expectEmit(address(ghoTokenPool));
    emit Minted(address(proxyPool), alice, amount);
    vm.prank(address(proxyPool));
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ETH_CHAIN_SELECTOR, new bytes(0));

    assertEq(IERC20(ARB_GHO_TOKEN).balanceOf(alice), amount);
    assertEq(_getFacilitatorLevel(address(ghoTokenPool)), facilitatorLevelBefore + amount);
  }

  function test_stewardCanDisableRateLimit() public {
    executePayload(vm, address(proposal));

    assertEq(ghoTokenPool.getRateLimitAdmin(), address(GHO_CCIP_STEWARD));

    vm.prank(GHO_CCIP_STEWARD.RISK_COUNCIL());
    GHO_CCIP_STEWARD.updateRateLimit(ETH_CHAIN_SELECTOR, false, 0, 0, false, 0, 0);

    assertEq(
      abi.encode(
        _tokenBucketToConfig(ghoTokenPool.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR))
      ),
      abi.encode(_getDisabledConfig())
    );
    assertEq(
      abi.encode(
        _tokenBucketToConfig(ghoTokenPool.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR))
      ),
      abi.encode(_getDisabledConfig())
    );
  }

  function test_ownershipTransferOfGhoProxyPool() public {
    executePayload(vm, address(proposal));
    _mockCCIPMigration();

    assertEq(ghoTokenPool.owner(), AaveV3Arbitrum.ACL_ADMIN);

    // CLL team transfers ownership of proxyPool and GHO token in TokenAdminRegistry
    vm.prank(proxyPool.owner());
    proxyPool.transferOwnership(AaveV3Arbitrum.ACL_ADMIN);
    vm.prank(TOKEN_ADMIN_REGISTRY.owner());
    TOKEN_ADMIN_REGISTRY.transferAdminRole(ARB_GHO_TOKEN, AaveV3Arbitrum.ACL_ADMIN);

    // new AIP to accept ownership
    vm.startPrank(AaveV3Arbitrum.ACL_ADMIN);
    proxyPool.acceptOwnership();
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(ARB_GHO_TOKEN);
    vm.stopPrank();

    assertEq(proxyPool.owner(), AaveV3Arbitrum.ACL_ADMIN);
    assertTrue(TOKEN_ADMIN_REGISTRY.isAdministrator(ARB_GHO_TOKEN, AaveV3Arbitrum.ACL_ADMIN));
  }

  function _mockCCIPMigration() private {
    IRouter router = IRouter(ghoTokenPool.getRouter());

    assertEq(TOKEN_ADMIN_REGISTRY.getPool(ARB_GHO_TOKEN), address(proxyPool));

    assertEq(proxyPool.getRouter(), address(router));

    assertTrue(proxyPool.isSupportedChain(ETH_CHAIN_SELECTOR));
    assertEq(proxyPool.getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR), _getDisabledConfig());
    assertEq(
      proxyPool.getCurrentOutboundRateLimiterState(ETH_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(proxyPool.getRemotePool(ETH_CHAIN_SELECTOR), abi.encode(ETH_PROXY_POOL));
    assertEq(proxyPool.getRemoteToken(ETH_CHAIN_SELECTOR), abi.encode(MiscEthereum.GHO_TOKEN));

    IRouter.OnRamp[] memory onRampUpdates = new IRouter.OnRamp[](1);
    onRampUpdates[0] = IRouter.OnRamp({
      destChainSelector: ETH_CHAIN_SELECTOR,
      onRamp: ON_RAMP_1_5 // new onRamp
    });
    IRouter.OffRamp[] memory offRampUpdates = new IRouter.OffRamp[](1);
    offRampUpdates[0] = IRouter.OffRamp({
      sourceChainSelector: ARB_CHAIN_SELECTOR,
      offRamp: OFF_RAMP_1_5 // new offRamp
    });

    vm.prank(router.owner());
    router.applyRampUpdates(onRampUpdates, new IRouter.OffRamp[](0), offRampUpdates);
  }

  function _getTokenMessage(
    CCIPSendParams memory params
  ) internal returns (IClient.EVM2AnyMessage memory, IInternal.EVM2EVMMessage memory) {
    IClient.EVM2AnyMessage memory message = CCIPUtils.generateMessage(alice, 1);
    message.tokenAmounts[0] = IClient.EVMTokenAmount({token: ARB_GHO_TOKEN, amount: params.amount});

    uint256 feeAmount = params.router.getFee(ETH_CHAIN_SELECTOR, message);
    deal(alice, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: params.router,
        sourceChainSelector: ARB_CHAIN_SELECTOR,
        feeTokenAmount: feeAmount,
        originalSender: alice,
        destinationToken: MiscEthereum.GHO_TOKEN,
        migrated: params.migrated
      })
    );

    return (message, eventArg);
  }

  function _getImplementation(address proxy) private view returns (address) {
    bytes32 slot = bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1);
    return address(uint160(uint256(vm.load(proxy, slot))));
  }

  function _readInitialized(address proxy) private view returns (uint8) {
    /// slot 0
    // <1 byte ^ 1 byte ^ ---------- 20 bytes ---------->
    // initialized initializing       owner
    return uint8(uint256(vm.load(proxy, bytes32(0))));
  }

  function _getFacilitatorLevel(address f) internal view returns (uint256) {
    (, uint256 level) = IGhoToken(ARB_GHO_TOKEN).getFacilitatorBucket(f);
    return level;
  }

  function _getStaticParams() private view returns (bytes memory) {
    return
      abi.encode(
        address(ghoTokenPool.getToken()),
        ghoTokenPool.getAllowList(),
        ghoTokenPool.getArmProxy(),
        ghoTokenPool.getRouter()
      );
  }

  function _getDynamicParams() private view returns (bytes memory) {
    return
      abi.encode(
        ghoTokenPool.owner(),
        ghoTokenPool.getSupportedChains(),
        ghoTokenPool.getAllowListEnabled(),
        ghoTokenPool.getRateLimitAdmin()
      );
  }

  function _validateConstants() private view {
    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(proxyPool.typeAndVersion(), 'BurnMintTokenPoolAndProxy 1.5.0');
    assertEq(ITypeAndVersion(ON_RAMP_1_2).typeAndVersion(), 'EVM2EVMOnRamp 1.2.0');
    assertEq(ITypeAndVersion(ON_RAMP_1_5).typeAndVersion(), 'EVM2EVMOnRamp 1.5.0');
    assertEq(ITypeAndVersion(OFF_RAMP_1_2).typeAndVersion(), 'EVM2EVMOffRamp 1.2.0');
    assertEq(ITypeAndVersion(OFF_RAMP_1_5).typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');

    assertEq(GHO_CCIP_STEWARD.GHO_TOKEN(), ARB_GHO_TOKEN);
    assertEq(GHO_CCIP_STEWARD.GHO_TOKEN_POOL(), address(ghoTokenPool));

    assertEq(proxyPool.getPreviousPool(), address(ghoTokenPool));
  }

  function _getOutboundRefillTime(uint256 amount) private view returns (uint256) {
    uint128 rate = _getRateLimiterConfig().rate;
    assertNotEq(rate, 0);
    return amount / uint256(rate) + 1; // account for rounding
  }

  function _getInboundRefillTime(uint256 amount) private view returns (uint256) {
    uint128 rate = _getRateLimiterConfig().rate;
    assertNotEq(rate, 0);
    return amount / uint256(rate) + 1; // account for rounding
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

  function _getDisabledConfig() private pure returns (IRateLimiter.Config memory) {
    return IRateLimiter.Config({isEnabled: false, capacity: 0, rate: 0});
  }

  function assertEq(
    IRateLimiter.TokenBucket memory bucket,
    IRateLimiter.Config memory config
  ) internal pure {
    assertEq(abi.encode(_tokenBucketToConfig(bucket)), abi.encode(config));
  }

  function _getRateLimiterConfig() internal view returns (IRateLimiter.Config memory) {
    return
      IRateLimiter.Config({
        isEnabled: true,
        capacity: proposal.CCIP_RATE_LIMIT_CAPACITY(),
        rate: proposal.CCIP_RATE_LIMIT_REFILL_RATE()
      });
  }
}
