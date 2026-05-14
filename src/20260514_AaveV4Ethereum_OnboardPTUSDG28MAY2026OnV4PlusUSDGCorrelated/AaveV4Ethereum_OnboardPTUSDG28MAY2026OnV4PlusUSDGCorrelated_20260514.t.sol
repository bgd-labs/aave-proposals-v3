// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumSpokePriceFeeds, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';
import {IAaveOracle, IAccessManagerEnumerable, IHub, ISpoke, ITokenizationSpoke} from 'aave-address-book/AaveV4.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated_20260514} from './AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated_20260514.sol';
import {ProtocolV4TestBase} from './dependencies/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated_20260514
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260514_AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated/AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated_20260514.t.sol -vv
 */
contract AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated_20260514_Test is
  ProtocolV4TestBase
{
  using SafeERC20 for IERC20;

  AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated_20260514 internal proposal;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  IHub internal constant PLUS_HUB = AaveV4EthereumHubs.PLUS_HUB;
  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;

  ISpoke internal constant USDG_CORRELATED_SPOKE =
    ISpoke(0x956d8e0A89cfa3744428C4641b5a53B56167a7f9);

  address internal constant PT_USDG_28MAY2026_UNDERLYING =
    0x9db38D74a0D29380899aD354121DfB521aDb0548;
  address internal constant PT_USDG_28MAY2026_PRICE_FEED =
    0x90498d4334259FA769830ccA9114D8bcF3745F6c;

  uint256 internal constant PT_USDG_28MAY2026_ADD_CAP_PLUS = 1_000_000;
  uint256 internal constant USDG_DRAW_CAP_CORE = 900_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25094500);
    proposal = new AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated_20260514();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    ISpoke[] memory spokes = new ISpoke[](1);
    spokes[0] = USDG_CORRELATED_SPOKE;

    address[] memory tokenizationSpokes = new address[](0);

    defaultTest({
      reportName: 'AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4PlusUSDGCorrelated_20260514',
      spokes: spokes,
      tokenizationSpokes: tokenizationSpokes,
      payload: address(proposal)
    });
  }

  function test_spokeConfiguratorRoleGrantedAndRenounced() public {
    address executor = address(GovV3Helpers.getPayloadsController(block.chainid));
    (bool before, ) = ACCESS_MANAGER.hasRole(Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE, executor);
    assertFalse(before, 'Executor should not have SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE before');

    GovV3Helpers.executePayload(vm, address(proposal));

    (bool afterRole, ) = ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      executor
    );
    assertFalse(
      afterRole,
      'Executor should not retain SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE after execution'
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

  function test_assetListingOnPlusHub() public {
    vm.expectRevert();
    PLUS_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 assetId = PLUS_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);
    IHub.AssetConfig memory cfg = PLUS_HUB.getAssetConfig(assetId);
    assertEq(cfg.feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE));
    assertEq(cfg.liquidityFee, 0);
    assertEq(cfg.irStrategy, 0x31280650661b8443723fa9739b3A164E3696af48);
    assertEq(cfg.reinvestmentController, address(0));
  }

  function test_tokenizationSpokeDeployedAndRegistered() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 assetId = PLUS_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);
    uint256 spokeCount = PLUS_HUB.getSpokeCount(assetId);

    bool foundCorrelated;
    address tokenizationSpoke;
    for (uint256 i; i < spokeCount; ++i) {
      address spoke = PLUS_HUB.getSpokeAddress(assetId, i);
      if (spoke == address(USDG_CORRELATED_SPOKE)) {
        foundCorrelated = true;
      } else {
        tokenizationSpoke = spoke;
      }
    }
    assertTrue(foundCorrelated, 'USDG Correlated spoke not registered on PLUS_HUB');
    assertTrue(tokenizationSpoke != address(0), 'TokenizationSpoke not registered on PLUS_HUB');

    assertEq(ITokenizationSpoke(tokenizationSpoke).hub(), address(PLUS_HUB));
    assertEq(ITokenizationSpoke(tokenizationSpoke).asset(), PT_USDG_28MAY2026_UNDERLYING);
    assertEq(
      keccak256(bytes(ITokenizationSpoke(tokenizationSpoke).name())),
      keccak256(bytes('Wrapped Aave Plus PT_USDG_28MAY2026'))
    );
    assertEq(
      keccak256(bytes(ITokenizationSpoke(tokenizationSpoke).symbol())),
      keccak256(bytes('waPlusPT_USDG_28MAY2026'))
    );
  }

  function test_spokeRegistrationsAndCaps() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 plusAssetId = PLUS_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);
    IHub.SpokeConfig memory plusCfg = PLUS_HUB.getSpokeConfig(
      plusAssetId,
      address(USDG_CORRELATED_SPOKE)
    );
    assertEq(plusCfg.addCap, uint40(PT_USDG_28MAY2026_ADD_CAP_PLUS));
    assertEq(plusCfg.drawCap, 0);
    assertEq(plusCfg.riskPremiumThreshold, 0);
    assertTrue(plusCfg.active);
    assertFalse(plusCfg.halted);

    uint256 coreAssetId = CORE_HUB.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    IHub.SpokeConfig memory coreCfg = CORE_HUB.getSpokeConfig(
      coreAssetId,
      address(USDG_CORRELATED_SPOKE)
    );
    assertEq(coreCfg.addCap, 0);
    assertEq(coreCfg.drawCap, uint40(USDG_DRAW_CAP_CORE));
    assertEq(coreCfg.riskPremiumThreshold, 0);
    assertTrue(coreCfg.active);
    assertFalse(coreCfg.halted);
  }

  function test_reserveListings() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 plusAssetId = PLUS_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);
    uint256 ptReserveId = USDG_CORRELATED_SPOKE.getReserveId(address(PLUS_HUB), plusAssetId);
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

    uint256 coreAssetId = CORE_HUB.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    uint256 usdgReserveId = USDG_CORRELATED_SPOKE.getReserveId(address(CORE_HUB), coreAssetId);
    ISpoke.ReserveConfig memory usdgCfg = USDG_CORRELATED_SPOKE.getReserveConfig(usdgReserveId);
    assertEq(usdgCfg.collateralRisk, 0);
    assertFalse(usdgCfg.paused);
    assertFalse(usdgCfg.frozen);
    assertTrue(usdgCfg.borrowable);
    assertFalse(usdgCfg.receiveSharesEnabled);
    assertEq(
      IAaveOracle(USDG_CORRELATED_SPOKE.ORACLE()).getReserveSource(usdgReserveId),
      AaveV4EthereumSpokePriceFeeds.MAIN_USDG_PRICE_FEED
    );
  }

  function test_liquidationConfig() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    ISpoke.LiquidationConfig memory liq = USDG_CORRELATED_SPOKE.getLiquidationConfig();
    assertEq(uint256(liq.targetHealthFactor), 1.0277e18);
    assertEq(uint256(liq.healthFactorForMaxBonus), 0.99e18);
    assertEq(uint256(liq.liquidationBonusFactor), 100_00);
  }

  function test_positionManagersActiveOnSpoke() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    assertTrue(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER)
      )
    );
    assertTrue(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER)
      )
    );
    assertTrue(
      USDG_CORRELATED_SPOKE.isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER)
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

  function test_borrow_overCF_reverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('user');
    uint256 supplyAmount = 500_000 * 1e6;
    uint256 borrowAmount = 500_000 * 1e6;

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

  function _reserveIds() internal view returns (uint256 ptReserveId, uint256 usdgReserveId) {
    uint256 plusAssetId = PLUS_HUB.getAssetId(PT_USDG_28MAY2026_UNDERLYING);
    uint256 coreAssetId = CORE_HUB.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    ptReserveId = USDG_CORRELATED_SPOKE.getReserveId(address(PLUS_HUB), plusAssetId);
    usdgReserveId = USDG_CORRELATED_SPOKE.getReserveId(address(CORE_HUB), coreAssetId);
  }
}
