// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {ITypeAndVersion} from 'src/interfaces/ccip/ITypeAndVersion.sol';
import {IProxyPool} from 'src/interfaces/ccip/IProxyPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';
import {AaveV3Ethereum_GHOCCIP150Upgrade_20241021} from './AaveV3Ethereum_GHOCCIP150Upgrade_20241021.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOCCIP150Upgrade_20241021
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241021_Multi_GHOCCIP150Upgrade/AaveV3Ethereum_GHOCCIP150Upgrade_20241021.t.sol -vv
 */
contract AaveV3Ethereum_GHOCCIP150Upgrade_20241021_Test is ProtocolV3TestBase {
  struct CCIPSendParams {
    IRouter router;
    uint256 amount;
    bool migrated;
  }

  AaveV3Ethereum_GHOCCIP150Upgrade_20241021 internal proposal;
  IUpgradeableLockReleaseTokenPool internal ghoTokenPool;
  IProxyPool internal proxyPool;

  address internal alice = makeAddr('alice');

  uint64 internal constant ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 internal constant ARB_CHAIN_SELECTOR = 4949039107694359620;
  address internal constant ARB_PROXY_POOL = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50;
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);

  address internal constant ON_RAMP_1_2 = 0x925228D7B82d883Dde340A55Fe8e6dA56244A22C;
  address internal constant ON_RAMP_1_5 = 0x69eCC4E2D8ea56E2d0a05bF57f4Fd6aEE7f2c284;
  address internal constant OFF_RAMP_1_2 = 0xeFC4a18af59398FF23bfe7325F2401aD44286F4d;
  address internal constant OFF_RAMP_1_5 = 0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9;

  IGhoCcipSteward internal constant GHO_CCIP_STEWARD =
    IGhoCcipSteward(0x101Efb7b9Beb073B1219Cd5473a7C8A2f2EB84f4);

  event Locked(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address caller);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21131872);
    proposal = new AaveV3Ethereum_GHOCCIP150Upgrade_20241021();
    ghoTokenPool = IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL);
    proxyPool = IProxyPool(proposal.GHO_CCIP_PROXY_POOL());

    _validateConstants();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    assertEq(
      ghoTokenPool.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(
      ghoTokenPool.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getDisabledConfig()
    );

    bytes memory dynamicParamsBefore = _getDynamicParams();
    bytes memory staticParamsBefore = _getStaticParams();

    defaultTest(
      'AaveV3Ethereum_GHOCCIP150Upgrade_20241021',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    assertEq(keccak256(_getDynamicParams()), keccak256(dynamicParamsBefore));
    assertEq(keccak256(_getStaticParams()), keccak256(staticParamsBefore));

    assertEq(
      ghoTokenPool.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      ghoTokenPool.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR),
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
    ghoTokenPool.initialize(makeAddr('owner'), new address[](0), makeAddr('router'), 0);
    assertEq(_readInitialized(address(ghoTokenPool)), 1);
    /// proxy implementation is initialized
    assertEq(_readInitialized(_getImplementation(address(ghoTokenPool))), 255);

    executePayload(vm, address(proposal));

    vm.expectRevert('Initializable: contract is already initialized');
    ghoTokenPool.initialize(makeAddr('owner'), new address[](0), makeAddr('router'), 0);
    assertEq(_readInitialized(address(ghoTokenPool)), 1);
    /// proxy implementation is initialized
    assertEq(_readInitialized(_getImplementation(address(ghoTokenPool))), 255);
  }

  function test_sendMessagePreCCIPMigration(uint256 amount) public {
    executePayload(vm, address(proposal));

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    IRouter router = IRouter(ghoTokenPool.getRouter());
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);

    // wait for the rate limiter to refill
    skip(_getOutboundRefillTime(amount));

    vm.prank(alice);
    gho.approve(address(router), amount);
    deal(address(gho), alice, amount);

    uint256 tokenPoolBalance = gho.balanceOf(address(ghoTokenPool));
    uint256 bridgedAmount = ghoTokenPool.getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(CCIPSendParams({router: router, amount: amount, migrated: false}));

    vm.expectEmit(address(ghoTokenPool));
    emit Locked(ON_RAMP_1_2, amount);
    vm.expectEmit(ON_RAMP_1_2);
    emit CCIPSendRequested(eventArg);
    vm.prank(alice);
    router.ccipSend{value: eventArg.feeTokenAmount}(ARB_CHAIN_SELECTOR, message);

    assertEq(gho.balanceOf(address(ghoTokenPool)), tokenPoolBalance + amount);
    assertEq(ghoTokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);
  }

  function test_sendMessagePostCCIPMigration(uint256 amount) public {
    executePayload(vm, address(proposal));

    _mockCCIPMigration();

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    IRouter router = IRouter(ghoTokenPool.getRouter());
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);

    // wait for the rate limiter to refill
    skip(_getOutboundRefillTime(amount));

    vm.prank(alice);
    gho.approve(address(router), amount);
    deal(address(gho), alice, amount);

    uint256 tokenPoolBalance = gho.balanceOf(address(ghoTokenPool));
    uint256 bridgedAmount = ghoTokenPool.getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(CCIPSendParams({router: router, amount: amount, migrated: true}));

    vm.expectEmit(address(ghoTokenPool));
    emit Locked(address(proxyPool), amount);
    vm.expectEmit(address(proxyPool));
    emit Locked(ON_RAMP_1_5, amount);
    vm.expectEmit(ON_RAMP_1_5);
    emit CCIPSendRequested(eventArg);
    vm.prank(alice);
    router.ccipSend{value: eventArg.feeTokenAmount}(ARB_CHAIN_SELECTOR, message);

    assertEq(gho.balanceOf(address(ghoTokenPool)), tokenPoolBalance + amount);
    assertEq(ghoTokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);
  }

  function test_executeMessagePreCCIPMigration(uint256 amount) public {
    executePayload(vm, address(proposal));

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);

    // wait for the rate limiter to refill
    skip(_getInboundRefillTime(amount));
    // mock previously locked gho
    deal(address(gho), address(ghoTokenPool), amount);

    vm.expectEmit(address(ghoTokenPool));
    emit Released(OFF_RAMP_1_2, alice, amount);
    vm.prank(OFF_RAMP_1_2);
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ARB_CHAIN_SELECTOR, '');

    assertEq(gho.balanceOf(alice), amount);
  }

  function test_executeMessagePostCCIPMigration(uint256 amount) public {
    executePayload(vm, address(proposal));

    _mockCCIPMigration();

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);
    // wait for the rate limiter to refill
    skip(_getInboundRefillTime(amount));
    // mock previously locked gho
    deal(address(gho), address(ghoTokenPool), amount);

    vm.expectEmit(address(ghoTokenPool));
    emit Released(OFF_RAMP_1_5, alice, amount);
    vm.prank(OFF_RAMP_1_5);
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ARB_CHAIN_SELECTOR, '');

    assertEq(gho.balanceOf(alice), amount);
  }

  function test_executeMessagePostCCIPMigrationViaLegacyOffRamp(uint256 amount) public {
    executePayload(vm, address(proposal));

    _mockCCIPMigration();

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);

    // wait for the rate limiter to refill
    skip(_getInboundRefillTime(amount));
    // mock previously locked gho
    deal(address(gho), address(ghoTokenPool), amount);

    vm.expectEmit(address(ghoTokenPool));
    emit Released(OFF_RAMP_1_2, alice, amount);
    vm.prank(OFF_RAMP_1_2);
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ARB_CHAIN_SELECTOR, '');

    assertEq(gho.balanceOf(alice), amount);
  }

  function test_proxyPoolCanOnRamp(uint256 amount) public {
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);

    uint256 bridgedAmount = ghoTokenPool.getCurrentBridgedAmount();

    vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, proxyPool));
    vm.prank(address(proxyPool));
    ghoTokenPool.lockOrBurn(alice, abi.encode(alice), amount, ARB_CHAIN_SELECTOR, new bytes(0));

    executePayload(vm, address(proposal));

    // wait for the rate limiter to refill
    skip(_getOutboundRefillTime(amount));

    vm.expectEmit(address(ghoTokenPool));
    emit Locked(address(proxyPool), amount);
    vm.prank(address(proxyPool));
    ghoTokenPool.lockOrBurn(alice, abi.encode(alice), amount, ARB_CHAIN_SELECTOR, new bytes(0));

    assertEq(ghoTokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);
  }

  function test_proxyPoolCanOffRamp(uint256 amount) public {
    amount = bound(amount, 1, _getRateLimiterConfig().capacity);

    vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, proxyPool));
    vm.prank(address(proxyPool));
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ARB_CHAIN_SELECTOR, new bytes(0));

    executePayload(vm, address(proposal));
    // mock previously locked gho
    deal(MiscEthereum.GHO_TOKEN, address(ghoTokenPool), amount);
    // wait for the rate limiter to refill
    skip(_getInboundRefillTime(amount));

    vm.expectEmit(address(ghoTokenPool));
    emit Released(address(proxyPool), alice, amount);
    vm.prank(address(proxyPool));
    ghoTokenPool.releaseOrMint(abi.encode(alice), alice, amount, ARB_CHAIN_SELECTOR, new bytes(0));
  }

  function test_stewardCanDisableRateLimit() public {
    executePayload(vm, address(proposal));

    assertEq(ghoTokenPool.getRateLimitAdmin(), address(GHO_CCIP_STEWARD));

    vm.prank(GHO_CCIP_STEWARD.RISK_COUNCIL());
    GHO_CCIP_STEWARD.updateRateLimit(ARB_CHAIN_SELECTOR, false, 0, 0, false, 0, 0);

    assertEq(
      abi.encode(
        _tokenBucketToConfig(ghoTokenPool.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR))
      ),
      abi.encode(_getDisabledConfig())
    );
    assertEq(
      abi.encode(
        _tokenBucketToConfig(ghoTokenPool.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR))
      ),
      abi.encode(_getDisabledConfig())
    );
  }

  function test_ownershipTransferOfGhoProxyPool() public {
    executePayload(vm, address(proposal));
    _mockCCIPMigration();

    assertEq(ghoTokenPool.owner(), AaveV3Ethereum.ACL_ADMIN);

    // CLL team transfers ownership of proxyPool and GHO token in TokenAdminRegistry
    vm.prank(proxyPool.owner());
    proxyPool.transferOwnership(AaveV3Ethereum.ACL_ADMIN);
    vm.prank(TOKEN_ADMIN_REGISTRY.owner());
    TOKEN_ADMIN_REGISTRY.transferAdminRole(MiscEthereum.GHO_TOKEN, AaveV3Ethereum.ACL_ADMIN);

    // new AIP to accept ownership
    vm.startPrank(AaveV3Ethereum.ACL_ADMIN);
    proxyPool.acceptOwnership();
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(MiscEthereum.GHO_TOKEN);
    vm.stopPrank();

    assertEq(proxyPool.owner(), AaveV3Ethereum.ACL_ADMIN);
    assertTrue(
      TOKEN_ADMIN_REGISTRY.isAdministrator(MiscEthereum.GHO_TOKEN, AaveV3Ethereum.ACL_ADMIN)
    );
  }

  function _mockCCIPMigration() private {
    IRouter router = IRouter(ghoTokenPool.getRouter());

    assertEq(TOKEN_ADMIN_REGISTRY.getPool(MiscEthereum.GHO_TOKEN), address(proxyPool));

    assertEq(proxyPool.getRouter(), address(router));

    assertTrue(proxyPool.isSupportedChain(ARB_CHAIN_SELECTOR));
    assertEq(proxyPool.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR), _getDisabledConfig());
    assertEq(
      proxyPool.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR),
      _getDisabledConfig()
    );
    assertEq(proxyPool.getRemotePool(ARB_CHAIN_SELECTOR), abi.encode(ARB_PROXY_POOL));
    assertEq(
      proxyPool.getRemoteToken(ARB_CHAIN_SELECTOR),
      abi.encode(AaveV3ArbitrumAssets.GHO_UNDERLYING)
    );

    IRouter.OnRamp[] memory onRampUpdates = new IRouter.OnRamp[](1);
    onRampUpdates[0] = IRouter.OnRamp({
      destChainSelector: ARB_CHAIN_SELECTOR,
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
    message.tokenAmounts[0] = IClient.EVMTokenAmount({
      token: MiscEthereum.GHO_TOKEN,
      amount: params.amount
    });

    uint256 feeAmount = params.router.getFee(ARB_CHAIN_SELECTOR, message);
    deal(alice, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: params.router,
        sourceChainSelector: ETH_CHAIN_SELECTOR,
        feeTokenAmount: feeAmount,
        originalSender: alice,
        destinationToken: AaveV3ArbitrumAssets.GHO_UNDERLYING,
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

  function _getStaticParams() private view returns (bytes memory) {
    return
      abi.encode(
        address(ghoTokenPool.getToken()),
        ghoTokenPool.getAllowList(),
        ghoTokenPool.getArmProxy(),
        ghoTokenPool.canAcceptLiquidity(),
        ghoTokenPool.getRouter()
      );
  }

  function _getDynamicParams() private view returns (bytes memory) {
    return
      abi.encode(
        ghoTokenPool.owner(),
        ghoTokenPool.getSupportedChains(),
        ghoTokenPool.getAllowListEnabled(),
        ghoTokenPool.getRateLimitAdmin(),
        ghoTokenPool.getBridgeLimitAdmin(),
        ghoTokenPool.getRebalancer(),
        ghoTokenPool.getLockReleaseInterfaceId(),
        ghoTokenPool.getBridgeLimit(),
        ghoTokenPool.getCurrentBridgedAmount()
      );
  }

  function _validateConstants() private view {
    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(proxyPool.typeAndVersion(), 'LockReleaseTokenPoolAndProxy 1.5.0');
    assertEq(ITypeAndVersion(ON_RAMP_1_2).typeAndVersion(), 'EVM2EVMOnRamp 1.2.0');
    assertEq(ITypeAndVersion(ON_RAMP_1_5).typeAndVersion(), 'EVM2EVMOnRamp 1.5.0');
    assertEq(ITypeAndVersion(OFF_RAMP_1_2).typeAndVersion(), 'EVM2EVMOffRamp 1.2.0');
    assertEq(ITypeAndVersion(OFF_RAMP_1_5).typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');

    assertEq(GHO_CCIP_STEWARD.GHO_TOKEN(), MiscEthereum.GHO_TOKEN);
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
