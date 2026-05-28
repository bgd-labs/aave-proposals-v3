// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumSpokes, AaveV4EthereumSpokePriceFeeds, AaveV4EthereumPositionManagers, AaveV4EthereumGetters} from 'aave-address-book/AaveV4Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IAaveOracle, IAccessManagerEnumerable, IHub, ISpoke, ITokenizationSpoke} from 'aave-address-book/AaveV4.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';
import {IAccessManager} from 'aave-v4/dependencies/openzeppelin/IAccessManager.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {ERC1967Utils} from 'aave-v4/dependencies/openzeppelin/ERC1967Utils.sol';
import {IChainlinkAggregator} from 'aave-helpers/src/interfaces/IChainlinkAggregator.sol';

import {IPendlePriceCapAdapter} from '../interfaces/IPendlePriceCapAdapter.sol';
import {AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514} from './AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514.sol';
import {AaveV4PayloadEthereumSpoke} from '../helpers/v4-spoke/AaveV4PayloadEthereumSpoke.sol';
import {AaveV4PayloadEthereumSpokeForkTestBase} from '../helpers/v4-spoke/AaveV4PayloadEthereumSpokeForkTestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260514_AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated/AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514.t.sol -vv
 */
contract AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514_Test is
  AaveV4PayloadEthereumSpokeForkTestBase
{
  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  IHub internal constant PLUS_HUB = AaveV4EthereumHubs.PLUS_HUB;
  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;

  ISpoke internal constant USDG_CORRELATED_SPOKE =
    ISpoke(0x956d8e0A89cfa3744428C4641b5a53B56167a7f9);

  address internal constant PT_USDG_24SEP2026_UNDERLYING =
    0xc1906aeCf868749a2DeE203F59b904c0cf212140;
  address internal constant PT_USDG_24SEP2026_PRICE_FEED =
    0xD2417d928B7649feb50E61D9cCA38e56EFB34902;

  address internal constant PLUS_HUB_IR_STRATEGY = 0x31280650661b8443723fa9739b3A164E3696af48;

  uint256 internal constant PT_USDG_24SEP2026_SUPPLY_CAP = 15_000_000;
  uint256 internal constant USDG_BORROW_CAP = 13_000_000;

  AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25193380);
    proposal = new AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    ISpoke[] memory existingSpokes = AaveV4EthereumGetters.getAllSpokes();
    ISpoke[] memory spokes = new ISpoke[](existingSpokes.length);
    uint256 j;
    for (uint256 i; i < existingSpokes.length; ++i) {
      // KELP_ESPOKE has no usable collateral at this fork block, breaking the V4 e2e harness.
      if (existingSpokes[i] == AaveV4EthereumSpokes.KELP_ESPOKE) continue;
      spokes[j++] = existingSpokes[i];
    }
    spokes[j] = USDG_CORRELATED_SPOKE;

    ITokenizationSpoke[] memory existingTokSpokes = AaveV4EthereumGetters
      .getAllTokenizationSpokes();
    ITokenizationSpoke[] memory tokenizationSpokes = new ITokenizationSpoke[](
      existingTokSpokes.length + 1
    );
    for (uint256 i; i < existingTokSpokes.length; ++i) {
      tokenizationSpokes[i] = existingTokSpokes[i];
    }
    tokenizationSpokes[existingTokSpokes.length] = ITokenizationSpoke(_discoverTokenizationSpoke());

    defaultTest({
      reportName: 'AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514',
      spokes: spokes,
      tokenizationSpokes: tokenizationSpokes,
      payload: address(proposal)
    });
  }

  function test_spokeConfiguratorRoleGranted() public {
    address executor = GovernanceV3Ethereum.EXECUTOR_LVL_1;
    (bool before, ) = ACCESS_MANAGER.hasRole(Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE, executor);
    assertFalse(before, 'Executor should not have SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE before');

    vm.recordLogs();
    GovV3Helpers.executePayload(vm, address(proposal));
    Vm.Log[] memory logs = vm.getRecordedLogs();

    bytes32 expectedRoleTopic = bytes32(uint256(Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE));
    bytes32 expectedAccountTopic = bytes32(uint256(uint160(executor)));

    bool grantedSeen;
    for (uint256 i; i < logs.length; ++i) {
      Vm.Log memory entry = logs[i];
      if (entry.emitter != address(ACCESS_MANAGER) || entry.topics.length < 3) continue;
      if (entry.topics[1] != expectedRoleTopic || entry.topics[2] != expectedAccountTopic) continue;
      if (entry.topics[0] == IAccessManager.RoleGranted.selector) grantedSeen = true;
    }
    assertTrue(
      grantedSeen,
      'RoleGranted(SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR_LVL_1) missing'
    );

    (bool afterRole, ) = ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      executor
    );
    assertTrue(
      afterRole,
      'Executor should hold SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE after execution'
    );
  }

  function test_assetListingOnPlusHub() public {
    vm.expectRevert();
    PLUS_HUB.getAssetId(PT_USDG_24SEP2026_UNDERLYING);

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 assetId = PLUS_HUB.getAssetId(PT_USDG_24SEP2026_UNDERLYING);
    IHub.AssetConfig memory config = PLUS_HUB.getAssetConfig(assetId);
    assertEq(config.feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE));
    assertEq(config.liquidityFee, 0);
    assertEq(config.irStrategy, PLUS_HUB_IR_STRATEGY);
    assertEq(config.reinvestmentController, address(0));

    IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(
      config.irStrategy
    ).getInterestRateData(assetId);
    assertEq(irData.optimalUsageRatio, 99_00);
    assertEq(irData.baseDrawnRate, 0);
    assertEq(irData.rateGrowthBeforeOptimal, 0);
    assertEq(irData.rateGrowthAfterOptimal, 0);
  }

  function test_spokeDeployment_reservesAfterPayload() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(USDG_CORRELATED_SPOKE.getReserveCount(), 2);
  }

  function test_tokenizationSpokeDeployedAndRegistered() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address tokenizationSpoke = _findTokenizationSpoke(PLUS_HUB, PT_USDG_24SEP2026_UNDERLYING);
    assertTrue(tokenizationSpoke != address(0), 'TokenizationSpoke not registered on PLUS_HUB');

    address proxyAdmin = address(
      uint160(uint256(vm.load(tokenizationSpoke, ERC1967Utils.ADMIN_SLOT)))
    );
    assertEq(
      IOwnable(proxyAdmin).owner(),
      address(GovV3Helpers.getPayloadsController(block.chainid)),
      'TokenizationSpoke ProxyAdmin owner should be the PayloadsController'
    );

    assertEq(ITokenizationSpoke(tokenizationSpoke).hub(), address(PLUS_HUB));
    assertEq(ITokenizationSpoke(tokenizationSpoke).asset(), PT_USDG_24SEP2026_UNDERLYING);
    assertEq(
      keccak256(bytes(ITokenizationSpoke(tokenizationSpoke).name())),
      keccak256(bytes(proposal.TOKENIZATION_SPOKE_NAME()))
    );
    assertEq(
      keccak256(bytes(ITokenizationSpoke(tokenizationSpoke).symbol())),
      keccak256(bytes(proposal.TOKENIZATION_SPOKE_SYMBOL()))
    );

    uint256 assetId = PLUS_HUB.getAssetId(PT_USDG_24SEP2026_UNDERLYING);
    IHub.SpokeConfig memory tokConfig = PLUS_HUB.getSpokeConfig(assetId, tokenizationSpoke);
    assertEq(tokConfig.addCap, 0, 'TokenizationSpoke addCap should be 0');
  }

  function test_spokeRegistrationsAndCaps() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    (uint256 ptAssetId, uint256 usdgAssetId) = _assetIds();
    IHub.SpokeConfig memory ptConfig = PLUS_HUB.getSpokeConfig(
      ptAssetId,
      address(USDG_CORRELATED_SPOKE)
    );
    assertEq(ptConfig.addCap, uint40(PT_USDG_24SEP2026_SUPPLY_CAP));
    assertEq(ptConfig.drawCap, 0);
    assertEq(ptConfig.riskPremiumThreshold, 0);
    assertTrue(ptConfig.active);
    assertFalse(ptConfig.halted);

    IHub.SpokeConfig memory usdgConfig = CORE_HUB.getSpokeConfig(
      usdgAssetId,
      address(USDG_CORRELATED_SPOKE)
    );
    assertEq(usdgConfig.addCap, 0);
    assertEq(usdgConfig.drawCap, uint40(USDG_BORROW_CAP));
    assertEq(usdgConfig.riskPremiumThreshold, 0);
    assertTrue(usdgConfig.active);
    assertFalse(usdgConfig.halted);
  }

  function test_reserveListings() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    (uint256 ptReserveId, uint256 usdgReserveId) = _localReserveIds();

    assertEq(
      address(USDG_CORRELATED_SPOKE.getReserve(ptReserveId).hub),
      address(PLUS_HUB),
      'PT-USDG reserve should be anchored to PLUS_HUB'
    );
    assertEq(
      address(USDG_CORRELATED_SPOKE.getReserve(usdgReserveId).hub),
      address(CORE_HUB),
      'USDG reserve should be anchored to CORE_HUB (cross-hub credit line)'
    );

    ISpoke.ReserveConfig memory ptConfig = USDG_CORRELATED_SPOKE.getReserveConfig(ptReserveId);
    assertEq(ptConfig.collateralRisk, 0);
    assertFalse(ptConfig.paused);
    assertFalse(ptConfig.frozen);
    assertFalse(ptConfig.borrowable);
    assertTrue(ptConfig.receiveSharesEnabled);
    assertEq(
      IAaveOracle(USDG_CORRELATED_SPOKE.ORACLE()).getReserveSource(ptReserveId),
      PT_USDG_24SEP2026_PRICE_FEED
    );
    ISpoke.DynamicReserveConfig memory ptDyn = USDG_CORRELATED_SPOKE.getDynamicReserveConfig(
      ptReserveId,
      0
    );
    assertEq(ptDyn.collateralFactor, 95_00);
    assertEq(ptDyn.maxLiquidationBonus, 102_00);
    assertEq(ptDyn.liquidationFee, 10_00);

    ISpoke.ReserveConfig memory usdgConfig = USDG_CORRELATED_SPOKE.getReserveConfig(usdgReserveId);
    assertEq(usdgConfig.collateralRisk, 0);
    assertFalse(usdgConfig.paused);
    assertFalse(usdgConfig.frozen);
    assertTrue(usdgConfig.borrowable);
    assertFalse(usdgConfig.receiveSharesEnabled);
    assertEq(
      IAaveOracle(USDG_CORRELATED_SPOKE.ORACLE()).getReserveSource(usdgReserveId),
      AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDG_PRICE_FEED
    );
    ISpoke.DynamicReserveConfig memory usdgDyn = USDG_CORRELATED_SPOKE.getDynamicReserveConfig(
      usdgReserveId,
      0
    );
    assertEq(usdgDyn.collateralFactor, 0);
    assertEq(usdgDyn.maxLiquidationBonus, 100_00);
    assertEq(usdgDyn.liquidationFee, 0);
  }

  function test_liquidationConfig() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    ISpoke.LiquidationConfig memory liq = USDG_CORRELATED_SPOKE.getLiquidationConfig();
    assertEq(uint256(liq.targetHealthFactor), 1.0277e18);
    assertEq(uint256(liq.healthFactorForMaxBonus), 0.99e18);
    assertEq(uint256(liq.liquidationBonusFactor), 100_00);
  }

  function test_spokeDeployment_maxUserReservesLimit() public view {
    assertEq(uint256(USDG_CORRELATED_SPOKE.MAX_USER_RESERVES_LIMIT()), type(uint16).max);
  }

  function test_spokeDeployment_proxyAdminOwnedByExecutor() public view {
    address proxyAdmin = address(
      uint160(uint256(vm.load(address(USDG_CORRELATED_SPOKE), ERC1967Utils.ADMIN_SLOT)))
    );
    assertGt(proxyAdmin.code.length, 0, 'proxy admin not deployed');

    assertEq(IOwnable(proxyAdmin).owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
  }

  function test_spokeDeployment_noReservesBeforePayload() public view {
    assertEq(USDG_CORRELATED_SPOKE.getReserveCount(), 0);
  }

  function test_priceFeed_withinExpectedBounds() public view {
    int256 price = IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).latestAnswer();

    // At fork block (~mid-May 2026) with discountRatePerYear = 4.5% and ~4 months to maturity,
    // the expected discount is ~1.5%, so price ~ 0.985e8. Anything below 0.98e8 indicates drift.
    assertGt(price, int256(0.98e8), 'PT-USDG price below expected lower bound');
    assertLe(price, int256(1e8), 'PT-USDG price above par');
  }

  function test_priceFeed_decimalsAndAggregator() public view {
    assertEq(IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).decimals(), 8);
    assertEq(
      IPendlePriceCapAdapter(PT_USDG_24SEP2026_PRICE_FEED).ASSET_TO_USD_AGGREGATOR(),
      AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDG_PRICE_FEED,
      'Pendle adapter should use the V4 USDG/USD aggregator as its source'
    );
  }

  function test_priceFeed_discountRateBelowMax() public view {
    IPendlePriceCapAdapter adapter = IPendlePriceCapAdapter(PT_USDG_24SEP2026_PRICE_FEED);
    assertEq(adapter.discountRatePerYear(), 0.045e18, 'initialDiscountRatePerYear should be 4.50%');
    assertEq(
      adapter.MAX_DISCOUNT_RATE_PER_YEAR(),
      0.1038e18,
      'maxDiscountRatePerYear should be 10.38%'
    );
  }

  function test_priceFeed_discountFollowsLinearFormula() public view {
    IPendlePriceCapAdapter adapter = IPendlePriceCapAdapter(PT_USDG_24SEP2026_PRICE_FEED);
    uint256 timeToMaturity = adapter.MATURITY() - block.timestamp;
    uint256 expectedDiscount = (uint256(adapter.discountRatePerYear()) * timeToMaturity) / 365 days;
    assertEq(
      adapter.getCurrentDiscount(),
      expectedDiscount,
      'discount should equal discountRatePerYear * timeToMaturity / SECONDS_PER_YEAR'
    );
  }

  function test_priceFeed_priceLinearDiscountToUnderlying() public view {
    IPendlePriceCapAdapter adapter = IPendlePriceCapAdapter(PT_USDG_24SEP2026_PRICE_FEED);
    int256 underlyingPrice = IChainlinkAggregator(
      AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDG_PRICE_FEED
    ).latestAnswer();
    int256 ptPrice = IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).latestAnswer();

    uint256 discount = adapter.getCurrentDiscount();
    uint256 expected = (uint256(underlyingPrice) * (1e18 - discount)) / 1e18;
    assertEq(uint256(ptPrice), expected, 'PT price does not equal underlying * (1 - discount)');
    assertLt(uint256(ptPrice), uint256(underlyingPrice), 'PT should trade below underlying');
  }

  function test_priceFeed_pricesAtParAtMaturity() public {
    IPendlePriceCapAdapter adapter = IPendlePriceCapAdapter(PT_USDG_24SEP2026_PRICE_FEED);
    vm.warp(adapter.MATURITY());
    assertEq(adapter.getCurrentDiscount(), 0, 'discount should be zero at maturity');

    int256 underlyingPrice = IChainlinkAggregator(
      AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDG_PRICE_FEED
    ).latestAnswer();
    int256 ptPrice = IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).latestAnswer();
    assertEq(ptPrice, underlyingPrice, 'PT should track underlying once matured');
  }

  function test_priceFeed_returnsZeroOnNonPositiveSource() public {
    vm.mockCall(
      AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDG_PRICE_FEED,
      abi.encodeWithSelector(IChainlinkAggregator.latestAnswer.selector),
      abi.encode(int256(0))
    );

    assertEq(IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).latestAnswer(), int256(0));
    vm.clearMockedCalls();
  }

  function test_plusHubIRStrategyMatchesExistingAsset() public view {
    address existingIrStrategy = PLUS_HUB
      .getAssetConfig(PLUS_HUB.getAssetId(AaveV4EthereumAssets.USDe_UNDERLYING))
      .irStrategy;
    assertEq(
      PLUS_HUB_IR_STRATEGY,
      existingIrStrategy,
      'Hardcoded PLUS_HUB IR strategy drifted from the live USDe asset config'
    );
  }

  function test_positionManagersInactive_beforePayload() public view {
    assertFalse(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER)
      )
    );
    assertFalse(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER)
      )
    );
    assertFalse(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER)
      )
    );
    assertFalse(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY)
      )
    );
  }

  /// @dev The on-chain HubEngine library embeds a possibly older TokenizationSpokeInstance
  /// creation code than our local copy, so CREATE2 prediction via TokenizationSpokeDeployer
  /// is unreliable. Snapshot, run the payload, read the new spoke off the hub, revert.
  function _discoverTokenizationSpoke() internal returns (address tokenizationSpoke) {
    uint256 snapshotId = vm.snapshotState();
    GovV3Helpers.executePayload(vm, address(proposal));
    tokenizationSpoke = _findTokenizationSpoke(PLUS_HUB, PT_USDG_24SEP2026_UNDERLYING);
    vm.revertToState(snapshotId);
  }

  function _assetIds() internal view returns (uint256 ptAssetId, uint256 usdgAssetId) {
    ptAssetId = PLUS_HUB.getAssetId(PT_USDG_24SEP2026_UNDERLYING);
    usdgAssetId = CORE_HUB.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
  }

  function _localReserveIds() internal view returns (uint256 ptReserveId, uint256 usdgReserveId) {
    (uint256 ptAssetId, uint256 usdgAssetId) = _assetIds();
    ptReserveId = USDG_CORRELATED_SPOKE.getReserveId(address(PLUS_HUB), ptAssetId);
    usdgReserveId = USDG_CORRELATED_SPOKE.getReserveId(address(CORE_HUB), usdgAssetId);
  }

  function _payload() internal view override returns (AaveV4PayloadEthereumSpoke) {
    return proposal;
  }

  function _reserveTestCases() internal pure override returns (ReserveTestCase[] memory) {
    ReserveTestCase[] memory cases = new ReserveTestCase[](1);
    cases[0] = ReserveTestCase({
      collateralHub: AaveV4EthereumHubs.PLUS_HUB,
      collateralUnderlying: PT_USDG_24SEP2026_UNDERLYING,
      collateralPriceFeed: PT_USDG_24SEP2026_PRICE_FEED,
      borrowHub: AaveV4EthereumHubs.CORE_HUB,
      borrowUnderlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      supplyAmount: 500_000 * 1e6,
      borrowAmount: 460_000 * 1e6,
      borrowAmountOverCF: 475_000 * 1e6,
      unhealthyCollateralPrice: int256(0.93e8),
      partialLiquidationDebtAmount: 200_000 * 1e6,
      healthyLiquidationDebtAmount: 10_000 * 1e6
    });
    return cases;
  }

  function _tokenizationTestCases() internal pure override returns (TokenizationTestCase[] memory) {
    TokenizationTestCase[] memory cases = new TokenizationTestCase[](1);
    cases[0] = TokenizationTestCase({
      hub: AaveV4EthereumHubs.PLUS_HUB,
      underlying: PT_USDG_24SEP2026_UNDERLYING,
      depositAmount: 100_000 * 1e6,
      spokeAssetIdAddCap: 1_000_000
    });
    return cases;
  }

  function _canonicalSpokeImplementation() internal pure override returns (address) {
    return 0xf5c2dEeE8ccB3341449aA020E23FB34A22e7D989;
  }
}
