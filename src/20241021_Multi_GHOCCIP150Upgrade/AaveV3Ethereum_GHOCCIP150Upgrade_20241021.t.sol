// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {UpgradeableLockReleaseTokenPool} from 'aave-ccip/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {RateLimiter} from 'aave-ccip/v0.8/ccip/libraries/RateLimiter.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {ITypeAndVersion} from 'src/interfaces/ccip/ITypeAndVersion.sol';
import {IProxyPool} from 'src/interfaces/ccip/IProxyPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
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
  UpgradeableLockReleaseTokenPool internal ghoTokenPool;
  IProxyPool internal proxyPool;

  address internal alice = makeAddr('alice');

  uint64 internal constant ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 internal constant ARB_CHAIN_SELECTOR = 4949039107694359620;
  address internal constant ARB_GHO_TOKEN = 0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33;
  address internal constant ARB_PROXY_POOL = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50;
  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);
  address internal constant ON_RAMP_1_2 = 0x925228D7B82d883Dde340A55Fe8e6dA56244A22C;
  address internal constant ON_RAMP_1_5 = 0x69eCC4E2D8ea56E2d0a05bF57f4Fd6aEE7f2c284;
  address internal constant OFF_RAMP_1_2 = 0xeFC4a18af59398FF23bfe7325F2401aD44286F4d;
  address internal constant OFF_RAMP_1_5 = 0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9;

  event Locked(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address caller);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21045560);
    proposal = new AaveV3Ethereum_GHOCCIP150Upgrade_20241021();
    ghoTokenPool = UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL);
    proxyPool = IProxyPool(proposal.GHO_CCIP_PROXY_POOL());

    _validateConstants();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
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
      abi.encode(
        _tokenBucketToConfig(ghoTokenPool.getCurrentInboundRateLimiterState(ARB_CHAIN_SELECTOR))
      ),
      abi.encode(proposal.getInBoundRateLimiterConfig())
    );
    assertEq(
      abi.encode(
        _tokenBucketToConfig(ghoTokenPool.getCurrentOutboundRateLimiterState(ARB_CHAIN_SELECTOR))
      ),
      abi.encode(proposal.getOutBoundRateLimiterConfig())
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
    /// proxy implementation is initialized
    assertEq(_readInitialized(_getImplementation(address(ghoTokenPool))), 255);

    executePayload(vm, address(proposal));

    vm.expectRevert('Initializable: contract is already initialized');
    ghoTokenPool.initialize(makeAddr('owner'), new address[](0), makeAddr('router'), 0);
    /// proxy implementation is initialized
    assertEq(_readInitialized(_getImplementation(address(ghoTokenPool))), 255);
  }

  function test_sendMessagePreCCIPMigration() public {
    executePayload(vm, address(proposal));

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    IRouter router = IRouter(ghoTokenPool.getRouter());
    uint256 amount = 150_000e18;

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

  function test_sendMessagePostCCIPMigration() public {
    executePayload(vm, address(proposal));

    _mockCCIPMigration();

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    IRouter router = IRouter(ghoTokenPool.getRouter());
    uint256 amount = 350_000e18;

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

  function test_executeMessagePreCCIPMigration() public {
    executePayload(vm, address(proposal));

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    uint256 amount = 350_000e18;

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

  function test_executeMessagePostCCIPMigration() public {
    executePayload(vm, address(proposal));

    _mockCCIPMigration();

    IERC20 gho = IERC20(address(ghoTokenPool.getToken()));
    uint256 amount = 350_000e18;
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

  function test_proxyPoolCanOnRamp() public {
    uint256 amount = 1337e18;

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

  function test_proxyPoolCanOffRamp() public {
    uint256 amount = 1337e18;

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

  function _mockCCIPMigration() private {
    IRouter router = IRouter(ghoTokenPool.getRouter());
    // token registry not set for 1.5 migration
    assertEq(TOKEN_ADMIN_REGISTRY.getPool(MiscEthereum.GHO_TOKEN), address(0));
    vm.startPrank(TOKEN_ADMIN_REGISTRY.owner());
    TOKEN_ADMIN_REGISTRY.proposeAdministrator(MiscEthereum.GHO_TOKEN, TOKEN_ADMIN_REGISTRY.owner());
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(MiscEthereum.GHO_TOKEN);
    TOKEN_ADMIN_REGISTRY.setPool(MiscEthereum.GHO_TOKEN, address(proxyPool));
    vm.stopPrank();
    assertEq(TOKEN_ADMIN_REGISTRY.getPool(MiscEthereum.GHO_TOKEN), address(proxyPool));

    assertEq(proxyPool.getRouter(), address(router));

    IProxyPool.ChainUpdate[] memory chains = new IProxyPool.ChainUpdate[](1);
    chains[0] = IProxyPool.ChainUpdate({
      remoteChainSelector: ARB_CHAIN_SELECTOR,
      remotePoolAddress: abi.encode(ARB_PROXY_POOL),
      remoteTokenAddress: abi.encode(address(ARB_GHO_TOKEN)),
      allowed: true,
      outboundRateLimiterConfig: IRateLimiter.Config({isEnabled: false, capacity: 0, rate: 0}),
      inboundRateLimiterConfig: IRateLimiter.Config({isEnabled: false, capacity: 0, rate: 0})
    });

    vm.prank(proxyPool.owner());
    proxyPool.applyChainUpdates(chains);

    assertTrue(proxyPool.isSupportedChain(ARB_CHAIN_SELECTOR));

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
        destinationToken: ARB_GHO_TOKEN,
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
        ghoTokenPool.getBridgeLimitAdmin(),
        ghoTokenPool.getRateLimitAdmin(),
        ghoTokenPool.getRebalancer(),
        ghoTokenPool.getSupportedChains(),
        ghoTokenPool.getLockReleaseInterfaceId(),
        ghoTokenPool.getBridgeLimit(),
        ghoTokenPool.getCurrentBridgedAmount(),
        ghoTokenPool.getRateLimitAdmin()
      );
  }

  function _validateConstants() private view {
    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(proxyPool.typeAndVersion(), 'LockReleaseTokenPoolAndProxy 1.5.0');
    assertEq(ITypeAndVersion(ON_RAMP_1_2).typeAndVersion(), 'EVM2EVMOnRamp 1.2.0');
    assertEq(ITypeAndVersion(ON_RAMP_1_5).typeAndVersion(), 'EVM2EVMOnRamp 1.5.0');
    assertEq(ITypeAndVersion(OFF_RAMP_1_2).typeAndVersion(), 'EVM2EVMOffRamp 1.2.0');
    assertEq(ITypeAndVersion(OFF_RAMP_1_5).typeAndVersion(), 'EVM2EVMOffRamp 1.5.0');
  }

  function _getOutboundRefillTime(uint256 amount) private view returns (uint256) {
    uint128 rate = proposal.getOutBoundRateLimiterConfig().rate;
    assertNotEq(rate, 0);
    return amount / uint256(rate) + 1; // account for rounding
  }

  function _getInboundRefillTime(uint256 amount) private view returns (uint256) {
    uint128 rate = proposal.getInBoundRateLimiterConfig().rate;
    assertNotEq(rate, 0);
    return amount / uint256(rate) + 1; // account for rounding
  }

  function _tokenBucketToConfig(
    RateLimiter.TokenBucket memory bucket
  ) private pure returns (RateLimiter.Config memory) {
    return
      RateLimiter.Config({
        isEnabled: bucket.isEnabled,
        capacity: bucket.capacity,
        rate: bucket.rate
      });
  }

  function _getDisabledConfig() private pure returns (RateLimiter.Config memory) {
    return RateLimiter.Config({isEnabled: false, capacity: 0, rate: 0});
  }
}
