// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumSpokes, AaveV4EthereumSpokePriceFeeds, AaveV4EthereumPositionManagers, AaveV4EthereumGetters} from 'aave-address-book/AaveV4Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IAaveOracle, IAccessManagerEnumerable, IHub, ISpoke, ITokenizationSpoke} from 'aave-address-book/AaveV4.sol';
import {IAccessManager} from 'aave-v4/dependencies/openzeppelin/IAccessManager.sol';
import {IAccessManaged} from 'aave-v4/dependencies/openzeppelin/IAccessManaged.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {Types} from 'aave-helpers/src/dependencies/v4/Types.sol';
import {ERC1967Utils} from 'aave-v4/dependencies/openzeppelin/ERC1967Utils.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514} from './AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514.sol';
import {ProtocolV4TestBase} from 'aave-helpers/src/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260514_AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated/AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514.t.sol -vv
 */
contract AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514_Test is
  ProtocolV4TestBase
{
  using SafeERC20 for IERC20;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;

  ISpoke internal constant USDG_CORRELATED_SPOKE =
    ISpoke(0x956d8e0A89cfa3744428C4641b5a53B56167a7f9);

  address internal constant PT_USDG_28MAY2026_UNDERLYING =
    0x9db38D74a0D29380899aD354121DfB521aDb0548;
  address internal constant PT_USDG_28MAY2026_PRICE_FEED =
    0x90498d4334259FA769830ccA9114D8bcF3745F6c;

  address internal constant CORE_HUB_IR_STRATEGY = 0xAD88791B0F81D1FA242f637eB05bee0cbc53fe2f;

  uint256 internal constant PT_USDG_28MAY2026_SUPPLY_CAP = 2_000_000;
  uint256 internal constant USDG_BORROW_CAP = 1_000_000;

  AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25094500);
    proposal = new AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514();
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
      reportName: 'AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514',
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

  function test_targetFunctionRolesSetOnNewSpoke() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address spoke = address(USDG_CORRELATED_SPOKE);
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.addDynamicReserveConfig.selector),
      Roles.SPOKE_CONFIGURATOR_ROLE
    );
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.addReserve.selector),
      Roles.SPOKE_CONFIGURATOR_ROLE
    );
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.updateDynamicReserveConfig.selector),
      Roles.SPOKE_CONFIGURATOR_ROLE
    );
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.updateLiquidationConfig.selector),
      Roles.SPOKE_CONFIGURATOR_ROLE
    );
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.updatePositionManager.selector),
      Roles.SPOKE_CONFIGURATOR_ROLE
    );
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.updateReserveConfig.selector),
      Roles.SPOKE_CONFIGURATOR_ROLE
    );
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.updateReservePriceSource.selector),
      Roles.SPOKE_CONFIGURATOR_ROLE
    );
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.updateUserDynamicConfig.selector),
      Roles.SPOKE_USER_POSITION_UPDATER_ROLE
    );
    assertEq(
      ACCESS_MANAGER.getTargetFunctionRole(spoke, ISpoke.updateUserRiskPremium.selector),
      Roles.SPOKE_USER_POSITION_UPDATER_ROLE
    );
  }

  function test_assetListingOnCoreHub() public {
    vm.expectRevert();
    CORE_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 assetId = CORE_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);
    IHub.AssetConfig memory cfg = CORE_HUB.getAssetConfig(assetId);
    assertEq(cfg.feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE));
    assertEq(cfg.liquidityFee, 0);
    assertEq(cfg.irStrategy, CORE_HUB_IR_STRATEGY);
    assertEq(cfg.reinvestmentController, address(0));
  }

  function test_spokeDeployment_codeExists() public view {
    assertGt(address(USDG_CORRELATED_SPOKE).code.length, 0);
  }

  function test_spokeDeployment_authority() public view {
    assertEq(IAccessManaged(address(USDG_CORRELATED_SPOKE)).authority(), address(ACCESS_MANAGER));
  }

  function test_spokeDeployment_oracleWired() public view {
    address oracle = USDG_CORRELATED_SPOKE.ORACLE();
    assertGt(oracle.code.length, 0, 'oracle has no code');
    assertEq(IAaveOracle(oracle).spoke(), address(USDG_CORRELATED_SPOKE));
    assertEq(uint256(IAaveOracle(oracle).decimals()), 8);
  }

  function test_spokeDeployment_maxUserReservesLimit() public view {
    assertEq(uint256(USDG_CORRELATED_SPOKE.MAX_USER_RESERVES_LIMIT()), type(uint16).max);
  }

  function test_spokeDeployment_proxyAdminOwnedByExecutor() public view {
    address proxyAdmin = address(
      uint160(uint256(vm.load(address(USDG_CORRELATED_SPOKE), ERC1967Utils.ADMIN_SLOT)))
    );
    assertGt(proxyAdmin.code.length, 0, 'proxy admin not deployed');

    (bool ok, bytes memory data) = proxyAdmin.staticcall(abi.encodeWithSignature('owner()'));
    assertTrue(ok, 'proxy admin owner() reverted');
    assertEq(abi.decode(data, (address)), GovernanceV3Ethereum.EXECUTOR_LVL_1);
  }

  function test_spokeDeployment_noReservesBeforePayload() public view {
    assertEq(USDG_CORRELATED_SPOKE.getReserveCount(), 0);
  }

  function test_spokeDeployment_reservesAfterPayload() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(USDG_CORRELATED_SPOKE.getReserveCount(), 2);
  }

  function test_priceFeed_withinExpectedBounds() public view {
    (bool ok, bytes memory data) = PT_USDG_28MAY2026_PRICE_FEED.staticcall(
      abi.encodeWithSignature('latestAnswer()')
    );
    assertTrue(ok, 'price feed latestAnswer() reverted');
    int256 price = abi.decode(data, (int256));

    assertGt(price, int256(0.95e8), 'PT-USDG price below expected lower bound');
    assertLe(price, int256(1e8), 'PT-USDG price above par');
  }

  function test_coreHubIRStrategyMatchesExistingAsset() public view {
    address existingIrStrategy = CORE_HUB
      .getAssetConfig(CORE_HUB.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING))
      .irStrategy;
    assertEq(
      CORE_HUB_IR_STRATEGY,
      existingIrStrategy,
      'Hardcoded CORE_HUB IR strategy drifted from the live USDG asset config'
    );
  }

  function test_tokenizationSpokeDeployedAndRegistered() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address tokenizationSpoke = _findNewTokenizationSpoke();
    assertTrue(tokenizationSpoke != address(0), 'TokenizationSpoke not registered on CORE_HUB');

    address proxyAdmin = address(
      uint160(uint256(vm.load(tokenizationSpoke, ERC1967Utils.ADMIN_SLOT)))
    );
    (, bytes memory data) = proxyAdmin.staticcall(abi.encodeWithSignature('owner()'));
    assertEq(
      abi.decode(data, (address)),
      address(GovV3Helpers.getPayloadsController(block.chainid)),
      'TokenizationSpoke ProxyAdmin owner should be the PayloadsController'
    );

    assertEq(ITokenizationSpoke(tokenizationSpoke).hub(), address(CORE_HUB));
    assertEq(ITokenizationSpoke(tokenizationSpoke).asset(), PT_USDG_28MAY2026_UNDERLYING);
    assertEq(
      keccak256(bytes(ITokenizationSpoke(tokenizationSpoke).name())),
      keccak256(bytes(proposal.TOKENIZATION_SPOKE_NAME()))
    );
    assertEq(
      keccak256(bytes(ITokenizationSpoke(tokenizationSpoke).symbol())),
      keccak256(bytes(proposal.TOKENIZATION_SPOKE_SYMBOL()))
    );
  }

  function test_spokeRegistrationsAndCaps() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    (uint256 ptAssetId, uint256 usdgAssetId) = _assetIds();
    IHub.SpokeConfig memory ptCfg = CORE_HUB.getSpokeConfig(
      ptAssetId,
      address(USDG_CORRELATED_SPOKE)
    );
    assertEq(ptCfg.addCap, uint40(PT_USDG_28MAY2026_SUPPLY_CAP));
    assertEq(ptCfg.drawCap, 0);
    assertEq(ptCfg.riskPremiumThreshold, 0);
    assertTrue(ptCfg.active);
    assertFalse(ptCfg.halted);

    IHub.SpokeConfig memory usdgCfg = CORE_HUB.getSpokeConfig(
      usdgAssetId,
      address(USDG_CORRELATED_SPOKE)
    );
    assertEq(usdgCfg.addCap, 0);
    assertEq(usdgCfg.drawCap, uint40(USDG_BORROW_CAP));
    assertEq(usdgCfg.riskPremiumThreshold, 0);
    assertTrue(usdgCfg.active);
    assertFalse(usdgCfg.halted);
  }

  function test_reserveListings() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    (uint256 ptReserveId, uint256 usdgReserveId) = _reserveIds();
    ISpoke.ReserveConfig memory ptCfg = USDG_CORRELATED_SPOKE.getReserveConfig(ptReserveId);
    assertEq(ptCfg.collateralRisk, 0);
    assertFalse(ptCfg.paused);
    assertFalse(ptCfg.frozen);
    assertFalse(ptCfg.borrowable);
    assertTrue(ptCfg.receiveSharesEnabled);
    assertEq(
      IAaveOracle(USDG_CORRELATED_SPOKE.ORACLE()).getReserveSource(ptReserveId),
      PT_USDG_28MAY2026_PRICE_FEED
    );
    ISpoke.DynamicReserveConfig memory ptDyn = USDG_CORRELATED_SPOKE.getDynamicReserveConfig(
      ptReserveId,
      0
    );
    assertEq(ptDyn.collateralFactor, 95_00);
    assertEq(ptDyn.maxLiquidationBonus, 102_00);
    assertEq(ptDyn.liquidationFee, 10_00);

    ISpoke.ReserveConfig memory usdgCfg = USDG_CORRELATED_SPOKE.getReserveConfig(usdgReserveId);
    assertEq(usdgCfg.collateralRisk, 0);
    assertFalse(usdgCfg.paused);
    assertFalse(usdgCfg.frozen);
    assertTrue(usdgCfg.borrowable);
    assertFalse(usdgCfg.receiveSharesEnabled);
    assertEq(
      IAaveOracle(USDG_CORRELATED_SPOKE.ORACLE()).getReserveSource(usdgReserveId),
      AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDG_PRICE_FEED
    );
  }

  function test_liquidationConfig() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    ISpoke.LiquidationConfig memory liq = USDG_CORRELATED_SPOKE.getLiquidationConfig();
    assertEq(uint256(liq.targetHealthFactor), 1.02e18);
    assertEq(uint256(liq.healthFactorForMaxBonus), 0.99e18);
    assertEq(uint256(liq.liquidationBonusFactor), 100_00);
  }

  function test_positionManagersActiveOnSpoke() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    assertTrue(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER)
      ),
      'GIVER_POSITION_MANAGER inactive'
    );
    assertTrue(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER)
      ),
      'TAKER_POSITION_MANAGER inactive'
    );
    assertTrue(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER)
      ),
      'CONFIG_POSITION_MANAGER inactive'
    );
    assertTrue(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY)
      ),
      'SIGNATURE_GATEWAY inactive'
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

  function test_supplyAndBorrow_closeToMaxCF() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('user');
    uint256 supplyAmount = 500_000 * 1e6;
    uint256 borrowAmount = 460_000 * 1e6;

    (uint256 ptReserveId, uint256 usdgReserveId) = _reserveIds();

    deal2(PT_USDG_28MAY2026_UNDERLYING, user, supplyAmount);

    vm.startPrank(user);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(address(USDG_CORRELATED_SPOKE), supplyAmount);
    USDG_CORRELATED_SPOKE.supply(ptReserveId, supplyAmount, user);
    USDG_CORRELATED_SPOKE.setUsingAsCollateral(ptReserveId, true, user);

    USDG_CORRELATED_SPOKE.borrow(usdgReserveId, borrowAmount, user);
    vm.stopPrank();

    assertEq(IERC20(AaveV4EthereumAssets.USDG_UNDERLYING).balanceOf(user), borrowAmount);

    ISpoke.UserAccountData memory acct = USDG_CORRELATED_SPOKE.getUserAccountData(user);
    assertGt(acct.healthFactor, 1e18);
    assertEq(acct.borrowCount, 1);
    assertEq(acct.activeCollateralCount, 1);
  }

  function test_liquidation_partial() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('user');
    address liquidator = makeAddr('liquidator');
    uint256 supplyAmount = 500_000 * 1e6;
    uint256 borrowAmount = 460_000 * 1e6;

    (uint256 ptReserveId, uint256 usdgReserveId) = _reserveIds();

    deal2(PT_USDG_28MAY2026_UNDERLYING, user, supplyAmount);
    vm.startPrank(user);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(address(USDG_CORRELATED_SPOKE), supplyAmount);
    USDG_CORRELATED_SPOKE.supply(ptReserveId, supplyAmount, user);
    USDG_CORRELATED_SPOKE.setUsingAsCollateral(ptReserveId, true, user);
    USDG_CORRELATED_SPOKE.borrow(usdgReserveId, borrowAmount, user);
    vm.stopPrank();

    vm.mockCall(
      PT_USDG_28MAY2026_PRICE_FEED,
      abi.encodeWithSignature('latestAnswer()'),
      abi.encode(int256(0.93e8))
    );

    ISpoke.UserAccountData memory preLiq = USDG_CORRELATED_SPOKE.getUserAccountData(user);
    assertLt(preLiq.healthFactor, 1e18, 'expected unhealthy position after price drop');

    uint256 debtToCover = 200_000 * 1e6;
    deal2(AaveV4EthereumAssets.USDG_UNDERLYING, liquidator, debtToCover);
    uint256 liquidatorPtBefore = IERC20(PT_USDG_28MAY2026_UNDERLYING).balanceOf(liquidator);

    vm.startPrank(liquidator);
    IERC20(AaveV4EthereumAssets.USDG_UNDERLYING).forceApprove(
      address(USDG_CORRELATED_SPOKE),
      debtToCover
    );
    USDG_CORRELATED_SPOKE.liquidationCall(ptReserveId, usdgReserveId, user, debtToCover, false);
    vm.stopPrank();

    vm.clearMockedCalls();

    uint256 liquidatorPtAfter = IERC20(PT_USDG_28MAY2026_UNDERLYING).balanceOf(liquidator);
    assertGt(liquidatorPtAfter, liquidatorPtBefore, 'liquidator did not receive collateral');

    ISpoke.UserAccountData memory postLiq = USDG_CORRELATED_SPOKE.getUserAccountData(user);
    assertGt(postLiq.healthFactor, preLiq.healthFactor, 'HF should improve post-liquidation');
    assertLt(postLiq.totalDebtValueRay, preLiq.totalDebtValueRay, 'debt should decrease');
  }

  function test_liquidation_revertsIfHealthy() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('user');
    address liquidator = makeAddr('liquidator');
    uint256 supplyAmount = 500_000 * 1e6;
    uint256 borrowAmount = 460_000 * 1e6;

    (uint256 ptReserveId, uint256 usdgReserveId) = _reserveIds();

    deal2(PT_USDG_28MAY2026_UNDERLYING, user, supplyAmount);
    vm.startPrank(user);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(address(USDG_CORRELATED_SPOKE), supplyAmount);
    USDG_CORRELATED_SPOKE.supply(ptReserveId, supplyAmount, user);
    USDG_CORRELATED_SPOKE.setUsingAsCollateral(ptReserveId, true, user);
    USDG_CORRELATED_SPOKE.borrow(usdgReserveId, borrowAmount, user);
    vm.stopPrank();

    uint256 debtToCover = 10_000 * 1e6;
    deal2(AaveV4EthereumAssets.USDG_UNDERLYING, liquidator, debtToCover);

    vm.startPrank(liquidator);
    IERC20(AaveV4EthereumAssets.USDG_UNDERLYING).forceApprove(
      address(USDG_CORRELATED_SPOKE),
      debtToCover
    );
    vm.expectRevert(ISpoke.HealthFactorNotBelowThreshold.selector);
    USDG_CORRELATED_SPOKE.liquidationCall(ptReserveId, usdgReserveId, user, debtToCover, false);
    vm.stopPrank();
  }

  function test_e2eNewSpokeStandalone() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    e2eTestSpoke(USDG_CORRELATED_SPOKE);
  }

  function test_spokeConfigurator_canCallGatedSelectors() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address spoke = address(USDG_CORRELATED_SPOKE);
    address holder = address(AaveV4Ethereum.SPOKE_CONFIGURATOR);

    bytes4[7] memory gated = [
      ISpoke.addDynamicReserveConfig.selector,
      ISpoke.addReserve.selector,
      ISpoke.updateDynamicReserveConfig.selector,
      ISpoke.updateLiquidationConfig.selector,
      ISpoke.updatePositionManager.selector,
      ISpoke.updateReserveConfig.selector,
      ISpoke.updateReservePriceSource.selector
    ];

    for (uint256 i; i < gated.length; ++i) {
      (bool allowed, uint32 delay) = ACCESS_MANAGER.canCall(holder, spoke, gated[i]);
      assertTrue(allowed, 'SpokeConfigurator should be allowed to call selector');
      assertEq(delay, 0, 'No execution delay expected');
    }
  }

  function test_tokenizationSpoke_depositRevertsWhileAddCapZero() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address tokenizationSpoke = _findNewTokenizationSpoke();
    require(tokenizationSpoke != address(0), 'tokenization spoke missing');

    address user = makeAddr('tokenizationUser');
    uint256 depositAmount = 100_000 * 1e6;
    deal2(PT_USDG_28MAY2026_UNDERLYING, user, depositAmount);

    vm.startPrank(user);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(tokenizationSpoke, depositAmount);
    vm.expectRevert(abi.encodeWithSignature('AddCapExceeded(uint256)', 0));
    ITokenizationSpoke(tokenizationSpoke).deposit(depositAmount, user);
    vm.stopPrank();
  }

  function test_tokenizationSpoke_depositAndRedeem() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address tokenizationSpoke = _findNewTokenizationSpoke();
    require(tokenizationSpoke != address(0), 'tokenization spoke missing');

    (uint256 ptAssetId, ) = _assetIds();
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    AaveV4Ethereum.HUB_CONFIGURATOR.updateSpokeAddCap(
      address(CORE_HUB),
      ptAssetId,
      tokenizationSpoke,
      1_000_000
    );

    address user = makeAddr('tokenizationUser');
    uint256 depositAmount = 100_000 * 1e6;
    deal2(PT_USDG_28MAY2026_UNDERLYING, user, depositAmount);

    vm.startPrank(user);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(tokenizationSpoke, depositAmount);
    uint256 shares = ITokenizationSpoke(tokenizationSpoke).deposit(depositAmount, user);
    vm.stopPrank();

    assertGt(shares, 0, 'no shares minted');
    assertEq(IERC20(tokenizationSpoke).balanceOf(user), shares);
    assertEq(ITokenizationSpoke(tokenizationSpoke).totalAssets(), depositAmount);
    assertEq(IERC20(PT_USDG_28MAY2026_UNDERLYING).balanceOf(user), 0);

    uint256 redeemTarget = shares / 2;
    vm.prank(user);
    uint256 redeemedAssets = ITokenizationSpoke(tokenizationSpoke).redeem(redeemTarget, user, user);

    assertGt(redeemedAssets, 0, 'no assets redeemed');
    assertEq(IERC20(tokenizationSpoke).balanceOf(user), shares - redeemTarget);
    assertEq(IERC20(PT_USDG_28MAY2026_UNDERLYING).balanceOf(user), redeemedAssets);
  }

  function test_e2eAllPositionManagersForNewSpoke() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _registerSpokeOnPositionManagers();
    e2eTestPositionManagers(USDG_CORRELATED_SPOKE);
  }

  function test_takerPositionManager_borrowOnBehalfOf() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _registerSpokeOnPositionManagers();

    (uint256 ptReserveId, uint256 usdgReserveId) = _reserveIds();
    address owner = makeAddr('takerOwner');
    address taker = makeAddr('takerDelegatee');
    uint256 supplyAmount = 100_000 * 1e6;
    uint256 borrowAmount = 50_000 * 1e6;

    deal2(PT_USDG_28MAY2026_UNDERLYING, owner, supplyAmount);
    vm.startPrank(owner);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(address(USDG_CORRELATED_SPOKE), supplyAmount);
    USDG_CORRELATED_SPOKE.supply(ptReserveId, supplyAmount, owner);
    USDG_CORRELATED_SPOKE.setUsingAsCollateral(ptReserveId, true, owner);
    USDG_CORRELATED_SPOKE.setUserPositionManager(
      address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER),
      true
    );
    AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER.approveBorrow({
      spoke: address(USDG_CORRELATED_SPOKE),
      reserveId: usdgReserveId,
      spender: taker,
      amount: borrowAmount
    });
    vm.stopPrank();

    vm.prank(taker);
    AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER.borrowOnBehalfOf({
      spoke: address(USDG_CORRELATED_SPOKE),
      reserveId: usdgReserveId,
      amount: borrowAmount,
      onBehalfOf: owner
    });

    assertEq(IERC20(AaveV4EthereumAssets.USDG_UNDERLYING).balanceOf(taker), borrowAmount);
    assertApproxEqAbs(
      USDG_CORRELATED_SPOKE.getUserTotalDebt(usdgReserveId, owner),
      borrowAmount,
      2
    );
  }

  function test_configPositionManager_setUsingAsCollateralOnBehalfOf() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _registerSpokeOnPositionManagers();

    (uint256 ptReserveId, ) = _reserveIds();
    address owner = makeAddr('configOwner');
    address delegatee = makeAddr('configDelegatee');
    uint256 supplyAmount = 100_000 * 1e6;

    deal2(PT_USDG_28MAY2026_UNDERLYING, owner, supplyAmount);
    vm.startPrank(owner);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(address(USDG_CORRELATED_SPOKE), supplyAmount);
    USDG_CORRELATED_SPOKE.supply(ptReserveId, supplyAmount, owner);
    USDG_CORRELATED_SPOKE.setUserPositionManager(
      address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER),
      true
    );
    AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER.setGlobalPermission({
      spoke: address(USDG_CORRELATED_SPOKE),
      delegatee: delegatee,
      status: true
    });
    vm.stopPrank();

    (bool enabledBefore, ) = USDG_CORRELATED_SPOKE.getUserReserveStatus(ptReserveId, owner);
    assertFalse(enabledBefore, 'collateral should start disabled');

    vm.prank(delegatee);
    AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER.setUsingAsCollateralOnBehalfOf({
      spoke: address(USDG_CORRELATED_SPOKE),
      reserveId: ptReserveId,
      usingAsCollateral: true,
      onBehalfOf: owner
    });

    (bool enabledAfter, ) = USDG_CORRELATED_SPOKE.getUserReserveStatus(ptReserveId, owner);
    assertTrue(enabledAfter, 'delegatee should have enabled collateral');
  }

  function test_signatureGateway_supplyOnBehalfOfNewSpoke() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _registerSpokeOnPositionManagers();

    Types.ReserveInfo[] memory reserves = _getReserveInfo(USDG_CORRELATED_SPOKE);
    Types.ReserveInfo memory ptInfo;
    Types.ReserveInfo memory usdgInfo;
    for (uint256 i; i < reserves.length; ++i) {
      if (reserves[i].underlying == PT_USDG_28MAY2026_UNDERLYING) ptInfo = reserves[i];
      else if (reserves[i].underlying == AaveV4EthereumAssets.USDG_UNDERLYING)
        usdgInfo = reserves[i];
    }

    _testSignatureGateway({
      gateway: AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY,
      spoke: USDG_CORRELATED_SPOKE,
      reserveInfo: ptInfo,
      collateralInfo: ptInfo
    });
  }

  function test_giverPositionManager_supplyOnBehalfOf() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _registerSpokeOnPositionManagers();

    address owner = makeAddr('giverOwner');
    address supplier = makeAddr('giverSupplier');
    uint256 supplyAmount = 100_000 * 1e6;

    (uint256 ptReserveId, ) = _reserveIds();

    vm.prank(owner);
    USDG_CORRELATED_SPOKE.setUserPositionManager(
      address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      true
    );

    deal2(PT_USDG_28MAY2026_UNDERLYING, supplier, supplyAmount);

    vm.startPrank(supplier);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(
      address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      supplyAmount
    );
    AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER.supplyOnBehalfOf({
      spoke: address(USDG_CORRELATED_SPOKE),
      reserveId: ptReserveId,
      amount: supplyAmount,
      onBehalfOf: owner
    });
    vm.stopPrank();

    assertEq(USDG_CORRELATED_SPOKE.getUserSuppliedAssets(ptReserveId, owner), supplyAmount);
    assertEq(IERC20(PT_USDG_28MAY2026_UNDERLYING).balanceOf(supplier), 0);
  }

  function test_borrow_overCF_reverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('user');
    uint256 supplyAmount = 500_000 * 1e6;
    // Supply value ≈ 500_000 * $0.998 ≈ $499,065; max borrow @ 95% CF ≈ $474,112.
    // 475_000 USDG is just over that, so borrow must revert.
    uint256 borrowAmount = 475_000 * 1e6;

    (uint256 ptReserveId, uint256 usdgReserveId) = _reserveIds();

    deal2(PT_USDG_28MAY2026_UNDERLYING, user, supplyAmount);

    vm.startPrank(user);
    IERC20(PT_USDG_28MAY2026_UNDERLYING).forceApprove(address(USDG_CORRELATED_SPOKE), supplyAmount);
    USDG_CORRELATED_SPOKE.supply(ptReserveId, supplyAmount, user);
    USDG_CORRELATED_SPOKE.setUsingAsCollateral(ptReserveId, true, user);

    vm.expectRevert(ISpoke.HealthFactorBelowThreshold.selector);
    USDG_CORRELATED_SPOKE.borrow(usdgReserveId, borrowAmount, user);
    vm.stopPrank();
  }

  /// @dev Simulates the post-AIP SC-owned step: registerSpoke on each PM is `onlyOwner`,
  /// owner is SECURITY_COUNCIL. The AIP can't reach this from the governance executor.
  function _registerSpokeOnPositionManagers() internal {
    address sc = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
    address[4] memory pms = [
      address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER),
      address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER),
      address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY)
    ];
    vm.startPrank(sc);
    for (uint256 i; i < pms.length; ++i) {
      (bool ok, ) = pms[i].call(
        abi.encodeWithSignature('registerSpoke(address,bool)', address(USDG_CORRELATED_SPOKE), true)
      );
      assertTrue(ok, 'registerSpoke failed');
    }
    vm.stopPrank();
  }

  /// @dev The on-chain HubEngine library embeds a possibly older TokenizationSpokeInstance
  /// creation code than our local copy, so CREATE2 prediction via TokenizationSpokeDeployer
  /// is unreliable. Snapshot, run the payload, read the new spoke off the hub, revert.
  function _discoverTokenizationSpoke() internal returns (address tokenizationSpoke) {
    uint256 snap = vm.snapshotState();
    GovV3Helpers.executePayload(vm, address(proposal));
    tokenizationSpoke = _findNewTokenizationSpoke();
    vm.revertToState(snap);
  }

  function _findNewTokenizationSpoke() internal view returns (address) {
    (uint256 ptAssetId, ) = _assetIds();
    uint256 spokeCount = CORE_HUB.getSpokeCount(ptAssetId);
    address treasurySpoke = address(AaveV4Ethereum.TREASURY_SPOKE);
    for (uint256 i; i < spokeCount; ++i) {
      address spoke = CORE_HUB.getSpokeAddress(ptAssetId, i);
      if (spoke == address(USDG_CORRELATED_SPOKE) || spoke == treasurySpoke) continue;
      return spoke;
    }
    return address(0);
  }

  function _assetIds() internal view returns (uint256 ptAssetId, uint256 usdgAssetId) {
    ptAssetId = CORE_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);
    usdgAssetId = CORE_HUB.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
  }

  function _reserveIds() internal view returns (uint256 ptReserveId, uint256 usdgReserveId) {
    (uint256 ptAssetId, uint256 usdgAssetId) = _assetIds();
    ptReserveId = USDG_CORRELATED_SPOKE.getReserveId(address(CORE_HUB), ptAssetId);
    usdgReserveId = USDG_CORRELATED_SPOKE.getReserveId(address(CORE_HUB), usdgAssetId);
  }
}
