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
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {AaveV3Base_GHOGnosisLaunch_20250421} from './AaveV3Base_GHOGnosisLaunch_20250421.sol';
import {AaveV3Base_GHOBaseListing_20250421} from './AaveV3Base_GHOBaseListing_20250421.sol';

/**
 * @dev Test for AaveV3Base_Ads_20241231
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250421_Multi_GHOGnosisLaunch/AaveV3Base_GHOBaseListing_20250421.t.sol -vv
 */
contract AaveV3Base_GHOBaseListing_20250421_Base is ProtocolV3TestBase {
  AaveV3Base_GHOBaseListing_20250421 internal proposal;

  ITokenAdminRegistry internal constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);
  address internal constant ROUTER = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;
  address internal constant RMN_PROXY = 0xC842c69d54F83170C42C4d556B4F6B2ca53Dd3E8;
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;
  IGhoToken internal constant GHO_TOKEN = IGhoToken(0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee);
  address internal constant NEW_REMOTE_POOL_ARB = 0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB;
  address internal constant NEW_REMOTE_POOL_ETH = 0x06179f7C1be40863405f374E7f5F8806c728660A;
  IGhoAaveSteward internal constant NEW_GHO_AAVE_STEWARD =
    IGhoAaveSteward(0xC5BcC58BE6172769ca1a78B8A45752E3C5059c39);
  IGhoBucketSteward internal constant NEW_GHO_BUCKET_STEWARD =
    IGhoBucketSteward(0x3c47237479e7569653eF9beC4a7Cd2ee3F78b396);
  IGhoCcipSteward internal constant NEW_GHO_CCIP_STEWARD =
    IGhoCcipSteward(0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB);
  IUpgradeableBurnMintTokenPool_1_5_1 internal constant NEW_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34);

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('base'), 25645172);
    proposal = new AaveV3Base_GHOBaseListing_20250421();
  }

  function _executeLaunchAIP() internal {
    executePayload(vm, address(new AaveV3Base_GHOGnosisLaunch_20250421()));
  }

  function _mockBridgeSeedAmount() internal {
    uint256 seedAmount = proposal.GHO_SEED_AMOUNT();
    vm.prank(address(NEW_TOKEN_POOL));
    GHO_TOKEN.mint(GovernanceV3Base.EXECUTOR_LVL_1, seedAmount);
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

contract AaveV3Base_GHOBaseListing_20250421_ListingPreRequisites is
  AaveV3Base_GHOBaseListing_20250421_Base
{
  uint40 internal payloadId;

  function setUp() public override {
    super.setUp();
    payloadId = GovV3Helpers.readyPayload(vm, address(proposal));
  }

  function test_listingFailsPreLaunch() public {
    vm.expectRevert(bytes(Errors.FAILED_ACTION_EXECUTION));
    GovernanceV3Base.PAYLOADS_CONTROLLER.executePayload(payloadId);
  }

  function test_listingFailsWithoutSeedAmount() public {
    test_listingFailsPreLaunch();
    _executeLaunchAIP(); // activates CCIP lane

    vm.expectRevert(bytes(Errors.FAILED_ACTION_EXECUTION)); // assertion failed on _preExecute()
    GovernanceV3Base.PAYLOADS_CONTROLLER.executePayload(payloadId);
  }

  function test_listingSucceedsOnlyAfterLaunchAndSeedAmount() public {
    test_listingFailsWithoutSeedAmount();
    _mockBridgeSeedAmount();

    GovernanceV3Base.PAYLOADS_CONTROLLER.executePayload(payloadId);

    (, , , , , , , , bool isActive, ) = AaveV3Base
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveConfigurationData(proposal.GHO_TOKEN());
    assertTrue(isActive);
  }
}

contract AaveV3Base_GHOBaseListing_20250421_Listing is AaveV3Base_GHOBaseListing_20250421_Base {
  function setUp() public override {
    super.setUp();
    _executeLaunchAIP(); // deploys gho token, token pool & stewards
    _mockBridgeSeedAmount();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_GHOBaseListing_20250421', AaveV3Base.POOL, address(proposal));

    (address aGhoToken, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.GHO_TOKEN()
    );
    assertGe(IERC20(aGhoToken).balanceOf(address(0)), proposal.GHO_SEED_AMOUNT());
  }

  function test_ghoPriceFeed() public view {
    IGhoOracle priceOracle = IGhoOracle(proposal.GHO_PRICE_FEED());
    assertEq(priceOracle.latestAnswer(), 1e8);
    assertEq(priceOracle.decimals(), 8);
  }

  function test_ghoAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aGhoToken, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.GHO_TOKEN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(proposal.GHO_TOKEN()),
      proposal.EMISSION_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(aGhoToken),
      proposal.EMISSION_ADMIN()
    );
  }
}

contract AaveV3Base_GHOBaseListing_20250421_Stewards is AaveV3Base_GHOBaseListing_20250421_Base {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  function setUp() public override {
    super.setUp();
    _executeLaunchAIP(); // deploys gho token, token pool & stewards
    _mockBridgeSeedAmount();

    executePayload(vm, address(proposal));
  }

  function test_aaveStewardCanUpdateBorrowRate() public {
    IDefaultInterestRateStrategyV2 irStrategy = IDefaultInterestRateStrategyV2(
      AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getInterestRateStrategyAddress(address(GHO_TOKEN))
    );

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRateData = IDefaultInterestRateStrategyV2.InterestRateData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_50,
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
    uint256 currentBorrowCap = AaveV3Base.POOL.getConfiguration(address(GHO_TOKEN)).getBorrowCap();
    assertEq(currentBorrowCap, 2_250_000);
    vm.assume(
      newBorrowCap != currentBorrowCap &&
        _isDifferenceLowerThanMax(currentBorrowCap, newBorrowCap, currentBorrowCap)
    );

    vm.prank(RISK_COUNCIL);
    NEW_GHO_AAVE_STEWARD.updateGhoBorrowCap(newBorrowCap);

    assertEq(AaveV3Base.POOL.getConfiguration(address(GHO_TOKEN)).getBorrowCap(), newBorrowCap);
    assertEq(NEW_GHO_AAVE_STEWARD.getGhoTimelocks().ghoBorrowCapLastUpdate, vm.getBlockTimestamp());
  }

  function test_aaveStewardCanUpdateSupplyCap(uint256 newSupplyCap) public {
    uint256 currentSupplyCap = AaveV3Base.POOL.getConfiguration(address(GHO_TOKEN)).getSupplyCap();
    assertEq(currentSupplyCap, 2_500_000);

    vm.assume(
      currentSupplyCap != newSupplyCap &&
        _isDifferenceLowerThanMax(currentSupplyCap, newSupplyCap, currentSupplyCap)
    );

    vm.prank(RISK_COUNCIL);
    NEW_GHO_AAVE_STEWARD.updateGhoSupplyCap(newSupplyCap);

    assertEq(AaveV3Base.POOL.getConfiguration(address(GHO_TOKEN)).getSupplyCap(), newSupplyCap);
    assertEq(NEW_GHO_AAVE_STEWARD.getGhoTimelocks().ghoSupplyCapLastUpdate, vm.getBlockTimestamp());
  }

  function test_bucketStewardCanUpdateBucketCapacity(uint256 newBucketCapacity) public {
    (uint256 currentBucketCapacity, ) = GHO_TOKEN.getFacilitatorBucket(address(NEW_TOKEN_POOL));
    assertEq(currentBucketCapacity, 20_000_000e18);
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
