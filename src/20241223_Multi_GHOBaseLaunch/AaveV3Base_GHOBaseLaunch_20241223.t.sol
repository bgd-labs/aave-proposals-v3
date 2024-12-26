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
import {IOwnable} from 'src/interfaces/IOwnable.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoAaveSteward} from 'gho-core/misc/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'gho-core/misc/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'gho-core/misc/interfaces/IGhoCcipSteward.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {GhoAaveSteward} from 'gho-core/misc/GhoAaveSteward.sol';
import {GhoBucketSteward} from 'gho-core/misc/GhoBucketSteward.sol';
import {GhoCcipSteward} from 'gho-core/misc/GhoCcipSteward.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';

import {AaveV3Base_GHOBaseLaunch_20241223} from './AaveV3Base_GHOBaseLaunch_20241223.sol';

/**
 * @dev Test for AaveV3Base_GHOBaseLaunch_20241223
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseLaunch_20241223.t.sol -vv
 */
contract AaveV3Base_GHOBaseLaunch_20241223_Base is ProtocolV3TestBase {
  struct CCIPSendParams {
    address sender;
    uint256 amount;
    uint64 destChainSelector;
  }

  uint64 internal constant ARB_CHAIN_SELECTOR = CCIPUtils.ARB_CHAIN_SELECTOR;
  uint64 internal constant BASE_CHAIN_SELECTOR = CCIPUtils.BASE_CHAIN_SELECTOR;
  uint64 internal constant ETH_CHAIN_SELECTOR = CCIPUtils.ETH_CHAIN_SELECTOR;

  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);
  IEVM2EVMOnRamp internal constant ARB_ON_RAMP =
    IEVM2EVMOnRamp(0x9D0ffA76C7F82C34Be313b5bFc6d42A72dA8CA69);
  IEVM2EVMOnRamp internal constant ETH_ON_RAMP =
    IEVM2EVMOnRamp(0x56b30A0Dcd8dc87Ec08b80FA09502bAB801fa78e);

  IEVM2EVMOffRamp_1_5 internal constant ARB_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0x7D38c6363d5E4DFD500a691Bc34878b383F58d93);
  IEVM2EVMOffRamp_1_5 internal constant ETH_OFF_RAMP =
    IEVM2EVMOffRamp_1_5(0xCA04169671A81E4fB8768cfaD46c347ae65371F1);

  IRouter internal constant ROUTER = IRouter(0x881e3A65B4d4a04dD529061dd0071cf975F58bCD);
  address internal constant RMN_PROXY = 0xC842c69d54F83170C42C4d556B4F6B2ca53Dd3E8;

  address public constant GHO_TOKEN_IMPL = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;
  IGhoToken public constant GHO = IGhoToken(0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D); // predicted address, will be deployed in the AIP

  IGhoAaveSteward internal NEW_GHO_AAVE_STEWARD;
  IGhoBucketSteward internal NEW_GHO_BUCKET_STEWARD;
  IGhoCcipSteward internal NEW_GHO_CCIP_STEWARD;

  IUpgradeableBurnMintTokenPool_1_5_1 internal NEW_TOKEN_POOL;
  AaveV3Base_GHOBaseLaunch_20241223 internal proposal;

  address internal NEW_REMOTE_POOL_ARB = makeAddr('ARB: BurnMintTokenPool 1.5.1');
  address internal NEW_REMOTE_POOL_ETH = makeAddr('ETH: LockReleaseTokenPool 1.5.1');
  address internal RISK_COUNCIL = makeAddr('riskCouncil');
  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  event Burned(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);

  error CallerIsNotARampOnRouter(address);
  error InvalidSourcePoolAddress(bytes);

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('base'), 24139320);

    NEW_TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(
      _deployNewBurnMintTokenPool(
        address(GHO),
        RMN_PROXY,
        address(ROUTER),
        GovernanceV3Base.EXECUTOR_LVL_1, // owner
        MiscBase.PROXY_ADMIN
      )
    );
    (NEW_GHO_AAVE_STEWARD, NEW_GHO_BUCKET_STEWARD, NEW_GHO_CCIP_STEWARD) = _deployStewards();

    proposal = new AaveV3Base_GHOBaseLaunch_20241223(
      address(NEW_TOKEN_POOL),
      NEW_REMOTE_POOL_ETH,
      NEW_REMOTE_POOL_ARB,
      address(NEW_GHO_AAVE_STEWARD),
      address(NEW_GHO_BUCKET_STEWARD),
      address(NEW_GHO_CCIP_STEWARD)
    );

    _performCcipPreReq();
    _validateConstants();
  }

  function _performCcipPreReq() internal {
    vm.prank(TOKEN_ADMIN_REGISTRY.owner());
    TOKEN_ADMIN_REGISTRY.proposeAdministrator(address(GHO), GovernanceV3Base.EXECUTOR_LVL_1);
  }

  function _deployNewBurnMintTokenPool(
    address ghoToken,
    address rmnProxy,
    address router,
    address owner,
    address proxyAdmin
  ) private returns (address) {
    address newTokenPoolImpl = address(
      new UpgradeableBurnMintTokenPool(
        ghoToken,
        18,
        rmnProxy,
        false // allowListEnabled
      )
    );

    return
      address(
        new TransparentUpgradeableProxy(
          newTokenPoolImpl,
          ProxyAdmin(proxyAdmin),
          abi.encodeCall(
            IUpgradeableBurnMintTokenPool_1_5_1.initialize,
            (
              owner,
              new address[](0), // allowList
              router
            )
          )
        )
      );
  }

  function _deployStewards()
    internal
    returns (IGhoAaveSteward, IGhoBucketSteward, IGhoCcipSteward)
  {
    address aaveSteward = address(
      new GhoAaveSteward({
        owner: GovernanceV3Base.EXECUTOR_LVL_1,
        addressesProvider: address(AaveV3Base.POOL_ADDRESSES_PROVIDER),
        poolDataProvider: address(AaveV3Base.UI_POOL_DATA_PROVIDER),
        ghoToken: address(GHO),
        riskCouncil: RISK_COUNCIL,
        borrowRateConfig: IGhoAaveSteward.BorrowRateConfig({
          optimalUsageRatioMaxChange: 500,
          baseVariableBorrowRateMaxChange: 500,
          variableRateSlope1MaxChange: 500,
          variableRateSlope2MaxChange: 500
        })
      })
    );
    address bucketSteward = address(
      new GhoBucketSteward({
        owner: GovernanceV3Base.EXECUTOR_LVL_1,
        ghoToken: address(GHO),
        riskCouncil: RISK_COUNCIL
      })
    );
    address ccipSteward = address(
      new GhoCcipSteward({
        ghoToken: address(GHO),
        ghoTokenPool: address(NEW_TOKEN_POOL),
        riskCouncil: RISK_COUNCIL,
        bridgeLimitEnabled: false
      })
    );
    return (
      IGhoAaveSteward(aaveSteward),
      IGhoBucketSteward(bucketSteward),
      IGhoCcipSteward(ccipSteward)
    );
  }

  function _validateConstants() private view {
    assertEq(proposal.ETH_CHAIN_SELECTOR(), ETH_CHAIN_SELECTOR);
    assertEq(proposal.ARB_CHAIN_SELECTOR(), ARB_CHAIN_SELECTOR);
    assertEq(proposal.CCIP_BUCKET_CAPACITY(), 20_000_000e18);
    assertEq(address(proposal.TOKEN_ADMIN_REGISTRY()), address(TOKEN_ADMIN_REGISTRY));
    assertEq(address(proposal.TOKEN_POOL()), address(NEW_TOKEN_POOL));
    assertEq(proposal.GHO_TOKEN_IMPL(), GHO_TOKEN_IMPL);
    assertEq(address(proposal.GHO_TOKEN_PROXY()), address(GHO));
    assertEq(proposal.GHO_AAVE_STEWARD(), address(NEW_GHO_AAVE_STEWARD));
    assertEq(proposal.GHO_BUCKET_STEWARD(), address(NEW_GHO_BUCKET_STEWARD));
    assertEq(proposal.GHO_CCIP_STEWARD(), address(NEW_GHO_CCIP_STEWARD));
    assertEq(proposal.REMOTE_TOKEN_POOL_ARB(), NEW_REMOTE_POOL_ARB);
    assertEq(proposal.REMOTE_TOKEN_POOL_ETH(), NEW_REMOTE_POOL_ETH);

    assertEq(TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(NEW_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(ROUTER.typeAndVersion(), 'Router 1.2.0');

    _assertOnRamp(ARB_ON_RAMP, BASE_CHAIN_SELECTOR, ARB_CHAIN_SELECTOR, ROUTER);
    _assertOnRamp(ETH_ON_RAMP, BASE_CHAIN_SELECTOR, ETH_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(ARB_OFF_RAMP, ARB_CHAIN_SELECTOR, BASE_CHAIN_SELECTOR, ROUTER);
    _assertOffRamp(ETH_OFF_RAMP, ETH_CHAIN_SELECTOR, BASE_CHAIN_SELECTOR, ROUTER);
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
          params.destChainSelector == ARB_CHAIN_SELECTOR
            ? AaveV3ArbitrumAssets.GHO_UNDERLYING
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
}

contract AaveV3Base_GHOBaseLaunch_20241223_PreExecution is AaveV3Base_GHOBaseLaunch_20241223_Base {
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_GHOBaseLaunch_20241223', AaveV3Base.POOL, address(proposal));
  }

  function test_stewardRolesAndConfig() public {
    // gho token is deployed in the AIP, does not existing before

    assertFalse(
      AaveV3Base.ACL_MANAGER.hasRole(
        AaveV3Base.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(NEW_GHO_AAVE_STEWARD)
      )
    );
    assertEq(NEW_GHO_BUCKET_STEWARD.getControlledFacilitators().length, 0);
    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(0));

    executePayload(vm, address(proposal));

    assertTrue(GHO.hasRole(GHO.FACILITATOR_MANAGER_ROLE(), GovernanceV3Base.EXECUTOR_LVL_1));
    assertTrue(GHO.hasRole(GHO.BUCKET_MANAGER_ROLE(), GovernanceV3Base.EXECUTOR_LVL_1));

    IGhoToken.Facilitator memory facilitator = GHO.getFacilitator(address(NEW_TOKEN_POOL));
    assertEq(facilitator.label, 'CCIP TokenPool v1.5.1');
    assertEq(facilitator.bucketLevel, 0);
    assertEq(facilitator.bucketCapacity, proposal.CCIP_BUCKET_CAPACITY());

    assertTrue(
      AaveV3Base.ACL_MANAGER.hasRole(
        AaveV3Base.ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(NEW_GHO_AAVE_STEWARD)
      )
    );

    assertTrue(GHO.hasRole(GHO.BUCKET_MANAGER_ROLE(), address(NEW_GHO_BUCKET_STEWARD)));

    address[] memory facilitatorList = NEW_GHO_BUCKET_STEWARD.getControlledFacilitators();
    assertEq(facilitatorList.length, 1);
    assertEq(facilitatorList[0], address(NEW_TOKEN_POOL));
    assertTrue(NEW_GHO_BUCKET_STEWARD.isControlledFacilitator(address(NEW_TOKEN_POOL)));

    assertEq(NEW_TOKEN_POOL.getRateLimitAdmin(), address(NEW_GHO_CCIP_STEWARD));
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

  function test_stewardsConfig() public view {
    assertEq(IOwnable(address(NEW_GHO_AAVE_STEWARD)).owner(), GovernanceV3Base.EXECUTOR_LVL_1);
    assertEq(
      NEW_GHO_AAVE_STEWARD.POOL_ADDRESSES_PROVIDER(),
      address(AaveV3Base.POOL_ADDRESSES_PROVIDER)
    );
    assertEq(NEW_GHO_AAVE_STEWARD.POOL_DATA_PROVIDER(), address(AaveV3Base.UI_POOL_DATA_PROVIDER));
    assertEq(NEW_GHO_AAVE_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    IGhoAaveSteward.BorrowRateConfig memory config = NEW_GHO_AAVE_STEWARD.getBorrowRateConfig();
    assertEq(config.optimalUsageRatioMaxChange, 500);
    assertEq(config.baseVariableBorrowRateMaxChange, 500);
    assertEq(config.variableRateSlope1MaxChange, 500);
    assertEq(config.variableRateSlope2MaxChange, 500);

    assertEq(IOwnable(address(NEW_GHO_BUCKET_STEWARD)).owner(), GovernanceV3Base.EXECUTOR_LVL_1);
    assertEq(NEW_GHO_BUCKET_STEWARD.GHO_TOKEN(), address(GHO));
    assertEq(NEW_GHO_BUCKET_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    assertEq(NEW_GHO_BUCKET_STEWARD.getControlledFacilitators().length, 0); // before AIP, no controlled facilitators are set

    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN(), address(GHO));
    assertEq(NEW_GHO_CCIP_STEWARD.GHO_TOKEN_POOL(), address(NEW_TOKEN_POOL));
    assertEq(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL(), RISK_COUNCIL);
    assertFalse(NEW_GHO_CCIP_STEWARD.BRIDGE_LIMIT_ENABLED());
    uint256 ccipDebounceValue = uint256(vm.load(address(NEW_GHO_CCIP_STEWARD), bytes32(0)));
    IGhoCcipSteward.CcipDebounce memory ccipDebounce = IGhoCcipSteward.CcipDebounce({
      bridgeLimitLastUpdate: uint40(ccipDebounceValue >> 216),
      rateLimitLastUpdate: uint40(ccipDebounceValue >> 176)
    });
    assertEq(ccipDebounce.bridgeLimitLastUpdate, 0);
    assertEq(ccipDebounce.rateLimitLastUpdate, 0);
  }
}

contract AaveV3Base_GHOBaseLaunch_20241223_PostExecution is AaveV3Base_GHOBaseLaunch_20241223_Base {
  function setUp() public override {
    super.setUp();

    executePayload(vm, address(proposal));
  }

  function test_sendMessageToArbSucceeds(uint256 amount) public {
    amount = bound(amount, 1, 5_000_000e18);
    // mock previously bridged amount
    vm.prank(address(NEW_TOKEN_POOL));
    GHO.mint(alice, amount); // increase bucket level

    vm.prank(alice);
    GHO.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 bucketLevel = GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;

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

    assertEq(GHO.balanceOf(alice), aliceBalance - amount);
    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
  }

  function test_sendMessageToEthSucceeds(uint256 amount) public {
    amount = bound(amount, 1, 5_000_000e18);
    // mock previously bridged amount
    vm.prank(address(NEW_TOKEN_POOL));
    GHO.mint(alice, amount); // increase bucket level

    deal(address(GHO), alice, amount);
    vm.prank(alice);
    GHO.approve(address(ROUTER), amount);

    uint256 aliceBalance = GHO.balanceOf(alice);
    uint256 bucketLevel = GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel;

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
    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, bucketLevel - amount);
  }

  function test_offRampViaArbSucceeds(uint256 amount) public {
    amount = bound(amount, 1, GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketCapacity); // initially, bucketLevel == 0

    uint256 aliceBalance = GHO.balanceOf(alice);

    vm.expectEmit(address(NEW_TOKEN_POOL));
    emit Minted(address(ARB_OFF_RAMP), alice, amount);

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

    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
  }

  function test_offRampViaEthSucceeds(uint256 amount) public {
    amount = bound(amount, 1, GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketCapacity); // initially, bucketLevel == 0

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

    assertEq(GHO.getFacilitator(address(NEW_TOKEN_POOL)).bucketLevel, amount);
    assertEq(GHO.balanceOf(alice), aliceBalance + amount);
  }

  function test_cannotOffRampOtherChainMessages() public {
    uint256 amount = 100e18;

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
        localToken: address(GHO),
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
        localToken: address(GHO),
        sourcePoolAddress: abi.encode(address(NEW_REMOTE_POOL_ARB)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }
}
