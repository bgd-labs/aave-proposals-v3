// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {IACLManager, IDefaultInterestRateStrategyV2} from 'aave-address-book/AaveV3.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Arbitrum_GHOStewardV2Upgrade_20241007} from './AaveV3Arbitrum_GHOStewardV2Upgrade_20241007.sol';
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {RateLimiter, IUpgradeableLockReleaseTokenPool} from './Ccip.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOStewardV2Upgrade_20241007
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Arbitrum_GHOStewardV2Upgrade_20241007.t.sol -vv
 */
contract AaveV3Arbitrum_GHOStewardV2Upgrade_20241007_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_GHOStewardV2Upgrade_20241007 internal proposal;
  address public RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;
  uint64 public remoteChainSelector = 5009297550715157269;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 264094912);
    proposal = new AaveV3Arbitrum_GHOStewardV2Upgrade_20241007();
  }

  function test_rolesAreSet_cannotReinitializePoolToken() public {
    // Gho Bucket Steward
    assertEq(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.GHO_BUCKET_STEWARD()
      ),
      false
    );

    // Gho Aave Steward
    assertEq(
      IAccessControl(address(AaveV3Arbitrum.ACL_MANAGER)).hasRole(
        IACLManager(address(AaveV3Arbitrum.ACL_MANAGER)).RISK_ADMIN_ROLE(),
        proposal.GHO_AAVE_STEWARD()
      ),
      false
    );

    // Gho CCIP Steward
    vm.expectRevert(); // getRateLimitAdmin doesn't exist yet
    IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL).getRateLimitAdmin();

    executePayload(vm, address(proposal));

    vm.prank(MiscArbitrum.PROXY_ADMIN);
    address impl = TransparentUpgradeableProxy(payable(MiscArbitrum.GHO_CCIP_TOKEN_POOL))
      .implementation();

    IUpgradeableLockReleaseTokenPool poolTokenImpl = IUpgradeableLockReleaseTokenPool(
      proposal.NEW_CCIP_POOL_IMPL()
    );

    assertEq(impl, proposal.NEW_CCIP_POOL_IMPL());
    assertTrue(poolTokenImpl.owner() != address(0));

    address owner = makeAddr('owner');
    address router = makeAddr('router');
    address[] memory list = new address[](0);

    // Implementation cannot be re-initialized
    vm.expectRevert();
    poolTokenImpl.initialize(owner, list, router);

    // Proxy cannot be re-initialized
    vm.expectRevert();
    IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL).initialize(
      owner,
      list,
      router
    );

    // Gho Bucket Steward
    assertEq(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.GHO_BUCKET_STEWARD()
      ),
      true
    );

    assertTrue(
      IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).isControlledFacilitator(
        MiscArbitrum.GHO_CCIP_TOKEN_POOL
      )
    );

    // Gho Aave Steward
    assertEq(
      IAccessControl(address(AaveV3Arbitrum.ACL_MANAGER)).hasRole(
        IACLManager(address(AaveV3Arbitrum.ACL_MANAGER)).RISK_ADMIN_ROLE(),
        proposal.GHO_AAVE_STEWARD()
      ),
      true
    );

    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL).getRateLimitAdmin(),
      proposal.GHO_CCIP_STEWARD()
    );
  }

  function test_poolTokenFunctionality() public {
    executePayload(vm, address(proposal));

    IUpgradeableLockReleaseTokenPool poolToken = IUpgradeableLockReleaseTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    );

    assertEq(proposal.GHO_CCIP_STEWARD(), poolToken.getRateLimitAdmin());
    assertEq(GovernanceV3Arbitrum.EXECUTOR_LVL_1, poolToken.owner());

    address newAdmin = makeAddr('new-admin');

    vm.startPrank(GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    poolToken.setRateLimitAdmin(newAdmin);

    assertEq(newAdmin, poolToken.getRateLimitAdmin());
  }

  function test_ghoAaveSteward_updateGhoBorrowRate() public {
    executePayload(vm, address(proposal));

    address rateStrategyAddress = AaveV3Arbitrum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3ArbitrumAssets.GHO_UNDERLYING);

    IDefaultInterestRateStrategyV2.InterestRateData
      memory mockResponse = IDefaultInterestRateStrategyV2.InterestRateData({
        optimalUsageRatio: 100,
        baseVariableBorrowRate: 100,
        variableRateSlope1: 100,
        variableRateSlope2: 100
      });
    vm.mockCall(
      rateStrategyAddress,
      abi.encodeWithSelector(
        IDefaultInterestRateStrategyV2(rateStrategyAddress).getInterestRateDataBps.selector,
        AaveV3ArbitrumAssets.GHO_UNDERLYING
      ),
      abi.encode(mockResponse)
    );

    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    uint16 newOptimalUsageRatio = currentRates.optimalUsageRatio + 1;
    uint32 newBaseVariableBorrowRate = currentRates.baseVariableBorrowRate + 1;
    uint32 newVariableRateSlope1 = currentRates.variableRateSlope1 - 1;
    uint32 newVariableRateSlope2 = currentRates.variableRateSlope2 - 1;

    vm.startPrank(RISK_COUNCIL);
    IGhoAaveSteward(proposal.GHO_AAVE_STEWARD()).updateGhoBorrowRate(
      newOptimalUsageRatio,
      newBaseVariableBorrowRate,
      newVariableRateSlope1,
      newVariableRateSlope2
    );
    vm.stopPrank();

    vm.clearMockedCalls();

    assertEq(_getOptimalUsageRatio(), newOptimalUsageRatio);
    assertEq(_getBaseVariableBorrowRate(), newBaseVariableBorrowRate);
    assertEq(_getVariableRateSlope1(), newVariableRateSlope1);
    assertEq(_getVariableRateSlope2(), newVariableRateSlope2);
  }

  function test_ghoBucketSteward_updateFacilitatorBucketCapacity() public {
    executePayload(vm, address(proposal));

    (uint256 currentBucketCapacity, ) = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING)
      .getFacilitatorBucket(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
    vm.startPrank(RISK_COUNCIL);
    uint128 newBucketCapacity = uint128(currentBucketCapacity) + 1;
    IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).updateFacilitatorBucketCapacity(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL,
      newBucketCapacity
    );
    (uint256 bucketCapacity, ) = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING)
      .getFacilitatorBucket(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
    assertEq(bucketCapacity, newBucketCapacity);
  }

  function test_ghoBucketSteward_setControlledFacilitator() public {
    executePayload(vm, address(proposal));

    address[] memory newGsmList = new address[](1);
    address gho_gsm_4626 = makeAddr('gho_gsm_4626');
    newGsmList[0] = gho_gsm_4626;

    vm.startPrank(GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).setControlledFacilitator(newGsmList, true);
    assertTrue(
      IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).isControlledFacilitator(gho_gsm_4626)
    );

    IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).setControlledFacilitator(newGsmList, false);
    assertFalse(
      IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD()).isControlledFacilitator(gho_gsm_4626)
    );
  }

  function test_ghoCcipSteward_updateRateLimit() public {
    executePayload(vm, address(proposal));

    RateLimiter.TokenBucket memory outboundConfig = IUpgradeableLockReleaseTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(remoteChainSelector);
    RateLimiter.TokenBucket memory inboundConfig = IUpgradeableLockReleaseTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(remoteChainSelector);

    RateLimiter.Config memory newOutboundConfig = RateLimiter.Config({
      isEnabled: outboundConfig.isEnabled,
      capacity: outboundConfig.capacity + 1,
      rate: outboundConfig.rate
    });

    RateLimiter.Config memory newInboundConfig = RateLimiter.Config({
      isEnabled: outboundConfig.isEnabled,
      capacity: inboundConfig.capacity,
      rate: inboundConfig.rate
    });

    IGhoCcipSteward steward = IGhoCcipSteward(proposal.GHO_CCIP_STEWARD());

    // Currently rate limit set to 0, so can't even change by 1 because 100% of 0 is 0
    vm.startPrank(RISK_COUNCIL);
    vm.expectRevert('INVALID_RATE_LIMIT_UPDATE');
    steward.updateRateLimit(
      remoteChainSelector,
      newOutboundConfig.isEnabled,
      newOutboundConfig.capacity,
      newOutboundConfig.rate,
      newInboundConfig.isEnabled,
      newInboundConfig.capacity,
      newInboundConfig.rate
    );
  }

  function test_ghoCcipSteward_revertUpdateRateLimitUnauthorizedBeforeUpgrade() public {
    RateLimiter.TokenBucket memory mockConfig = RateLimiter.TokenBucket({
      rate: 50,
      capacity: 50,
      tokens: 1,
      lastUpdated: 1,
      isEnabled: true
    });
    // Mocking response due to rate limit currently being 0
    vm.mockCall(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL,
      abi.encodeWithSelector(
        IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL)
          .getCurrentOutboundRateLimiterState
          .selector,
        remoteChainSelector
      ),
      abi.encode(mockConfig)
    );

    RateLimiter.TokenBucket memory outboundConfig = IUpgradeableLockReleaseTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(remoteChainSelector);
    RateLimiter.TokenBucket memory inboundConfig = IUpgradeableLockReleaseTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(remoteChainSelector);

    RateLimiter.Config memory newOutboundConfig = RateLimiter.Config({
      isEnabled: outboundConfig.isEnabled,
      capacity: outboundConfig.capacity,
      rate: outboundConfig.rate + 1
    });

    RateLimiter.Config memory newInboundConfig = RateLimiter.Config({
      isEnabled: outboundConfig.isEnabled,
      capacity: inboundConfig.capacity,
      rate: inboundConfig.rate
    });

    IGhoCcipSteward steward = IGhoCcipSteward(proposal.GHO_CCIP_STEWARD());

    vm.expectRevert('Only callable by owner');
    vm.prank(RISK_COUNCIL);
    steward.updateRateLimit(
      remoteChainSelector,
      newOutboundConfig.isEnabled,
      newOutboundConfig.capacity,
      newOutboundConfig.rate,
      newInboundConfig.isEnabled,
      newInboundConfig.capacity,
      newInboundConfig.rate
    );
  }

  function test_ghoCcipSteward_updateRateLimitAfterPoolUpgrade() public {
    executePayload(vm, address(proposal));

    RateLimiter.TokenBucket memory mockConfig = RateLimiter.TokenBucket({
      rate: 50,
      capacity: 50,
      tokens: 1,
      lastUpdated: 1,
      isEnabled: true
    });

    // Mocking response due to rate limit currently being 0
    vm.mockCall(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL,
      abi.encodeWithSelector(
        IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL)
          .getCurrentOutboundRateLimiterState
          .selector,
        remoteChainSelector
      ),
      abi.encode(mockConfig)
    );
    vm.mockCall(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL,
      abi.encodeWithSelector(
        IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL)
          .getCurrentInboundRateLimiterState
          .selector,
        remoteChainSelector
      ),
      abi.encode(mockConfig)
    );

    RateLimiter.TokenBucket memory outboundConfig = IUpgradeableLockReleaseTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(remoteChainSelector);
    RateLimiter.TokenBucket memory inboundConfig = IUpgradeableLockReleaseTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(remoteChainSelector);

    RateLimiter.Config memory newOutboundConfig = RateLimiter.Config({
      isEnabled: outboundConfig.isEnabled,
      capacity: outboundConfig.capacity + 1,
      rate: outboundConfig.rate
    });

    RateLimiter.Config memory newInboundConfig = RateLimiter.Config({
      isEnabled: outboundConfig.isEnabled,
      capacity: inboundConfig.capacity + 1,
      rate: inboundConfig.rate
    });

    vm.startPrank(RISK_COUNCIL);
    IGhoCcipSteward(proposal.GHO_CCIP_STEWARD()).updateRateLimit(
      remoteChainSelector,
      newOutboundConfig.isEnabled,
      newOutboundConfig.capacity,
      newOutboundConfig.rate,
      newInboundConfig.isEnabled,
      newInboundConfig.capacity,
      newInboundConfig.rate
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_GHOStewardV2Upgrade_20241007',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  // Helpers
  function _getOptimalUsageRatio() internal view returns (uint16) {
    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    return currentRates.optimalUsageRatio;
  }

  function _getBaseVariableBorrowRate() internal view returns (uint32) {
    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    return currentRates.baseVariableBorrowRate;
  }

  function _getVariableRateSlope1() internal view returns (uint32) {
    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    return currentRates.variableRateSlope1;
  }

  function _getVariableRateSlope2() internal view returns (uint32) {
    IDefaultInterestRateStrategyV2.InterestRateData memory currentRates = _getGhoBorrowRates();
    return currentRates.variableRateSlope2;
  }

  function _getGhoBorrowRates()
    internal
    view
    returns (IDefaultInterestRateStrategyV2.InterestRateData memory)
  {
    address rateStrategyAddress = AaveV3Arbitrum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3ArbitrumAssets.GHO_UNDERLYING);
    return
      IDefaultInterestRateStrategyV2(rateStrategyAddress).getInterestRateDataBps(
        AaveV3ArbitrumAssets.GHO_UNDERLYING
      );
  }
}
