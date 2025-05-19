// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {DataTypes, IDefaultInterestRateStrategyV2} from 'aave-address-book/AaveV3.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IGhoAaveSteward} from 'src/interfaces/IGhoAaveSteward.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoCcipSteward} from 'src/interfaces/IGhoCcipSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGhoOracle} from 'src/interfaces/IGhoOracle.sol';

import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {Errors} from 'aave-address-book/governance-v3/Errors.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOLaunchConstants} from './utils/GHOLaunchConstants.sol';
import {AaveV3Gnosis_GHOGnosisLaunch_20250421} from './AaveV3Gnosis_GHOGnosisLaunch_20250421.sol';
import {AaveV3Gnosis_GHOGnosisListing_20250421} from './AaveV3Gnosis_GHOGnosisListing_20250421.sol';

/**
 * @dev Test for AaveV3Gnosis_Ads_20241231
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250421_Multi_GHOGnosisLaunch/AaveV3Gnosis_GHOGnosisListing_20250421.t.sol -vv
 */
contract AaveV3Gnosis_GHOGnosisListing_20250421_Base is ProtocolV3TestBase {
  AaveV3Gnosis_GHOGnosisListing_20250421 internal proposal;

  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(GHOLaunchConstants.GNO_TOKEN_ADMIN_REGISTRY);
  address internal constant ROUTER = GHOLaunchConstants.GNO_CCIP_ROUTER;
  address internal constant RMN_PROXY = GHOLaunchConstants.GNO_RMN_PROXY;
  address internal constant RISK_COUNCIL = GHOLaunchConstants.RISK_COUNCIL;
  IGhoToken internal constant GHO_TOKEN = IGhoToken(GHOLaunchConstants.GNO_GHO_TOKEN);
  address internal constant NEW_REMOTE_POOL_ARB = GhoArbitrum.GHO_CCIP_TOKEN_POOL;
  address internal constant NEW_REMOTE_POOL_ETH = GhoEthereum.GHO_CCIP_TOKEN_POOL;
  address internal constant NEW_REMOTE_POOL_BASE = GhoBase.GHO_CCIP_TOKEN_POOL;
  IGhoAaveSteward internal constant NEW_GHO_AAVE_STEWARD =
    IGhoAaveSteward(GHOLaunchConstants.GNO_AAVE_STEWARD);
  IGhoBucketSteward internal constant NEW_GHO_BUCKET_STEWARD =
    IGhoBucketSteward(GHOLaunchConstants.GNO_BUCKET_STEWARD);
  IGhoCcipSteward internal constant NEW_GHO_CCIP_STEWARD =
    IGhoCcipSteward(GHOLaunchConstants.GNO_CCIP_STEWARD);
  IUpgradeableBurnMintTokenPool_1_5_1 internal constant NEW_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GHOLaunchConstants.GNO_TOKEN_POOL);

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 40139698);
    proposal = new AaveV3Gnosis_GHOGnosisListing_20250421();
  }

  function _executeLaunchAIP() internal {
    executePayload(vm, address(new AaveV3Gnosis_GHOGnosisLaunch_20250421()));
  }

  function _mockBridgeSeedAmount() internal {
    uint256 seedAmount = proposal.GHO_SEED_AMOUNT();
    vm.prank(address(NEW_TOKEN_POOL));
    GHO_TOKEN.mint(GovernanceV3Gnosis.EXECUTOR_LVL_1, seedAmount);
  }

  function _isDifferenceLowerThanMax(
    uint256 from,
    uint256 to,
    uint256 max
  ) internal pure returns (bool) {
    return from < to ? to - from <= max : from - to <= max;
  }

  function assertEq(
    IRateLimiter.TokenBucket memory bucket,
    IRateLimiter.Config memory config
  ) internal pure {
    assertEq(bucket.capacity, config.capacity);
    assertEq(bucket.rate, config.rate);
    assertEq(bucket.isEnabled, config.isEnabled);
  }

  function assertEq(
    IDefaultInterestRateStrategyV2.InterestRateData memory a,
    IDefaultInterestRateStrategyV2.InterestRateData memory b
  ) internal pure {
    assertEq(a.optimalUsageRatio, b.optimalUsageRatio);
    assertEq(a.baseVariableBorrowRate, b.baseVariableBorrowRate);
    assertEq(a.variableRateSlope1, b.variableRateSlope1);
    assertEq(a.variableRateSlope2, b.variableRateSlope2);
  }
}

contract AaveV3Gnosis_GHOGnosisListing_20250421_ListingPreRequisites is
  AaveV3Gnosis_GHOGnosisListing_20250421_Base
{
  uint40 internal payloadId;

  function setUp() public override {
    super.setUp();
    payloadId = GovV3Helpers.readyPayload(vm, address(proposal));
  }

  function test_listingFailsPreLaunch() public {
    vm.expectRevert(bytes(Errors.FAILED_ACTION_EXECUTION));
    GovernanceV3Gnosis.PAYLOADS_CONTROLLER.executePayload(payloadId);
  }

  function test_listingFailsWithoutSeedAmount() public {
    test_listingFailsPreLaunch();
    _executeLaunchAIP(); // activates CCIP lane

    vm.expectRevert(bytes(Errors.FAILED_ACTION_EXECUTION)); // assertion failed on _preExecute()
    GovernanceV3Gnosis.PAYLOADS_CONTROLLER.executePayload(payloadId);
  }

  function test_listingSucceedsOnlyAfterLaunchAndSeedAmount() public {
    test_listingFailsWithoutSeedAmount();
    _mockBridgeSeedAmount();

    GovernanceV3Gnosis.PAYLOADS_CONTROLLER.executePayload(payloadId);

    (, , , , , , , , bool isActive, ) = AaveV3Gnosis
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveConfigurationData(proposal.GHO_TOKEN());
    assertTrue(isActive);
  }
}

contract AaveV3Gnosis_GHOGnosisListing_20250421_Listing is
  AaveV3Gnosis_GHOGnosisListing_20250421_Base
{
  function setUp() public override {
    super.setUp();
    _executeLaunchAIP(); // deploys gho token, token pool & stewards
    _mockBridgeSeedAmount();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Gnosis_GHOGnosisListing_20250421', AaveV3Gnosis.POOL, address(proposal));

    (address aGhoToken, , ) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.GHO_TOKEN()
    );
    assertGe(IERC20(aGhoToken).balanceOf(AaveV3Gnosis.DUST_BIN), proposal.GHO_SEED_AMOUNT());
  }

  function test_ghoPriceFeed() public view {
    IGhoOracle priceOracle = IGhoOracle(proposal.GHO_PRICE_FEED());
    assertEq(priceOracle.latestAnswer(), 1e8);
    assertEq(priceOracle.decimals(), 8);
  }

  function test_ghoAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aGhoToken, , ) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.GHO_TOKEN()
    );
    assertEq(
      IEmissionManager(AaveV3Gnosis.EMISSION_MANAGER).getEmissionAdmin(proposal.GHO_TOKEN()),
      proposal.EMISSION_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Gnosis.EMISSION_MANAGER).getEmissionAdmin(aGhoToken),
      proposal.EMISSION_ADMIN()
    );
  }
}

contract AaveV3Gnosis_GHOGnosisListing_20250421_Stewards is
  AaveV3Gnosis_GHOGnosisListing_20250421_Base
{
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  function setUp() public override {
    super.setUp();
    _executeLaunchAIP(); // deploys gho token, token pool & stewards
    _mockBridgeSeedAmount();

    executePayload(vm, address(proposal));
  }

  function test_aaveStewardCanUpdateBorrowRate() public {
    IDefaultInterestRateStrategyV2 irStrategy = IDefaultInterestRateStrategyV2(
      AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getInterestRateStrategyAddress(address(GHO_TOKEN))
    );

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRateData = IDefaultInterestRateStrategyV2.InterestRateData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 6_50,
        variableRateSlope2: 50_00
      });

    assertEq(irStrategy.getInterestRateDataBps(address(GHO_TOKEN)), currentRateData);

    currentRateData.variableRateSlope1 -= 4_00;
    currentRateData.variableRateSlope2 -= 3_00;

    vm.prank(RISK_COUNCIL);
    NEW_GHO_AAVE_STEWARD.updateGhoBorrowRate(
      currentRateData.optimalUsageRatio,
      currentRateData.baseVariableBorrowRate,
      currentRateData.variableRateSlope1,
      currentRateData.variableRateSlope2
    );

    assertEq(irStrategy.getInterestRateDataBps(address(GHO_TOKEN)), currentRateData);
  }

  function test_aaveStewardCanUpdateBorrowCap(uint256 newBorrowCap) public {
    uint256 currentBorrowCap = AaveV3Gnosis
      .POOL
      .getConfiguration(address(GHO_TOKEN))
      .getBorrowCap();
    assertEq(currentBorrowCap, 2_250_000);
    vm.assume(
      newBorrowCap != currentBorrowCap &&
        _isDifferenceLowerThanMax(currentBorrowCap, newBorrowCap, currentBorrowCap)
    );

    vm.prank(RISK_COUNCIL);
    NEW_GHO_AAVE_STEWARD.updateGhoBorrowCap(newBorrowCap);

    assertEq(AaveV3Gnosis.POOL.getConfiguration(address(GHO_TOKEN)).getBorrowCap(), newBorrowCap);
    assertEq(NEW_GHO_AAVE_STEWARD.getGhoTimelocks().ghoBorrowCapLastUpdate, vm.getBlockTimestamp());
  }

  function test_aaveStewardCanUpdateSupplyCap(uint256 newSupplyCap) public {
    uint256 currentSupplyCap = AaveV3Gnosis
      .POOL
      .getConfiguration(address(GHO_TOKEN))
      .getSupplyCap();
    assertEq(currentSupplyCap, 2_500_000);

    vm.assume(
      currentSupplyCap != newSupplyCap &&
        _isDifferenceLowerThanMax(currentSupplyCap, newSupplyCap, currentSupplyCap)
    );

    vm.prank(RISK_COUNCIL);
    NEW_GHO_AAVE_STEWARD.updateGhoSupplyCap(newSupplyCap);

    assertEq(AaveV3Gnosis.POOL.getConfiguration(address(GHO_TOKEN)).getSupplyCap(), newSupplyCap);
    assertEq(NEW_GHO_AAVE_STEWARD.getGhoTimelocks().ghoSupplyCapLastUpdate, vm.getBlockTimestamp());
  }

  function test_bucketStewardCanUpdateBucketCapacity(uint256 newBucketCapacity) public {
    (uint256 currentBucketCapacity, ) = GHO_TOKEN.getFacilitatorBucket(address(NEW_TOKEN_POOL));
    assertEq(currentBucketCapacity, 15_000_000e18);
    newBucketCapacity = bound(
      newBucketCapacity,
      currentBucketCapacity + 1,
      2 * currentBucketCapacity
    );

    vm.startPrank(RISK_COUNCIL);
    NEW_GHO_BUCKET_STEWARD.updateFacilitatorBucketCapacity(
      address(NEW_TOKEN_POOL),
      uint128(newBucketCapacity)
    );

    assertEq(
      GHO_TOKEN.getFacilitator(address(NEW_TOKEN_POOL)).bucketCapacity,
      uint128(newBucketCapacity)
    );
  }

  function test_ccipStewardCanChangeAndDisableRateLimit() public {
    _runCcipStewardCanChangeAndDisableRateLimit(CCIPUtils.ETH_CHAIN_SELECTOR);
    skip(NEW_GHO_CCIP_STEWARD.MINIMUM_DELAY() + 1);
    _runCcipStewardCanChangeAndDisableRateLimit(CCIPUtils.ARB_CHAIN_SELECTOR);
  }

  function _runCcipStewardCanChangeAndDisableRateLimit(uint64 remoteChain) internal {
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
      remoteChain,
      outboundConfig.isEnabled,
      outboundConfig.capacity,
      outboundConfig.rate,
      inboundConfig.isEnabled,
      inboundConfig.capacity,
      inboundConfig.rate
    );

    assertEq(NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(remoteChain), outboundConfig);
    assertEq(NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(remoteChain), inboundConfig);
    assertEq(NEW_GHO_CCIP_STEWARD.getCcipTimelocks().rateLimitLastUpdate, vm.getBlockTimestamp());

    skip(NEW_GHO_CCIP_STEWARD.MINIMUM_DELAY() + 1);

    // now we assert the steward can disable the rate limit
    vm.prank(NEW_GHO_CCIP_STEWARD.RISK_COUNCIL());
    NEW_GHO_CCIP_STEWARD.updateRateLimit(remoteChain, false, 0, 0, false, 0, 0);

    IRateLimiter.Config memory disabledConfig = IRateLimiter.Config(false, 0, 0);
    assertEq(NEW_TOKEN_POOL.getCurrentOutboundRateLimiterState(remoteChain), disabledConfig);
    assertEq(NEW_TOKEN_POOL.getCurrentInboundRateLimiterState(remoteChain), disabledConfig);
    assertEq(NEW_GHO_CCIP_STEWARD.getCcipTimelocks().rateLimitLastUpdate, vm.getBlockTimestamp());
  }
}
