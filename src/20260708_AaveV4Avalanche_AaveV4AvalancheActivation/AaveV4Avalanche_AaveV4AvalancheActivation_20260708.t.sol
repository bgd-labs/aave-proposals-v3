// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {ISpoke, IHub} from 'aave-address-book/AaveV4.sol';
import {IAccessManagerEnumerable} from 'aave-v4/access/interfaces/IAccessManagerEnumerable.sol';
import {IAccessManaged} from 'aave-v4/dependencies/openzeppelin/IAccessManaged.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IOwnable2Step} from 'src/interfaces/IOwnable2Step.sol';
import {AaveV4Avalanche, AaveV4AvalancheHubs, AaveV4AvalancheSpokes, AaveV4AvalancheTokenizationSpokes, AaveV4AvalancheAssets, AaveV4AvalancheGetters, AaveV4AvalanchePositionManagers} from 'aave-address-book/AaveV4Avalanche.sol';
import {ProtocolV4TestBaseAvalanche} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseAvalanche.sol';
import {AaveV4Avalanche_AaveV4AvalancheActivation_20260708} from './AaveV4Avalanche_AaveV4AvalancheActivation_20260708.sol';

/**
 * @dev Test for AaveV4Avalanche_AaveV4AvalancheActivation_20260708. Runs the generic e2e/snapshot
 *      suite plus explicit assertions on the market spec (ActivateV4Avalanche.md) and access control.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260708_AaveV4Avalanche_AaveV4AvalancheActivation/AaveV4Avalanche_AaveV4AvalancheActivation_20260708.t.sol -vv
 */
contract AaveV4Avalanche_AaveV4AvalancheActivation_20260708_Test is ProtocolV4TestBaseAvalanche {
  IHub internal constant CORE_HUB = AaveV4AvalancheHubs.CORE_HUB;
  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Avalanche.ACCESS_MANAGER;

  address internal constant V4_SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant SECURITY_COUNCIL_EXECUTOR = 0xb619fA61e795D47f517702e63ce50292370561F1;
  address internal constant GOV_EXECUTOR = GovernanceV3Avalanche.EXECUTOR_LVL_1;
  bytes32 internal constant EIP1967_ADMIN_SLOT =
    0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;

  AaveV4Avalanche_AaveV4AvalancheActivation_20260708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 89744425);
    proposal = new AaveV4Avalanche_AaveV4AvalancheActivation_20260708();
  }

  modifier activated() {
    GovV3Helpers.executePayload(vm, address(proposal));
    _;
  }

  /// @dev executes the generic test suite including e2e and config snapshots
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV4Avalanche_AaveV4AvalancheActivation_20260708',
      payload: address(proposal),
      runE2E: true,
      testPositionManagers: true
    });
  }

  function test_mainSpoke() public activated {
    ISpoke spoke = AaveV4AvalancheSpokes.MAIN_SPOKE;
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(spoke);
    assertEq(total, 6, 'main reserves');
    assertEq(onHub, 6, 'main on core hub');
    assertEq(collateral, 5, 'main collateral');
    assertEq(borrowable, 6, 'main borrowable');

    // prettier-ignore
    {
      //                    asset                                   collat borrow CF    maxBonus liqFee
      _assertReserve(spoke, AaveV4AvalancheAssets.WAVAX_UNDERLYING, true,  true,  7300, 11000,   1000);
      _assertReserve(spoke, AaveV4AvalancheAssets.BTCb_UNDERLYING,  true,  true,  7500, 10722,   1000);
      _assertReserve(spoke, AaveV4AvalancheAssets.USDC_UNDERLYING,  true,  true,  7800, 10555,   1000);
      _assertReserve(spoke, AaveV4AvalancheAssets.USDt_UNDERLYING,  true,  true,  7800, 10555,   1000);
      _assertReserve(spoke, AaveV4AvalancheAssets.WETHe_UNDERLYING, true,  true,  8300, 10555,   1000);
      _assertReserve(spoke, AaveV4AvalancheAssets.EURC_UNDERLYING,  false, true,  0,    10000,   0);

      //                 asset                                   addCap     drawCap
      _assertCaps(spoke, AaveV4AvalancheAssets.WAVAX_UNDERLYING, 500_000,   50_000);
      _assertCaps(spoke, AaveV4AvalancheAssets.BTCb_UNDERLYING,  100,       10);
      _assertCaps(spoke, AaveV4AvalancheAssets.USDC_UNDERLYING,  5_000_000, 5_000_000);
      _assertCaps(spoke, AaveV4AvalancheAssets.USDt_UNDERLYING,  5_000_000, 5_000_000);
      _assertCaps(spoke, AaveV4AvalancheAssets.WETHe_UNDERLYING, 3_000,     300);
      _assertCaps(spoke, AaveV4AvalancheAssets.EURC_UNDERLYING,  500_000,   400_000);

      //                       spoke  targetHealthFactor healthFactorForMaxBonus liqBonusFactor
      _assertLiquidationConfig(spoke, 1.24e18,           0.9e18,                 9000);
    }
  }

  function test_forexSpoke() public activated {
    ISpoke spoke = AaveV4AvalancheSpokes.FOREX_SPOKE;
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(spoke);
    assertEq(total, 3, 'forex reserves');
    assertEq(onHub, 3, 'forex on core hub');
    assertEq(collateral, 3, 'forex collateral');
    assertEq(borrowable, 3, 'forex borrowable');

    // prettier-ignore
    {
      //                    asset                                  collat borrow CF    maxBonus liqFee
      _assertReserve(spoke, AaveV4AvalancheAssets.EURC_UNDERLYING, true,  true,  9000, 10200,   1000);
      _assertReserve(spoke, AaveV4AvalancheAssets.USDC_UNDERLYING, true,  true,  9000, 10200,   1000);
      _assertReserve(spoke, AaveV4AvalancheAssets.USDt_UNDERLYING, true,  true,  9000, 10200,   1000);

      //                 asset                                  addCap   drawCap
      _assertCaps(spoke, AaveV4AvalancheAssets.EURC_UNDERLYING, 300_000, 400_000);
      _assertCaps(spoke, AaveV4AvalancheAssets.USDC_UNDERLYING, 200_000, 150_000);
      _assertCaps(spoke, AaveV4AvalancheAssets.USDt_UNDERLYING, 200_000, 150_000);

      //                       spoke  targetHealthFactor healthFactorForMaxBonus liqBonusFactor
      _assertLiquidationConfig(spoke, 1.0442e18,         0.99e18,                10000);
    }
  }

  function test_avaxCorrelatedSpoke() public activated {
    ISpoke spoke = AaveV4AvalancheSpokes.AVAX_CORRELATED_SPOKE;
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(spoke);
    assertEq(total, 2, 'avaxCorrelated reserves');
    assertEq(onHub, 2, 'avaxCorrelated on core hub');
    assertEq(collateral, 1, 'avaxCorrelated collateral');
    assertEq(borrowable, 1, 'avaxCorrelated borrowable');

    // prettier-ignore
    {
      //                    asset                                   collat borrow CF    maxBonus liqFee
      _assertReserve(spoke, AaveV4AvalancheAssets.sAVAX_UNDERLYING, true,  false, 9500, 10100,   1000);
      _assertReserve(spoke, AaveV4AvalancheAssets.WAVAX_UNDERLYING, false, true,  0,    10000,   0);

      //                 asset                                   addCap   drawCap
      _assertCaps(spoke, AaveV4AvalancheAssets.sAVAX_UNDERLYING, 200_000, 0);
      _assertCaps(spoke, AaveV4AvalancheAssets.WAVAX_UNDERLYING, 0,       250_000);

      //                       spoke  targetHealthFactor healthFactorForMaxBonus liqBonusFactor
      _assertLiquidationConfig(spoke, 1.035e18,          0.99e18,                10000);
    }
  }

  function test_interestRateCurves() public activated {
    // prettier-ignore
    {
      //         asset                                   liqFee uOpt  base slope1 slope2
      _assertIrm(AaveV4AvalancheAssets.WAVAX_UNDERLYING, 2000,  6500, 100, 400,   14428);
      _assertIrm(AaveV4AvalancheAssets.BTCb_UNDERLYING,  2500,  8000, 0,   400,   8000);
      _assertIrm(AaveV4AvalancheAssets.USDC_UNDERLYING,  1000,  9000, 0,   400,   1000);
      _assertIrm(AaveV4AvalancheAssets.USDt_UNDERLYING,  1000,  9000, 0,   400,   1000);
      _assertIrm(AaveV4AvalancheAssets.WETHe_UNDERLYING, 1500,  9000, 0,   250,   800);
      _assertIrm(AaveV4AvalancheAssets.EURC_UNDERLYING,  1000,  9000, 0,   550,   5000);
    }
  }

  function test_tokenizationSpokes() public activated {
    // prettier-ignore
    {
      //                       asset                                   tokenizationSpoke                                                         addCap
      _assertTokenizationSpoke(AaveV4AvalancheAssets.WAVAX_UNDERLYING, address(AaveV4AvalancheTokenizationSpokes.CORE_WAVAX_TOKENIZATION_SPOKE), 150_000);
      _assertTokenizationSpoke(AaveV4AvalancheAssets.BTCb_UNDERLYING,  address(AaveV4AvalancheTokenizationSpokes.CORE_BTCb_TOKENIZATION_SPOKE),  20);
      _assertTokenizationSpoke(AaveV4AvalancheAssets.USDC_UNDERLYING,  address(AaveV4AvalancheTokenizationSpokes.CORE_USDC_TOKENIZATION_SPOKE),  1_500_000);
      _assertTokenizationSpoke(AaveV4AvalancheAssets.USDt_UNDERLYING,  address(AaveV4AvalancheTokenizationSpokes.CORE_USDt_TOKENIZATION_SPOKE),  1_500_000);
      _assertTokenizationSpoke(AaveV4AvalancheAssets.WETHe_UNDERLYING, address(AaveV4AvalancheTokenizationSpokes.CORE_WETHe_TOKENIZATION_SPOKE), 600);
      _assertTokenizationSpoke(AaveV4AvalancheAssets.EURC_UNDERLYING,  address(AaveV4AvalancheTokenizationSpokes.CORE_EURC_TOKENIZATION_SPOKE),  150_000);
      _assertTokenizationSpoke(AaveV4AvalancheAssets.sAVAX_UNDERLYING, address(AaveV4AvalancheTokenizationSpokes.CORE_sAVAX_TOKENIZATION_SPOKE), 0);
    }
  }

  function test_treasurySpokeListedActiveOnEveryAsset() public activated {
    IHub[] memory hubs = AaveV4AvalancheGetters.getAllHubs();
    address treasury = address(AaveV4AvalancheSpokes.TREASURY_SPOKE);
    for (uint256 h; h < hubs.length; ++h) {
      uint256 assetCount = hubs[h].getAssetCount();
      for (uint256 assetId; assetId < assetCount; ++assetId) {
        assertTrue(hubs[h].isSpokeListed(assetId, treasury), 'treasury not listed');
        IHub.SpokeConfig memory c = hubs[h].getSpokeConfig(assetId, treasury);
        assertTrue(c.active, 'treasury not active');
        assertEq(uint256(c.addCap), uint256(type(uint40).max));
        assertEq(uint256(c.drawCap), 0);
      }
    }
  }

  function test_accessManagerIsAuthorityOfCoreContracts() public activated {
    assertEq(IAccessManaged(address(CORE_HUB)).authority(), address(ACCESS_MANAGER));
    assertEq(
      IAccessManaged(address(AaveV4Avalanche.HUB_CONFIGURATOR)).authority(),
      address(ACCESS_MANAGER)
    );
    assertEq(
      IAccessManaged(address(AaveV4Avalanche.SPOKE_CONFIGURATOR)).authority(),
      address(ACCESS_MANAGER)
    );
    ISpoke[] memory spokes = AaveV4AvalancheGetters.getAllSpokes();
    for (uint256 i; i < spokes.length; ++i) {
      assertEq(spokes[i].authority(), address(ACCESS_MANAGER));
    }
  }

  function test_configuratorRoleMembership() public activated {
    _assertSoleMember(Roles.HUB_CONFIGURATOR_ROLE, address(AaveV4Avalanche.HUB_CONFIGURATOR));
    _assertSoleMember(Roles.SPOKE_CONFIGURATOR_ROLE, address(AaveV4Avalanche.SPOKE_CONFIGURATOR));
  }

  function test_configuratorDomainAdminRoles() public activated {
    _assertHasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, SECURITY_COUNCIL_EXECUTOR);
    _assertHasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, GOV_EXECUTOR);
    assertEq(ACCESS_MANAGER.getRoleMemberCount(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE), 2);

    _assertHasRole(Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE, SECURITY_COUNCIL_EXECUTOR);
    assertEq(ACCESS_MANAGER.getRoleMemberCount(Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE), 1);
  }

  function test_unusedGranularRolesHaveNoMembers() public activated {
    uint64[5] memory unused = [
      Roles.HUB_DOMAIN_ADMIN_ROLE,
      Roles.HUB_FEE_MINTER_ROLE,
      Roles.HUB_DEFICIT_ELIMINATOR_ROLE,
      Roles.SPOKE_DOMAIN_ADMIN_ROLE,
      Roles.SPOKE_USER_POSITION_UPDATER_ROLE
    ];
    for (uint256 i; i < unused.length; ++i) {
      assertEq(ACCESS_MANAGER.getRoleMemberCount(unused[i]), 0);
    }
  }

  function test_roleSelectorsWiredToTargets() public activated {
    _assertSelectorsRole(
      address(CORE_HUB),
      Roles.getHubConfiguratorRoleSelectors(),
      Roles.HUB_CONFIGURATOR_ROLE
    );
    _assertSelectorsRole(
      address(AaveV4Avalanche.HUB_CONFIGURATOR),
      Roles.getHubConfiguratorDomainAdminRoleSelectors(),
      Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE
    );
    _assertSelectorsRole(
      address(AaveV4Avalanche.SPOKE_CONFIGURATOR),
      Roles.getSpokeConfiguratorDomainAdminRoleSelectors(),
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE
    );
    bytes4[] memory spokeSelectors = Roles.getSpokeConfiguratorRoleSelectors();
    ISpoke[] memory spokes = AaveV4AvalancheGetters.getAllSpokes();
    for (uint256 i; i < spokes.length; ++i) {
      _assertSelectorsRole(address(spokes[i]), spokeSelectors, Roles.SPOKE_CONFIGURATOR_ROLE);
    }
  }

  function test_proxyAdminsOwnedBySecurityCouncil() public activated {
    assertEq(_proxyAdminOwner(address(CORE_HUB)), V4_SECURITY_COUNCIL, 'hub proxy admin');
    address[] memory spokes = AaveV4AvalancheGetters.getAllSpokesRaw();
    for (uint256 i; i < spokes.length; ++i) {
      assertEq(_proxyAdminOwner(spokes[i]), V4_SECURITY_COUNCIL, 'spoke proxy admin');
    }
  }

  function test_positionManagersAndTreasuryPendingOwnerIsSecurityCouncil() public activated {
    address[6] memory owned = [
      address(AaveV4AvalanchePositionManagers.GIVER_POSITION_MANAGER),
      address(AaveV4AvalanchePositionManagers.TAKER_POSITION_MANAGER),
      address(AaveV4AvalanchePositionManagers.CONFIG_POSITION_MANAGER),
      address(AaveV4AvalanchePositionManagers.NATIVE_TOKEN_GATEWAY),
      address(AaveV4AvalanchePositionManagers.SIGNATURE_GATEWAY),
      address(AaveV4AvalancheSpokes.TREASURY_SPOKE)
    ];
    // Ownership transfer to the security council is started but not yet accepted.
    for (uint256 i; i < owned.length; ++i) {
      assertEq(IOwnable2Step(owned[i]).pendingOwner(), V4_SECURITY_COUNCIL, 'pendingOwner');
    }
  }

  function _countReserves(
    ISpoke spoke
  ) internal view returns (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) {
    total = spoke.getReserveCount();
    for (uint256 reserveId; reserveId < total; ++reserveId) {
      ISpoke.Reserve memory r = spoke.getReserve(reserveId);
      if (address(r.hub) != address(CORE_HUB)) continue;
      ++onHub;
      if (spoke.getDynamicReserveConfig(reserveId, r.dynamicConfigKey).collateralFactor > 0) {
        ++collateral;
      }
      if (spoke.getReserveConfig(reserveId).borrowable) ++borrowable;
    }
  }

  function _assertReserve(
    ISpoke spoke,
    address underlying,
    bool collateral,
    bool borrowable,
    uint256 collateralFactor,
    uint256 maxLiquidationBonus,
    uint256 liquidationFee
  ) internal view {
    uint256 assetId = CORE_HUB.getAssetId(underlying);
    uint256 reserveId = spoke.getReserveId(address(CORE_HUB), assetId);
    ISpoke.Reserve memory r = spoke.getReserve(reserveId);
    ISpoke.DynamicReserveConfig memory dc = spoke.getDynamicReserveConfig(
      reserveId,
      r.dynamicConfigKey
    );
    assertEq(dc.collateralFactor, collateralFactor);
    assertEq(dc.maxLiquidationBonus, maxLiquidationBonus);
    assertEq(dc.liquidationFee, liquidationFee);
    assertEq(spoke.getReserveConfig(reserveId).borrowable, borrowable);
    assertEq(dc.collateralFactor > 0, collateral);
  }

  function _assertCaps(
    ISpoke spoke,
    address underlying,
    uint256 addCap,
    uint256 drawCap
  ) internal view {
    IHub.SpokeConfig memory c = CORE_HUB.getSpokeConfig(
      CORE_HUB.getAssetId(underlying),
      address(spoke)
    );
    assertTrue(c.active);
    assertEq(uint256(c.addCap), addCap);
    assertEq(uint256(c.drawCap), drawCap);
  }

  function _assertLiquidationConfig(
    ISpoke spoke,
    uint256 targetHealthFactor,
    uint256 healthFactorForMaxBonus,
    uint256 liquidationBonusFactor
  ) internal view {
    ISpoke.LiquidationConfig memory lc = spoke.getLiquidationConfig();
    assertEq(lc.targetHealthFactor, targetHealthFactor);
    assertEq(lc.healthFactorForMaxBonus, healthFactorForMaxBonus);
    assertEq(lc.liquidationBonusFactor, liquidationBonusFactor);
  }

  function _assertIrm(
    address underlying,
    uint256 liquidityFee,
    uint256 optimalUsageRatio,
    uint256 baseDrawnRate,
    uint256 slope1,
    uint256 slope2
  ) internal view {
    uint256 assetId = CORE_HUB.getAssetId(underlying);
    IHub.AssetConfig memory ac = CORE_HUB.getAssetConfig(assetId);
    assertEq(ac.liquidityFee, liquidityFee);
    IAssetInterestRateStrategy.InterestRateData memory ir = IAssetInterestRateStrategy(
      ac.irStrategy
    ).getInterestRateData(assetId);
    assertEq(ir.optimalUsageRatio, optimalUsageRatio);
    assertEq(ir.baseDrawnRate, baseDrawnRate);
    assertEq(ir.rateGrowthBeforeOptimal, slope1);
    assertEq(ir.rateGrowthAfterOptimal, slope2);
  }

  function _assertTokenizationSpoke(
    address underlying,
    address tokenizationSpoke,
    uint256 addCap
  ) internal view {
    uint256 assetId = CORE_HUB.getAssetId(underlying);
    assertTrue(CORE_HUB.isSpokeListed(assetId, tokenizationSpoke));
    IHub.SpokeConfig memory c = CORE_HUB.getSpokeConfig(assetId, tokenizationSpoke);
    assertTrue(c.active);
    assertEq(uint256(c.addCap), addCap);
    assertEq(uint256(c.drawCap), 0);
  }

  function _assertHasRole(uint64 roleId, address account) internal view {
    (bool isMember, ) = ACCESS_MANAGER.hasRole(roleId, account);
    assertTrue(isMember, 'missing role');
  }

  function _assertSoleMember(uint64 roleId, address account) internal view {
    _assertHasRole(roleId, account);
    assertEq(ACCESS_MANAGER.getRoleMemberCount(roleId), 1);
    assertEq(ACCESS_MANAGER.getRoleMember(roleId, 0), account);
  }

  function _assertSelectorsRole(
    address target,
    bytes4[] memory selectors,
    uint64 expectedRole
  ) internal view {
    for (uint256 i; i < selectors.length; ++i) {
      assertEq(ACCESS_MANAGER.getTargetFunctionRole(target, selectors[i]), expectedRole);
    }
  }

  function _proxyAdminOwner(address proxy) internal view returns (address) {
    address proxyAdmin = address(uint160(uint256(vm.load(proxy, EIP1967_ADMIN_SLOT))));
    return IOwnable2Step(proxyAdmin).owner();
  }
}
