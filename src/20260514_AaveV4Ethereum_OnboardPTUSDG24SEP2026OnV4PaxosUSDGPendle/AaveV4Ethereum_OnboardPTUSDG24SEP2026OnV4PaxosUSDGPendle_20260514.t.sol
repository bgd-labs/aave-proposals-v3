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
import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {ERC1967Utils} from 'aave-v4/dependencies/openzeppelin/ERC1967Utils.sol';
import {IChainlinkAggregator} from 'aave-helpers/src/interfaces/IChainlinkAggregator.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {IPendlePriceCapAdapter} from '../interfaces/IPendlePriceCapAdapter.sol';
import {IPriceCapAdapterStable} from '../interfaces/IPriceCapAdapterStable.sol';
import {AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514} from './AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514.sol';
import {TokenizationSpokeLib} from '../helpers/v4-hub/TokenizationSpokeLib.sol';
import {AaveV4PayloadEthereumSpoke} from '../helpers/v4-spoke/AaveV4PayloadSpoke.sol';
import {AaveV4PayloadEthereumSpokeForkTestBase} from '../helpers/v4-spoke/AaveV4PayloadEthereumSpokeForkTestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260514_AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle/AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514.t.sol -vv
 */
contract AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514_Test is
  AaveV4PayloadEthereumSpokeForkTestBase
{
  using SafeERC20 for IERC20;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  IHub internal constant PAXOS_HUB = IHub(0x62d63197660c080236193CA60b70E49A08E90368);
  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;

  ISpoke internal constant USDG_PENDLE_SPOKE = ISpoke(0x956d8e0A89cfa3744428C4641b5a53B56167a7f9);

  address internal constant PT_USDG_24SEP2026_UNDERLYING =
    0xc1906aeCf868749a2DeE203F59b904c0cf212140;
  address internal constant PT_USDG_24SEP2026_PRICE_FEED =
    0x89F6Eb404AbF19FE817426dD2E2E0F14D1a5712e;

  // USDG CAPO (1.04 cap); backs both the USDG reserve and the PT-USDG adapter base.
  address internal constant USDG_PRICE_FEED = 0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4;
  address internal constant USDG_USD_CHAINLINK_FEED = 0x14f0737d6b705259e521EA6E9E3506AC78dBd311;
  // Legacy fixed $1.00 USDG feed retired by this proposal.
  address internal constant LEGACY_USDG_FEED = 0xF29b1e3b68Fd59DD0a413811fD5d0AbaE653216d;

  address internal constant PAXOS_HUB_IR_STRATEGY = 0xD7eC225DC053151100A0ef47b94a77AAD9C413b7;

  uint256 internal constant PT_USDG_24SEP2026_ADD_CAP = 15_000_000;
  uint256 internal constant USDC_ADD_CAP = 13_000_000;
  uint256 internal constant USDC_DRAW_CAP = 13_000_000;
  uint256 internal constant USDT_ADD_CAP = 13_000_000;
  uint256 internal constant USDT_DRAW_CAP = 13_000_000;
  uint256 internal constant USDG_DRAW_CAP = 30_000_000;

  AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25352820);
    proposal = new AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514();
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
    spokes[j] = USDG_PENDLE_SPOKE;

    ITokenizationSpoke[] memory existingTokSpokes = AaveV4EthereumGetters
      .getAllTokenizationSpokes();
    address[] memory newTokSpokes = _discoverNewTokenizationSpokes();
    ITokenizationSpoke[] memory tokenizationSpokes = new ITokenizationSpoke[](
      existingTokSpokes.length + newTokSpokes.length
    );
    for (uint256 i; i < existingTokSpokes.length; ++i) {
      tokenizationSpokes[i] = existingTokSpokes[i];
    }
    for (uint256 i; i < newTokSpokes.length; ++i) {
      tokenizationSpokes[existingTokSpokes.length + i] = ITokenizationSpoke(newTokSpokes[i]);
    }

    defaultTest({
      reportName: 'AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514',
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

    bytes32[] memory indexedArgs = new bytes32[](2);
    indexedArgs[0] = bytes32(uint256(Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE));
    indexedArgs[1] = bytes32(uint256(uint160(executor)));
    _assertEventEmitted({
      logs: logs,
      emitter: address(ACCESS_MANAGER),
      selector: IAccessManager.RoleGranted.selector,
      indexedArgs: indexedArgs,
      errMsg: 'RoleGranted(SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR_LVL_1) missing'
    });

    (bool afterRole, ) = ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      executor
    );
    assertTrue(
      afterRole,
      'Executor should hold SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE after execution'
    );
  }

  /// @dev Pins the per-asset interest-rate parameters on the Paxos Hub.
  function test_assetListingIRData() public {
    vm.expectRevert();
    PAXOS_HUB.getAssetId(PT_USDG_24SEP2026_UNDERLYING);

    GovV3Helpers.executePayload(vm, address(proposal));

    _assertHubAssetIRData(PT_USDG_24SEP2026_UNDERLYING, _expectedNonBorrowableIRData());
    _assertHubAssetIRData(AaveV4EthereumAssets.USDC_UNDERLYING, _expectedBorrowableIRData());
    _assertHubAssetIRData(AaveV4EthereumAssets.USDT_UNDERLYING, _expectedBorrowableIRData());
  }

  /// @dev Pins the absolute liquidity fees against the spec: 10% on the borrowable USDC/USDT,
  ///      0% on the collateral-only PT-USDG.
  function test_assetListingLiquidityFees() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(_hubAssetLiquidityFee(PT_USDG_24SEP2026_UNDERLYING), 0, 'PT-USDG liquidity fee != 0');
    assertEq(_hubAssetLiquidityFee(AaveV4EthereumAssets.USDC_UNDERLYING), 10_00, 'USDC fee != 10%');
    assertEq(_hubAssetLiquidityFee(AaveV4EthereumAssets.USDT_UNDERLYING), 10_00, 'USDT fee != 10%');
  }

  /// @dev PT-USDG is collateral-only (borrowable: false, hub drawCap 0): borrowing it must revert.
  function test_ptUsdg_notBorrowable() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('ptBorrowAttempt');
    uint256 ptReserveId = _reserveId(PAXOS_HUB, PT_USDG_24SEP2026_UNDERLYING);

    uint256 supplyAmount = 500_000 * 1e6;
    deal2(PT_USDG_24SEP2026_UNDERLYING, user, supplyAmount);
    vm.startPrank(user);
    IERC20(PT_USDG_24SEP2026_UNDERLYING).forceApprove(address(USDG_PENDLE_SPOKE), supplyAmount);
    USDG_PENDLE_SPOKE.supply(ptReserveId, supplyAmount, user);
    vm.expectRevert(ISpoke.ReserveNotBorrowable.selector);
    USDG_PENDLE_SPOKE.borrow(ptReserveId, 1_000 * 1e6, user);
    vm.stopPrank();
  }

  /// @dev USDC/USDT are listed with collateralFactor 0, so supplying them grants no borrowing
  ///      power: a borrow backed solely by USDC collateral must revert on health factor.
  function test_borrowableAssets_provideNoBorrowingPower() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('usdcCollateralAttempt');
    uint256 usdcReserveId = _reserveId(PAXOS_HUB, AaveV4EthereumAssets.USDC_UNDERLYING);
    uint256 usdtReserveId = _reserveId(PAXOS_HUB, AaveV4EthereumAssets.USDT_UNDERLYING);

    // Seed USDT borrow liquidity so the borrow reverts on HF, not on missing liquidity.
    address seeder = makeAddr('usdtSeeder');
    deal2(AaveV4EthereumAssets.USDT_UNDERLYING, seeder, 1_000_000 * 1e6);
    vm.startPrank(seeder);
    IERC20(AaveV4EthereumAssets.USDT_UNDERLYING).forceApprove(
      address(USDG_PENDLE_SPOKE),
      1_000_000 * 1e6
    );
    USDG_PENDLE_SPOKE.supply(usdtReserveId, 1_000_000 * 1e6, seeder);
    vm.stopPrank();

    uint256 supplyAmount = 500_000 * 1e6;
    deal2(AaveV4EthereumAssets.USDC_UNDERLYING, user, supplyAmount);
    vm.startPrank(user);
    IERC20(AaveV4EthereumAssets.USDC_UNDERLYING).forceApprove(
      address(USDG_PENDLE_SPOKE),
      supplyAmount
    );
    USDG_PENDLE_SPOKE.supply(usdcReserveId, supplyAmount, user);
    USDG_PENDLE_SPOKE.setUsingAsCollateral(usdcReserveId, true, user);
    vm.expectRevert(ISpoke.HealthFactorBelowThreshold.selector);
    USDG_PENDLE_SPOKE.borrow(usdtReserveId, 1_000 * 1e6, user);
    vm.stopPrank();
  }

  /// @dev Only PT-USDG, USDC and USDT are natively listed on Paxos; USDG (Core credit line) must
  ///      never be a Paxos asset.
  function test_hubAssetListings_excludeUSDG() public {
    IAaveV4ConfigEngine.AssetListing[] memory listings = proposal.hubAssetListings();
    assertEq(listings.length, 3, 'expected exactly three Paxos Hub asset listings');
    for (uint256 i; i < listings.length; ++i) {
      assertEq(listings[i].hub, address(PAXOS_HUB), 'all native listings must be on the Paxos Hub');
      assertTrue(
        listings[i].underlying != AaveV4EthereumAssets.USDG_UNDERLYING,
        'USDG must not be natively listed on the Paxos Hub'
      );
    }

    GovV3Helpers.executePayload(vm, address(proposal));
    vm.expectRevert();
    PAXOS_HUB.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
  }

  function test_paxosHubIRStrategyBoundToHub() public view {
    assertEq(
      IAssetInterestRateStrategy(PAXOS_HUB_IR_STRATEGY).HUB(),
      address(PAXOS_HUB),
      'IR strategy must be bound to the Paxos Hub'
    );
  }

  function test_spokeDeployment_reservesAfterPayload() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(USDG_PENDLE_SPOKE.getReserveCount(), 4);
  }

  function test_tokenizationSpokeDeployedAndRegistered() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address tokenizationSpoke = TokenizationSpokeLib.find(PAXOS_HUB, PT_USDG_24SEP2026_UNDERLYING);
    assertTrue(tokenizationSpoke != address(0), 'TokenizationSpoke not registered on PAXOS_HUB');

    address proxyAdmin = address(
      uint160(uint256(vm.load(tokenizationSpoke, ERC1967Utils.ADMIN_SLOT)))
    );
    assertEq(
      IOwnable(proxyAdmin).owner(),
      address(GovV3Helpers.getPayloadsController(block.chainid)),
      'TokenizationSpoke ProxyAdmin owner should be the PayloadsController'
    );

    assertEq(ITokenizationSpoke(tokenizationSpoke).hub(), address(PAXOS_HUB));
    assertEq(ITokenizationSpoke(tokenizationSpoke).asset(), PT_USDG_24SEP2026_UNDERLYING);
    assertEq(
      keccak256(bytes(ITokenizationSpoke(tokenizationSpoke).name())),
      keccak256(bytes(proposal.tokenizationSpokeName()))
    );
    assertEq(
      keccak256(bytes(ITokenizationSpoke(tokenizationSpoke).symbol())),
      keccak256(bytes(proposal.tokenizationSpokeSymbol()))
    );
    assertEq(proposal.tokenizationSpokeName(), 'Wrapped Aave Paxos PT_USDG_24SEP2026');
    assertEq(proposal.tokenizationSpokeSymbol(), 'waPaxosPT_USDG_24SEP2026');

    uint256 assetId = PAXOS_HUB.getAssetId(PT_USDG_24SEP2026_UNDERLYING);
    IHub.SpokeConfig memory tokConfig = PAXOS_HUB.getSpokeConfig(assetId, tokenizationSpoke);
    assertEq(tokConfig.addCap, 0, 'TokenizationSpoke addCap should be 0');
  }

  /// @dev USDC/USDT tokenization spokes open at a 13M cap (unlike the PT-USDG wrapper at 0); pins
  ///      the cap and exercises wrap/redeem.
  function test_tokenizationSpoke_usdcUsdtWrapAndRedeem() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address[2] memory underlyings = [
      AaveV4EthereumAssets.USDC_UNDERLYING,
      AaveV4EthereumAssets.USDT_UNDERLYING
    ];
    for (uint256 i; i < underlyings.length; ++i) {
      address tokenizationSpoke = TokenizationSpokeLib.find(PAXOS_HUB, underlyings[i]);
      assertTrue(tokenizationSpoke != address(0), 'tokenization spoke missing');

      uint256 assetId = PAXOS_HUB.getAssetId(underlyings[i]);
      assertEq(
        PAXOS_HUB.getSpokeConfig(assetId, tokenizationSpoke).addCap,
        uint40(13_000_000),
        'tokenization spoke addCap should be 13M'
      );

      uint256 depositAmount = 100_000 * 1e6;
      address user = makeAddr(string.concat('tokenizationWrapUser_', vm.toString(i)));
      deal2(underlyings[i], user, depositAmount);

      vm.startPrank(user);
      IERC20(underlyings[i]).forceApprove(tokenizationSpoke, depositAmount);
      uint256 shares = ITokenizationSpoke(tokenizationSpoke).deposit(depositAmount, user);
      vm.stopPrank();

      assertGt(shares, 0, 'no shares minted');
      assertEq(IERC20(tokenizationSpoke).balanceOf(user), shares);
      assertEq(ITokenizationSpoke(tokenizationSpoke).totalAssets(), depositAmount);

      uint256 redeemTarget = shares / 2;
      vm.prank(user);
      uint256 redeemedAssets = ITokenizationSpoke(tokenizationSpoke).redeem(
        redeemTarget,
        user,
        user
      );
      assertGt(redeemedAssets, 0, 'no assets redeemed');
      assertEq(IERC20(tokenizationSpoke).balanceOf(user), shares - redeemTarget);
      assertEq(IERC20(underlyings[i]).balanceOf(user), redeemedAssets);
    }
  }

  function test_spokeRegistrationsAndCaps() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _assertSpokeCaps(PAXOS_HUB, PT_USDG_24SEP2026_UNDERLYING, PT_USDG_24SEP2026_ADD_CAP, 0);
    _assertSpokeCaps(PAXOS_HUB, AaveV4EthereumAssets.USDC_UNDERLYING, USDC_ADD_CAP, USDC_DRAW_CAP);
    _assertSpokeCaps(PAXOS_HUB, AaveV4EthereumAssets.USDT_UNDERLYING, USDT_ADD_CAP, USDT_DRAW_CAP);
    _assertSpokeCaps(CORE_HUB, AaveV4EthereumAssets.USDG_UNDERLYING, 0, USDG_DRAW_CAP);
  }

  function test_reserveListings() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    // PT-USDG: collateral-only on the Paxos Hub.
    uint256 ptReserveId = _reserveId(PAXOS_HUB, PT_USDG_24SEP2026_UNDERLYING);
    assertEq(address(USDG_PENDLE_SPOKE.getReserve(ptReserveId).hub), address(PAXOS_HUB));
    ISpoke.ReserveConfig memory ptConfig = USDG_PENDLE_SPOKE.getReserveConfig(ptReserveId);
    assertEq(ptConfig.collateralRisk, 0);
    assertFalse(ptConfig.paused);
    assertFalse(ptConfig.frozen);
    assertFalse(ptConfig.borrowable);
    assertTrue(ptConfig.receiveSharesEnabled);
    assertEq(
      IAaveOracle(USDG_PENDLE_SPOKE.ORACLE()).getReserveSource(ptReserveId),
      PT_USDG_24SEP2026_PRICE_FEED
    );
    ISpoke.DynamicReserveConfig memory ptDyn = USDG_PENDLE_SPOKE.getDynamicReserveConfig(
      ptReserveId,
      0
    );
    assertEq(ptDyn.collateralFactor, 94_00);
    assertEq(ptDyn.maxLiquidationBonus, 103_20);
    assertEq(ptDyn.liquidationFee, 10_00);

    // USDC & USDT: natively suppliable + borrowable on the Paxos Hub, not collateral.
    _assertBorrowableReserve(
      PAXOS_HUB,
      AaveV4EthereumAssets.USDC_UNDERLYING,
      AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDC_PRICE_FEED,
      true
    );
    _assertBorrowableReserve(
      PAXOS_HUB,
      AaveV4EthereumAssets.USDT_UNDERLYING,
      AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDT_PRICE_FEED,
      true
    );

    // USDG: borrow-only, drawn from the Core Hub via the cross-hub credit line. Priced by the
    // new USDG CAPO, not the legacy constant-1 main-spoke feed.
    _assertBorrowableReserve(
      CORE_HUB,
      AaveV4EthereumAssets.USDG_UNDERLYING,
      USDG_PRICE_FEED,
      false
    );
  }

  function test_liquidationConfig() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    ISpoke.LiquidationConfig memory liq = USDG_PENDLE_SPOKE.getLiquidationConfig();
    assertEq(uint256(liq.targetHealthFactor), 1.0277e18);
    assertEq(uint256(liq.healthFactorForMaxBonus), 0.99e18);
    assertEq(uint256(liq.liquidationBonusFactor), 100_00);
  }

  function test_spokeDeployment_maxUserReservesLimit() public view {
    assertEq(uint256(USDG_PENDLE_SPOKE.MAX_USER_RESERVES_LIMIT()), type(uint16).max);
  }

  function test_spokeDeployment_proxyAdminOwnedByExecutor() public view {
    address proxyAdmin = address(
      uint160(uint256(vm.load(address(USDG_PENDLE_SPOKE), ERC1967Utils.ADMIN_SLOT)))
    );
    assertGt(proxyAdmin.code.length, 0, 'proxy admin not deployed');

    assertEq(IOwnable(proxyAdmin).owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
  }

  function test_spokeDeployment_noReservesBeforePayload() public view {
    assertEq(USDG_PENDLE_SPOKE.getReserveCount(), 0);
  }

  function test_priceFeed_withinExpectedBounds() public view {
    int256 price = IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).latestAnswer();

    // At fork block (~mid-June 2026) with discountRatePerYear = 4.5% and ~3 months to maturity,
    // the expected discount is ~1.25%, so price ~ 0.9875e8. Anything below 0.98e8 indicates drift.
    assertGt(price, int256(0.98e8), 'PT-USDG price below expected lower bound');
    assertLe(price, int256(1e8), 'PT-USDG price above par');
  }

  function test_priceFeed_decimalsAndAggregator() public view {
    assertEq(IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).decimals(), 8);
    assertEq(
      IPendlePriceCapAdapter(PT_USDG_24SEP2026_PRICE_FEED).ASSET_TO_USD_AGGREGATOR(),
      USDG_PRICE_FEED,
      'Pendle adapter should use the USDG CAPO as its source'
    );
  }

  function test_usdgCapo_wiringAndBounds() public view {
    IPriceCapAdapterStable capo = IPriceCapAdapterStable(USDG_PRICE_FEED);
    assertEq(IChainlinkAggregator(USDG_PRICE_FEED).decimals(), 8, 'USDG CAPO decimals != 8');
    assertEq(
      capo.ASSET_TO_USD_AGGREGATOR(),
      USDG_USD_CHAINLINK_FEED,
      'USDG CAPO should source the USDG/USD Chainlink feed'
    );
    assertEq(capo.getPriceCap(), int256(1.04e8), 'USDG CAPO price cap should be 1.04');
    assertFalse(capo.isCapped(), 'USDG CAPO should not be capped at current par price');

    int256 price = IChainlinkAggregator(USDG_PRICE_FEED).latestAnswer();
    assertGt(price, int256(0.98e8), 'USDG price below expected lower bound');
    assertLe(price, capo.getPriceCap(), 'USDG price must not exceed the cap');
  }

  function test_noStaleUsdgFeed_acrossAllSpokes() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    ISpoke[] memory base = AaveV4EthereumGetters.getAllSpokes();
    ISpoke[] memory spokes = new ISpoke[](base.length + 1);
    for (uint256 i; i < base.length; ++i) spokes[i] = base[i];
    spokes[base.length] = USDG_PENDLE_SPOKE;

    uint256 usdgReserves;
    for (uint256 i; i < spokes.length; ++i) {
      ISpoke spoke = spokes[i];
      IAaveOracle oracle = IAaveOracle(spoke.ORACLE());
      uint256 reserveCount = spoke.getReserveCount();
      for (uint256 reserveId; reserveId < reserveCount; ++reserveId) {
        address source = oracle.getReserveSource(reserveId);
        assertTrue(
          source != LEGACY_USDG_FEED,
          'legacy constant-1 USDG feed still wired on a spoke reserve'
        );
        if (spoke.getReserve(reserveId).underlying == AaveV4EthereumAssets.USDG_UNDERLYING) {
          assertEq(source, USDG_PRICE_FEED, 'USDG reserve not repriced to the CAPO');
          ++usdgReserves;
        }
      }
    }
    // FOREX, GOLD, MAIN (repointed in-place) + the new USDG Pendle spoke (listed against the CAPO).
    assertEq(usdgReserves, 4, 'expected exactly four USDG reserves across all spokes');
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
    int256 underlyingPrice = IChainlinkAggregator(USDG_PRICE_FEED).latestAnswer();
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

    int256 underlyingPrice = IChainlinkAggregator(USDG_PRICE_FEED).latestAnswer();
    int256 ptPrice = IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).latestAnswer();
    assertEq(ptPrice, underlyingPrice, 'PT should track underlying once matured');
  }

  function test_priceFeed_returnsZeroOnNonPositiveSource() public {
    vm.mockCall(
      USDG_PRICE_FEED,
      abi.encodeWithSelector(IChainlinkAggregator.latestAnswer.selector),
      abi.encode(int256(0))
    );

    assertEq(IChainlinkAggregator(PT_USDG_24SEP2026_PRICE_FEED).latestAnswer(), int256(0));
    vm.clearMockedCalls();
  }

  function test_positionManagersInactive_beforePayload() public view {
    assertFalse(
      USDG_PENDLE_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER)
      )
    );
    assertFalse(
      USDG_PENDLE_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER)
      )
    );
    assertFalse(
      USDG_PENDLE_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER)
      )
    );
    assertFalse(
      USDG_PENDLE_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY)
      )
    );
  }

  function _discoverNewTokenizationSpokes() internal returns (address[] memory tokenizationSpokes) {
    uint256 snapshotId = vm.snapshotState();
    GovV3Helpers.executePayload(vm, address(proposal));
    tokenizationSpokes = new address[](3);
    tokenizationSpokes[0] = TokenizationSpokeLib.find(PAXOS_HUB, PT_USDG_24SEP2026_UNDERLYING);
    tokenizationSpokes[1] = TokenizationSpokeLib.find(
      PAXOS_HUB,
      AaveV4EthereumAssets.USDC_UNDERLYING
    );
    tokenizationSpokes[2] = TokenizationSpokeLib.find(
      PAXOS_HUB,
      AaveV4EthereumAssets.USDT_UNDERLYING
    );
    vm.revertToState(snapshotId);
  }

  function _reserveId(IHub hub, address underlying) internal view returns (uint256) {
    return USDG_PENDLE_SPOKE.getReserveId(address(hub), hub.getAssetId(underlying));
  }

  function _assertHubAssetIRData(
    address underlying,
    IAssetInterestRateStrategy.InterestRateData memory expectedIrData
  ) internal view {
    uint256 assetId = PAXOS_HUB.getAssetId(underlying);
    IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(
      PAXOS_HUB_IR_STRATEGY
    ).getInterestRateData(assetId);
    assertEq(irData.optimalUsageRatio, expectedIrData.optimalUsageRatio);
    assertEq(irData.baseDrawnRate, expectedIrData.baseDrawnRate);
    assertEq(irData.rateGrowthBeforeOptimal, expectedIrData.rateGrowthBeforeOptimal);
    assertEq(irData.rateGrowthAfterOptimal, expectedIrData.rateGrowthAfterOptimal);
  }

  function _assertSpokeCaps(
    IHub hub,
    address underlying,
    uint256 expectedAddCap,
    uint256 expectedDrawCap
  ) internal view {
    IHub.SpokeConfig memory config = hub.getSpokeConfig(
      hub.getAssetId(underlying),
      address(USDG_PENDLE_SPOKE)
    );
    assertEq(config.addCap, uint40(expectedAddCap));
    assertEq(config.drawCap, uint40(expectedDrawCap));
    assertEq(config.riskPremiumThreshold, 0);
    assertTrue(config.active);
    assertFalse(config.halted);
  }

  function _assertBorrowableReserve(
    IHub hub,
    address underlying,
    address priceFeed,
    bool receiveSharesEnabled
  ) internal view {
    uint256 reserveId = _reserveId(hub, underlying);
    assertEq(address(USDG_PENDLE_SPOKE.getReserve(reserveId).hub), address(hub));
    ISpoke.ReserveConfig memory config = USDG_PENDLE_SPOKE.getReserveConfig(reserveId);
    assertEq(config.collateralRisk, 0);
    assertFalse(config.paused);
    assertFalse(config.frozen);
    assertTrue(config.borrowable);
    assertEq(config.receiveSharesEnabled, receiveSharesEnabled);
    assertEq(IAaveOracle(USDG_PENDLE_SPOKE.ORACLE()).getReserveSource(reserveId), priceFeed);
    ISpoke.DynamicReserveConfig memory dyn = USDG_PENDLE_SPOKE.getDynamicReserveConfig(
      reserveId,
      0
    );
    assertEq(dyn.collateralFactor, 0);
    assertEq(dyn.maxLiquidationBonus, 100_00);
    assertEq(dyn.liquidationFee, 0);
  }

  function _expectedNonBorrowableIRData()
    internal
    pure
    returns (IAssetInterestRateStrategy.InterestRateData memory)
  {
    return
      IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: 99_00,
        baseDrawnRate: 0,
        rateGrowthBeforeOptimal: 0,
        rateGrowthAfterOptimal: 0
      });
  }

  function _hubAssetLiquidityFee(address underlying) internal view returns (uint256) {
    uint256 assetId = PAXOS_HUB.getAssetId(underlying);
    return PAXOS_HUB.getAssetConfig(assetId).liquidityFee;
  }

  function _expectedBorrowableIRData()
    internal
    pure
    returns (IAssetInterestRateStrategy.InterestRateData memory)
  {
    return
      IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: 92_00,
        baseDrawnRate: 0,
        rateGrowthBeforeOptimal: 4_00,
        rateGrowthAfterOptimal: 20_00
      });
  }

  function _payload() internal view override returns (AaveV4PayloadEthereumSpoke) {
    return proposal;
  }

  /// @dev Three borrow legs against PT-USDG collateral: USDG (Core credit line, no seed), and
  ///      native USDC/USDT (seeded, since they have no depositors at the fork block).
  function _reserveTestCases() internal pure override returns (ReserveTestCase[] memory) {
    ReserveTestCase[] memory cases = new ReserveTestCase[](3);
    cases[0] = ReserveTestCase({
      collateralHub: PAXOS_HUB,
      collateralUnderlying: PT_USDG_24SEP2026_UNDERLYING,
      collateralPriceFeed: PT_USDG_24SEP2026_PRICE_FEED,
      borrowHub: AaveV4EthereumHubs.CORE_HUB,
      borrowUnderlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      supplyAmount: 500_000 * 1e6,
      borrowAmount: 460_000 * 1e6,
      borrowAmountOverCF: 475_000 * 1e6,
      unhealthyCollateralPrice: int256(0.93e8),
      partialLiquidationDebtAmount: 200_000 * 1e6,
      healthyLiquidationDebtAmount: 10_000 * 1e6,
      borrowLiquiditySeed: 0,
      borrowSupportsPermit: true
    });
    cases[1] = ReserveTestCase({
      collateralHub: PAXOS_HUB,
      collateralUnderlying: PT_USDG_24SEP2026_UNDERLYING,
      collateralPriceFeed: PT_USDG_24SEP2026_PRICE_FEED,
      borrowHub: PAXOS_HUB,
      borrowUnderlying: AaveV4EthereumAssets.USDC_UNDERLYING,
      supplyAmount: 500_000 * 1e6,
      borrowAmount: 460_000 * 1e6,
      borrowAmountOverCF: 475_000 * 1e6,
      unhealthyCollateralPrice: int256(0.93e8),
      partialLiquidationDebtAmount: 200_000 * 1e6,
      healthyLiquidationDebtAmount: 10_000 * 1e6,
      borrowLiquiditySeed: 1_000_000 * 1e6,
      borrowSupportsPermit: true
    });
    cases[2] = ReserveTestCase({
      collateralHub: PAXOS_HUB,
      collateralUnderlying: PT_USDG_24SEP2026_UNDERLYING,
      collateralPriceFeed: PT_USDG_24SEP2026_PRICE_FEED,
      borrowHub: PAXOS_HUB,
      borrowUnderlying: AaveV4EthereumAssets.USDT_UNDERLYING,
      supplyAmount: 500_000 * 1e6,
      borrowAmount: 460_000 * 1e6,
      borrowAmountOverCF: 475_000 * 1e6,
      unhealthyCollateralPrice: int256(0.93e8),
      partialLiquidationDebtAmount: 200_000 * 1e6,
      healthyLiquidationDebtAmount: 10_000 * 1e6,
      borrowLiquiditySeed: 1_000_000 * 1e6,
      // USDT has no EIP-2612 permit, so the SignatureGateway flow skips it.
      borrowSupportsPermit: false
    });
    return cases;
  }

  function _tokenizationTestCases() internal pure override returns (TokenizationTestCase[] memory) {
    TokenizationTestCase[] memory cases = new TokenizationTestCase[](1);
    cases[0] = TokenizationTestCase({
      hub: PAXOS_HUB,
      underlying: PT_USDG_24SEP2026_UNDERLYING,
      depositAmount: 100_000 * 1e6,
      spokeAssetIdAddCap: 1_000_000
    });
    return cases;
  }
}
