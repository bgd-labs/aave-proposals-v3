// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool as IPool_CCIP} from 'src/interfaces/ccip/tokenPool/IPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {AaveV3GHOLaneTest} from './AaveV3GHOLaneTest.sol';
import {GhoCCIPChains} from '../constants/GhoCCIPChains.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';

abstract contract AaveV3GHOLaunchTest_PreExecution is AaveV3GHOLaneTest {
  IACLManager public immutable LOCAL_ACL_MANAGER;
  address public immutable LOCAL_OWNER;

  constructor(
    GhoCCIPChains.ChainInfo memory localChainInfo,
    string memory rpcAlias,
    uint256 blockNumber
  )
    AaveV3GHOLaneTest(
      localChainInfo,
      GhoCCIPChains.emptyChainInfo(), // Nullified remote chain info as it's not used for this test
      rpcAlias,
      blockNumber
    )
  {
    LOCAL_ACL_MANAGER = IACLManager(localChainInfo.aclManager);
    LOCAL_OWNER = localChainInfo.owner;
  }

  function _localRiskCouncil() internal view virtual returns (address);

  function _localRmnProxy() internal view virtual returns (address);

  function _aavePoolAddressesProvider() internal view virtual returns (address);

  function _aaveProtocolDataProvider() internal view virtual returns (address);

  function _executePayload() internal virtual {
    executePayload(vm, address(proposal));
  }

  function test_stewardRoles() public {
    _test_ghoAaveCore_stewardsRoles_beforePayloadExecution();
    _test_ghoBucket_stewardsConfig_beforePayloadExecution();
    _test_ghoTokenPool_stewardsConfig_beforePayloadExecution();

    _executePayload();

    _test_ghoTokenPool_stewardsConfig_afterPayloadExecution();
    _test_ghoAaveCore_stewardsRoles_afterPayloadExecution();
    _test_ghoBucket_stewardsConfig_afterPayloadExecution();
  }

  function _test_ghoAaveCore_stewardsRoles_beforePayloadExecution() internal view virtual {
    assertFalse(
      LOCAL_ACL_MANAGER.hasRole(
        LOCAL_ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(LOCAL_GHO_AAVE_CORE_STEWARD)
      )
    );
  }

  function _test_ghoAaveCore_stewardsRoles_afterPayloadExecution() internal view virtual {
    assertTrue(
      LOCAL_ACL_MANAGER.hasRole(
        LOCAL_ACL_MANAGER.RISK_ADMIN_ROLE(),
        address(LOCAL_GHO_AAVE_CORE_STEWARD)
      )
    );
  }

  function _test_ghoBucket_stewardsConfig_beforePayloadExecution() internal view virtual {
    assertEq(LOCAL_GHO_BUCKET_STEWARD.getControlledFacilitators().length, 0);
  }

  function _test_ghoTokenPool_stewardsConfig_beforePayloadExecution() internal view virtual {
    assertEq(LOCAL_TOKEN_POOL.getRateLimitAdmin(), address(0));
  }

  function _test_ghoTokenPool_stewardsConfig_afterPayloadExecution() internal view virtual {
    assertTrue(LOCAL_GHO_TOKEN.hasRole(LOCAL_GHO_TOKEN.FACILITATOR_MANAGER_ROLE(), LOCAL_OWNER));
    assertTrue(LOCAL_GHO_TOKEN.hasRole(LOCAL_GHO_TOKEN.BUCKET_MANAGER_ROLE(), LOCAL_OWNER));

    IGhoToken.Facilitator memory facilitator = LOCAL_GHO_TOKEN.getFacilitator(
      address(LOCAL_TOKEN_POOL)
    );
    assertEq(facilitator.label, 'CCIP TokenPool v1.5.1');
    assertEq(facilitator.bucketLevel, 0);

    assertTrue(
      LOCAL_GHO_TOKEN.hasRole(
        LOCAL_GHO_TOKEN.BUCKET_MANAGER_ROLE(),
        address(LOCAL_GHO_BUCKET_STEWARD)
      )
    );
  }

  function _test_ghoBucket_stewardsConfig_afterPayloadExecution() internal view virtual {
    address[] memory facilitatorList = LOCAL_GHO_BUCKET_STEWARD.getControlledFacilitators();
    assertEq(facilitatorList.length, 1);
    assertEq(facilitatorList[0], address(LOCAL_TOKEN_POOL));
    assertTrue(LOCAL_GHO_BUCKET_STEWARD.isControlledFacilitator(address(LOCAL_TOKEN_POOL)));

    assertEq(LOCAL_TOKEN_POOL.getRateLimitAdmin(), address(LOCAL_GHO_CCIP_STEWARD));
  }

  function test_stewardsConfig() public view {
    _test_ghoAaveCore_stewardsConfig();
    _test_ghoBucket_stewardsConfig();
    _test_ghoCCIP_stewardsConfig();
  }

  function _test_ghoAaveCore_stewardsConfig() internal view virtual {
    assertEq(IOwnable(address(LOCAL_GHO_AAVE_CORE_STEWARD)).owner(), LOCAL_OWNER);
    assertEq(LOCAL_GHO_AAVE_CORE_STEWARD.POOL_ADDRESSES_PROVIDER(), _aavePoolAddressesProvider());
    assertEq(LOCAL_GHO_AAVE_CORE_STEWARD.POOL_DATA_PROVIDER(), _aaveProtocolDataProvider());
    assertEq(LOCAL_GHO_AAVE_CORE_STEWARD.RISK_COUNCIL(), _localRiskCouncil());
    IGhoAaveSteward.BorrowRateConfig memory config = LOCAL_GHO_AAVE_CORE_STEWARD
      .getBorrowRateConfig();
    assertEq(config.optimalUsageRatioMaxChange, 500);
    assertEq(config.baseVariableBorrowRateMaxChange, 500);
    assertEq(config.variableRateSlope1MaxChange, 500);
    assertEq(config.variableRateSlope2MaxChange, 500);
  }

  function _test_ghoBucket_stewardsConfig() internal view virtual {
    assertEq(IOwnable(address(LOCAL_GHO_BUCKET_STEWARD)).owner(), LOCAL_OWNER);
    assertEq(LOCAL_GHO_BUCKET_STEWARD.GHO_TOKEN(), address(LOCAL_GHO_TOKEN));
    assertEq(LOCAL_GHO_BUCKET_STEWARD.RISK_COUNCIL(), _localRiskCouncil());
    assertEq(LOCAL_GHO_BUCKET_STEWARD.getControlledFacilitators().length, 0); // before AIP, no controlled facilitators are set
  }

  function _test_ghoCCIP_stewardsConfig() internal view virtual {
    assertEq(LOCAL_GHO_CCIP_STEWARD.GHO_TOKEN(), address(LOCAL_GHO_TOKEN));
    assertEq(LOCAL_GHO_CCIP_STEWARD.GHO_TOKEN_POOL(), address(LOCAL_TOKEN_POOL));
    assertEq(LOCAL_GHO_CCIP_STEWARD.RISK_COUNCIL(), _localRiskCouncil());
    assertFalse(LOCAL_GHO_CCIP_STEWARD.BRIDGE_LIMIT_ENABLED());
    assertEq(
      abi.encode(LOCAL_GHO_CCIP_STEWARD.getCcipTimelocks()),
      abi.encode(IGhoCcipSteward.CcipDebounce(0, 0))
    );
  }

  function test_newTokenPoolInitialization() public {
    vm.expectRevert('Initializable: contract is already initialized');
    LOCAL_TOKEN_POOL.initialize(makeAddr('owner'), new address[](0), makeAddr('router'));
    assertEq(_readInitialized(address(LOCAL_TOKEN_POOL)), 1);

    address IMPL = _getImplementation(address(LOCAL_TOKEN_POOL));
    vm.expectRevert('Initializable: contract is already initialized');
    IUpgradeableBurnMintTokenPool_1_5_1(IMPL).initialize(
      makeAddr('owner'),
      new address[](0),
      makeAddr('router')
    );
    assertEq(_readInitialized(IMPL), 255);
  }

  function test_tokenPoolConfig() public {
    _executePayload();

    assertEq(LOCAL_TOKEN_POOL.owner(), LOCAL_OWNER);
    assertEq(
      address(uint160(uint256(vm.load(address(LOCAL_TOKEN_POOL), bytes32(0))) >> 2)), // pending owner
      address(0)
    );
    assertEq(LOCAL_TOKEN_POOL.getToken(), address(LOCAL_GHO_TOKEN));
    assertEq(LOCAL_TOKEN_POOL.getTokenDecimals(), LOCAL_GHO_TOKEN.decimals());
    assertEq(LOCAL_TOKEN_POOL.getRmnProxy(), _localRmnProxy());
    assertFalse(LOCAL_TOKEN_POOL.getAllowListEnabled());
    assertEq(abi.encode(LOCAL_TOKEN_POOL.getAllowList()), abi.encode(new address[](0)));
    assertEq(LOCAL_TOKEN_POOL.getRouter(), address(LOCAL_CCIP_ROUTER));

    GhoCCIPChains.ChainInfo[] memory expectedSupportedChains = _expectedSupportedChains();

    assertEq(LOCAL_TOKEN_POOL.getSupportedChains().length, expectedSupportedChains.length);
    assertEq(LOCAL_TOKEN_POOL.getSupportedChains()[0], expectedSupportedChains[0].chainSelector);
    assertEq(LOCAL_TOKEN_POOL.getSupportedChains()[1], expectedSupportedChains[1].chainSelector);
    assertEq(LOCAL_TOKEN_POOL.getSupportedChains()[2], expectedSupportedChains[2].chainSelector);

    for (uint256 i = 0; i < expectedSupportedChains.length; i++) {
      assertEq(
        LOCAL_TOKEN_POOL.getRemoteToken(expectedSupportedChains[i].chainSelector),
        abi.encode(expectedSupportedChains[i].ghoToken)
      );

      bytes[] memory remotePools = LOCAL_TOKEN_POOL.getRemotePools(
        expectedSupportedChains[i].chainSelector
      );

      assertEq(remotePools.length, 1);
      assertEq(remotePools[0], abi.encode(expectedSupportedChains[i].ghoCCIPTokenPool));

      assertEq(
        LOCAL_TOKEN_POOL.getCurrentInboundRateLimiterState(
          expectedSupportedChains[i].chainSelector
        ),
        _getRateLimiterConfig()
      );
      assertEq(
        LOCAL_TOKEN_POOL.getCurrentOutboundRateLimiterState(
          expectedSupportedChains[i].chainSelector
        ),
        _getRateLimiterConfig()
      );
    }
  }
}

abstract contract AaveV3GHOLaunchTest_PostExecution is AaveV3GHOLaneTest {
  constructor(
    GhoCCIPChains.ChainInfo memory localChainInfo,
    string memory rpcAlias,
    uint256 blockNumber
  )
    AaveV3GHOLaneTest(
      localChainInfo,
      GhoCCIPChains.ChainInfo(
        0,
        address(0),
        address(0),
        address(0),
        address(0),
        address(0),
        address(0),
        address(0),
        address(0),
        address(0)
      ), // Nullified remote chain info as it's not used for this test
      rpcAlias,
      blockNumber
    )
  {}

  function _executePayload() internal virtual {
    executePayload(vm, address(proposal));
  }

  function setUp() public virtual override {
    super.setUp();
    _executePayload();
  }

  function test_sendMessageToSupportedChainSucceeds(uint256 amount, uint8 chainIndex) public {
    GhoCCIPChains.ChainInfo[] memory supportedChains = _expectedSupportedChains();

    require(supportedChains.length > 0);

    chainIndex = uint8(bound(chainIndex, 0, supportedChains.length - 1));

    amount = bound(amount, 1, _ccipRateLimitCapacity());
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill
    // mock previously bridged amount
    vm.prank(address(LOCAL_TOKEN_POOL));
    LOCAL_GHO_TOKEN.mint(alice, amount); // increase bucket level

    vm.prank(alice);
    LOCAL_GHO_TOKEN.approve(address(LOCAL_CCIP_ROUTER), amount);

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);
    uint256 bucketLevel = LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel;

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({
          amount: amount,
          sender: alice,
          destChainSelector: supportedChains[chainIndex].chainSelector,
          destToken: supportedChains[chainIndex].ghoToken
        })
      );

    address onRamp = LOCAL_CCIP_ROUTER.getOnRamp(supportedChains[chainIndex].chainSelector);

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Burned(onRamp, amount);
    vm.expectEmit(onRamp);
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    LOCAL_CCIP_ROUTER.ccipSend{value: eventArg.feeTokenAmount}(
      supportedChains[chainIndex].chainSelector,
      message
    );

    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(
      LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel,
      bucketLevel - amount
    );
  }

  function test_offRampViaSupportedChainSucceeds(uint256 amount, uint8 chainIndex) public {
    GhoCCIPChains.ChainInfo[] memory supportedChains = _expectedSupportedChains();

    require(supportedChains.length > 0);

    chainIndex = uint8(bound(chainIndex, 0, supportedChains.length - 1));

    amount = bound(
      amount,
      1,
      _min(
        LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketCapacity, // initially, bucketLevel == 0
        _ccipRateLimitCapacity()
      )
    );
    skip(_getInboundRefillTime(amount)); // wait for the rate limiter to refill

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);

    address offRamp = _getOnRampFailIfNotFound(supportedChains[chainIndex].chainSelector);

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Minted(offRamp, alice, amount);

    vm.prank(offRamp);
    LOCAL_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: supportedChains[chainIndex].chainSelector,
        receiver: alice,
        amount: amount,
        localToken: address(LOCAL_GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(supportedChains[chainIndex].ghoCCIPTokenPool)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel, amount);
    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance + amount);
  }

  function test_cannotOffRampOtherChainMessages(uint8 chainIndexI, uint8 chainIndexII) public {
    GhoCCIPChains.ChainInfo[] memory supportedChains = _expectedSupportedChains();

    vm.skip(supportedChains.length < 2);

    chainIndexI = uint8(bound(chainIndexI, 0, supportedChains.length - 1));
    chainIndexII = uint8(bound(chainIndexII, 0, supportedChains.length - 1));

    vm.assume(chainIndexI != chainIndexII);
    vm.assume(
      supportedChains[chainIndexI].ghoCCIPTokenPool !=
        supportedChains[chainIndexII].ghoCCIPTokenPool
    );

    uint256 amount = 100e18;
    skip(_getInboundRefillTime(amount));

    address offRampI = _getOnRampFailIfNotFound(supportedChains[chainIndexI].chainSelector);

    vm.expectRevert(
      abi.encodeWithSelector(
        InvalidSourcePoolAddress.selector,
        abi.encode(address(supportedChains[chainIndexII].ghoCCIPTokenPool))
      )
    );
    vm.prank(offRampI);
    LOCAL_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: supportedChains[chainIndexI].chainSelector,
        receiver: alice,
        amount: amount,
        localToken: address(LOCAL_GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(supportedChains[chainIndexII].ghoCCIPTokenPool)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }
}
