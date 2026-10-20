// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4AvalancheSpokes, AaveV4AvalancheHubs, AaveV4Avalanche, AaveV4AvalancheIRStrategies, AaveV4AvalancheAssets, AaveV4AvalanchePositionManagers, AaveV4AvalancheSpokePriceFeeds} from 'aave-address-book/AaveV4Avalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {IAaveV4ConfigEngine as IConfigEngine} from 'aave-address-book/AaveV4.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {IAaveOracle} from 'aave-v4/spoke/interfaces/IAaveOracle.sol';
import {IPositionManagerBase} from 'aave-v4/position-manager/interfaces/IPositionManagerBase.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {V4EngineDefaults} from 'aave-helpers/src/v4-config-engine/V4EngineDefaults.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';

import 'forge-std/Test.sol';
import {ProtocolV4TestBaseAvalanche} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseAvalanche.sol';
import {AaveV4Avalanche_OnboardUSDeCoreHub_20261019} from './AaveV4Avalanche_OnboardUSDeCoreHub_20261019.sol';

/**
 * @dev Test for AaveV4Avalanche_OnboardUSDeCoreHub_20261019
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20261019_AaveV4Avalanche_OnboardUSDeCoreHub/AaveV4Avalanche_OnboardUSDeCoreHub_20261019.t.sol -vv
 */
contract AaveV4Avalanche_OnboardUSDeCoreHub_20261019_Test is ProtocolV4TestBaseAvalanche {
  AaveV4Avalanche_OnboardUSDeCoreHub_20261019 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 97969387);
    proposal = new AaveV4Avalanche_OnboardUSDeCoreHub_20261019();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    ISpoke[] memory spokes = _getSpokes();
    address ethenaEcosystemSpoke = proposal.ETHENA_ECOSYSTEM_SPOKE();
    bool listed;
    for (uint256 i; i < spokes.length; ++i) {
      if (address(spokes[i]) == ethenaEcosystemSpoke) {
      listed = true;
      }
    }
    if (!listed) {
      ISpoke[] memory extended = new ISpoke[](spokes.length + 1);
      for (uint256 i; i < spokes.length; ++i) {
        extended[i] = spokes[i];
      }
      extended[spokes.length] = ISpoke(ethenaEcosystemSpoke);
      spokes = extended;
    }
    defaultTest(
      'AaveV4Avalanche_OnboardUSDeCoreHub_20261019',
      spokes,
      _getTokenizationSpokes(),
      address(proposal)
    );
  }

  function test_preState() public view {
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    ISpoke spoke = ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE());

    assertFalse(hub.isUnderlyingListed(proposal.USDE()), 'USDe already listed');
    assertEq(spoke.getReserveCount(), 0, 'Ethena Ecosystem Spoke already configured');
    assertFalse(
      hub.isSpokeListed(
        hub.getAssetId(address(AaveV4AvalancheAssets.USDt_UNDERLYING)),
        address(spoke)
      ),
      'Core USDt already registered on Ethena Ecosystem Spoke'
    );
    assertFalse(
      hub.isSpokeListed(
        hub.getAssetId(address(AaveV4AvalancheAssets.USDC_UNDERLYING)),
        address(spoke)
      ),
      'Core USDC already registered on Ethena Ecosystem Spoke'
    );

    ISpoke.LiquidationConfig memory cfg = spoke.getLiquidationConfig();
    assertEq(uint256(cfg.targetHealthFactor), uint256(1e18), 'targetHealthFactor pre-state');
    assertEq(uint256(cfg.healthFactorForMaxBonus), uint256(0), 'hfForMaxBonus pre-state');
    assertEq(uint256(cfg.liquidationBonusFactor), uint256(0), 'bonusFactor pre-state');

    assertFalse(
      spoke.isPositionManagerActive(
        address(AaveV4AvalanchePositionManagers.GIVER_POSITION_MANAGER)
      ),
      'Giver Position Manager already active'
    );
    assertFalse(
      spoke.isPositionManagerActive(
        address(AaveV4AvalanchePositionManagers.TAKER_POSITION_MANAGER)
      ),
      'Taker Position Manager already active'
    );
    assertFalse(
      spoke.isPositionManagerActive(
        address(AaveV4AvalanchePositionManagers.CONFIG_POSITION_MANAGER)
      ),
      'Config Position Manager already active'
    );
    assertFalse(
      spoke.isPositionManagerActive(address(AaveV4AvalanchePositionManagers.SIGNATURE_GATEWAY)),
      'Signature Gateway already active'
    );

    (bool isMember, ) = AaveV4Avalanche.ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    assertFalse(isMember, 'executor already holds spoke configurator domain admin role');

    uint256 usdtId = hub.getAssetId(address(AaveV4AvalancheAssets.USDt_UNDERLYING));
    uint256 usdcId = hub.getAssetId(address(AaveV4AvalancheAssets.USDC_UNDERLYING));
    IHub.SpokeConfig memory mainUsdt = hub.getSpokeConfig(
      usdtId,
      address(AaveV4AvalancheSpokes.MAIN_SPOKE)
    );
    assertEq(uint256(mainUsdt.addCap), uint256(20_000_000), 'Main Spoke USDt addCap pre-state');
    assertEq(uint256(mainUsdt.drawCap), uint256(5_000_000), 'Main Spoke USDt drawCap pre-state');
    assertEq(
      uint256(mainUsdt.riskPremiumThreshold),
      uint256(0),
      'Main Spoke USDt riskPremiumThreshold pre-state'
    );
    assertEq(mainUsdt.active, true, 'Main Spoke USDt active pre-state');
    assertEq(mainUsdt.halted, false, 'Main Spoke USDt halted pre-state');

    IAssetInterestRateStrategy.InterestRateData memory usdtIr = IAssetInterestRateStrategy(
      address(AaveV4AvalancheIRStrategies.CORE_USDt_IR_STRATEGY)
    ).getInterestRateData(usdtId);
    assertEq(uint256(usdtIr.optimalUsageRatio), uint256(90_00), 'USDt optimalUsageRatio pre-state');
    assertEq(uint256(usdtIr.baseDrawnRate), uint256(0), 'USDt baseDrawnRate pre-state');
    assertEq(
      uint256(usdtIr.rateGrowthBeforeOptimal),
      uint256(4_00),
      'USDt rateGrowthBeforeOptimal pre-state'
    );
    assertEq(
      uint256(usdtIr.rateGrowthAfterOptimal),
      uint256(10_00),
      'USDt rateGrowthAfterOptimal pre-state'
    );

    IAssetInterestRateStrategy.InterestRateData memory usdcIr = IAssetInterestRateStrategy(
      address(AaveV4AvalancheIRStrategies.CORE_USDC_IR_STRATEGY)
    ).getInterestRateData(usdcId);
    assertEq(uint256(usdcIr.optimalUsageRatio), uint256(90_00), 'USDC optimalUsageRatio pre-state');
    assertEq(uint256(usdcIr.baseDrawnRate), uint256(0), 'USDC baseDrawnRate pre-state');
    assertEq(
      uint256(usdcIr.rateGrowthBeforeOptimal),
      uint256(4_00),
      'USDC rateGrowthBeforeOptimal pre-state'
    );
    assertEq(
      uint256(usdcIr.rateGrowthAfterOptimal),
      uint256(10_00),
      'USDC rateGrowthAfterOptimal pre-state'
    );
  }

  function test_executorSpokeConfiguratorDomainAdminRole() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (bool isMember, uint32 executionDelay) = AaveV4Avalanche.ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    assertTrue(isMember, 'executor role mismatch');
    assertEq(uint256(executionDelay), uint256(0), 'executor executionDelay mismatch');
  }

  function test_ethenaEcosystemSpokeProxyAdminOwner() public view {
    assertEq(
      _proxyAdminOwner(proposal.ETHENA_ECOSYSTEM_SPOKE()),
      MiscAvalanche.V4_SECURITY_COUNCIL,
      'Ethena Ecosystem Spoke proxy admin owner mismatch'
    );
    assertEq(
      _proxyAdminOwner(proposal.ETHENA_ECOSYSTEM_SPOKE()),
      _proxyAdminOwner(address(AaveV4AvalancheSpokes.MAIN_SPOKE)),
      'Ethena Ecosystem Spoke proxy admin owner diverges from Main Spoke'
    );
  }

  function test_rolesWired_ETHENA_ECOSYSTEM_SPOKE() public {
    IConfigEngine.TargetFunctionRoleUpdate[] memory items = proposal
      .accessManagerTargetFunctionRoleUpdates();
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 matched;
    for (uint256 i; i < items.length; ++i) {
      if (items[i].target != proposal.ETHENA_ECOSYSTEM_SPOKE()) continue;
      _assertRolesWired(items[i], address(AaveV4AvalancheSpokes.MAIN_SPOKE));
      ++matched;
    }
    assertGt(matched, 0, 'no wiring for target');
  }

  function test_spokeDeployment_ETHENA_ECOSYSTEM_SPOKE() public view {
    _assertSpokeDeployment(ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE()));
  }

  function test_hubAssetListing_CORE_HUB_USDE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    assertTrue(hub.isUnderlyingListed(proposal.USDE()), 'asset not listed');
    uint256 assetId = hub.getAssetId(proposal.USDE());
    IHub.Asset memory asset = hub.getAsset(assetId);
    IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
    assertEq(asset.underlying, proposal.USDE(), 'underlying mismatch');
    assertEq(
      uint256(asset.decimals),
      IERC20Metadata(proposal.USDE()).decimals(),
      'decimals mismatch'
    );
    assertEq(cfg.feeReceiver, address(AaveV4Avalanche.TREASURY_SPOKE), 'feeReceiver mismatch');
    assertEq(
      cfg.irStrategy,
      address(AaveV4AvalancheIRStrategies.CORE_USDt_IR_STRATEGY),
      'irStrategy mismatch'
    );
    assertEq(uint256(cfg.liquidityFee), uint256(0), 'liquidityFee mismatch');
    IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(
      cfg.irStrategy
    ).getInterestRateData(assetId);
    assertEq(
      uint256(irData.optimalUsageRatio),
      uint256(V4EngineDefaults.MAX_OPTIMAL_USAGE_RATIO),
      'optimalUsageRatio mismatch'
    );
    assertEq(uint256(irData.baseDrawnRate), uint256(0), 'baseDrawnRate mismatch');
    assertEq(
      uint256(irData.rateGrowthBeforeOptimal),
      uint256(0),
      'rateGrowthBeforeOptimal mismatch'
    );
    assertEq(uint256(irData.rateGrowthAfterOptimal), uint256(0), 'rateGrowthAfterOptimal mismatch');
    assertEq(
      _findTokenizationSpoke(hub, proposal.USDE()),
      address(0),
      'unexpected tokenization spoke'
    );
  }

  function test_spokeReserveListing_ETHENA_ECOSYSTEM_SPOKE_USDE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE());
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(proposal.USDE());
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
    assertEq(reserve.underlying, proposal.USDE(), 'underlying mismatch');
    assertEq(address(reserve.hub), address(hub), 'hub mismatch');
    assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
    assertEq(
      uint256(reserve.decimals),
      IERC20Metadata(proposal.USDE()).decimals(),
      'decimals mismatch'
    );
    assertEq(uint256(cfg.collateralRisk), uint256(16_50), 'collateralRisk mismatch');
    assertEq(cfg.paused, false, 'paused mismatch');
    assertEq(cfg.frozen, false, 'frozen mismatch');
    assertEq(cfg.borrowable, false, 'borrowable mismatch');
    assertEq(cfg.receiveSharesEnabled, true, 'receiveSharesEnabled mismatch');
    ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );
    assertEq(uint256(dyn.collateralFactor), uint256(93_00), 'collateralFactor mismatch');
    assertEq(uint256(dyn.maxLiquidationBonus), uint256(102_00), 'maxLiquidationBonus mismatch');
    assertEq(uint256(dyn.liquidationFee), uint256(10_00), 'liquidationFee mismatch');
  }

  function test_spokeReserveListing_ETHENA_ECOSYSTEM_SPOKE_USDt() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE());
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4AvalancheAssets.USDt_UNDERLYING));
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
    assertEq(
      reserve.underlying,
      address(AaveV4AvalancheAssets.USDt_UNDERLYING),
      'underlying mismatch'
    );
    assertEq(address(reserve.hub), address(hub), 'hub mismatch');
    assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
    assertEq(
      uint256(reserve.decimals),
      IERC20Metadata(address(AaveV4AvalancheAssets.USDt_UNDERLYING)).decimals(),
      'decimals mismatch'
    );
    assertEq(uint256(cfg.collateralRisk), uint256(0), 'collateralRisk mismatch');
    assertEq(cfg.paused, false, 'paused mismatch');
    assertEq(cfg.frozen, false, 'frozen mismatch');
    assertEq(cfg.borrowable, true, 'borrowable mismatch');
    assertEq(cfg.receiveSharesEnabled, true, 'receiveSharesEnabled mismatch');
    ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );
    assertEq(uint256(dyn.collateralFactor), uint256(0), 'collateralFactor mismatch');
    assertEq(uint256(dyn.maxLiquidationBonus), uint256(100_00), 'maxLiquidationBonus mismatch');
    assertEq(uint256(dyn.liquidationFee), uint256(0), 'liquidationFee mismatch');
  }

  function test_spokeReserveListing_ETHENA_ECOSYSTEM_SPOKE_USDC() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE());
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4AvalancheAssets.USDC_UNDERLYING));
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
    assertEq(
      reserve.underlying,
      address(AaveV4AvalancheAssets.USDC_UNDERLYING),
      'underlying mismatch'
    );
    assertEq(address(reserve.hub), address(hub), 'hub mismatch');
    assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
    assertEq(
      uint256(reserve.decimals),
      IERC20Metadata(address(AaveV4AvalancheAssets.USDC_UNDERLYING)).decimals(),
      'decimals mismatch'
    );
    assertEq(uint256(cfg.collateralRisk), uint256(0), 'collateralRisk mismatch');
    assertEq(cfg.paused, false, 'paused mismatch');
    assertEq(cfg.frozen, false, 'frozen mismatch');
    assertEq(cfg.borrowable, true, 'borrowable mismatch');
    assertEq(cfg.receiveSharesEnabled, true, 'receiveSharesEnabled mismatch');
    ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );
    assertEq(uint256(dyn.collateralFactor), uint256(0), 'collateralFactor mismatch');
    assertEq(uint256(dyn.maxLiquidationBonus), uint256(100_00), 'maxLiquidationBonus mismatch');
    assertEq(uint256(dyn.liquidationFee), uint256(0), 'liquidationFee mismatch');
  }

  function test_reservePriceSources_ETHENA_ECOSYSTEM_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE());
    IAaveOracle oracle = IAaveOracle(spoke.ORACLE());
    assertEq(
      oracle.getReserveSource(
        spoke.getReserveId(
          address(AaveV4AvalancheHubs.CORE_HUB),
          IHub(address(AaveV4AvalancheHubs.CORE_HUB)).getAssetId(proposal.USDE())
        )
      ),
      AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDt_PRICE_FEED,
      'USDE price source mismatch'
    );
    assertEq(
      oracle.getReserveSource(
        spoke.getReserveId(
          address(AaveV4AvalancheHubs.CORE_HUB),
          IHub(address(AaveV4AvalancheHubs.CORE_HUB)).getAssetId(
            address(AaveV4AvalancheAssets.USDt_UNDERLYING)
          )
        )
      ),
      AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDt_PRICE_FEED,
      'USDt price source mismatch'
    );
    assertEq(
      oracle.getReserveSource(
        spoke.getReserveId(
          address(AaveV4AvalancheHubs.CORE_HUB),
          IHub(address(AaveV4AvalancheHubs.CORE_HUB)).getAssetId(
            address(AaveV4AvalancheAssets.USDC_UNDERLYING)
          )
        )
      ),
      AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDC_PRICE_FEED,
      'USDC price source mismatch'
    );
  }

  function test_reservePrices_ETHENA_ECOSYSTEM_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE());
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256[] memory reserveIds = new uint256[](3);
    reserveIds[0] = spoke.getReserveId(address(hub), hub.getAssetId(proposal.USDE()));
    reserveIds[1] = spoke.getReserveId(
      address(hub),
      hub.getAssetId(address(AaveV4AvalancheAssets.USDt_UNDERLYING))
    );
    reserveIds[2] = spoke.getReserveId(
      address(hub),
      hub.getAssetId(address(AaveV4AvalancheAssets.USDC_UNDERLYING))
    );
    uint256[] memory prices = IAaveOracle(spoke.ORACLE()).getReservesPrices(reserveIds);
    assertApproxEqAbs(prices[0], 1e8, 0.02e8, 'USDE price out of range');
    assertApproxEqAbs(prices[1], 1e8, 0.02e8, 'USDt price out of range');
    assertApproxEqAbs(prices[2], 1e8, 0.02e8, 'USDC price out of range');
  }

  function test_e2e_ETHENA_ECOSYSTEM_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    e2eTestSpoke(ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE()));
  }

  /// @dev The Security Council registers the spoke on the position managers outside this payload.
  function test_e2ePositionManagers_ETHENA_ECOSYSTEM_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address spoke = proposal.ETHENA_ECOSYSTEM_SPOKE();
    address[] memory positionManagers = new address[](4);
    positionManagers[0] = address(AaveV4AvalanchePositionManagers.GIVER_POSITION_MANAGER);
    positionManagers[1] = address(AaveV4AvalanchePositionManagers.TAKER_POSITION_MANAGER);
    positionManagers[2] = address(AaveV4AvalanchePositionManagers.CONFIG_POSITION_MANAGER);
    positionManagers[3] = address(AaveV4AvalanchePositionManagers.SIGNATURE_GATEWAY);

    vm.startPrank(MiscAvalanche.V4_SECURITY_COUNCIL);
    for (uint256 i; i < positionManagers.length; ++i) {
      assertFalse(
        IPositionManagerBase(positionManagers[i]).isSpokeRegistered(spoke),
        'spoke already registered'
      );
      IPositionManagerBase(positionManagers[i]).registerSpoke(spoke, true);
    }
    vm.stopPrank();

    e2eTestPositionManagers(ISpoke(spoke));
  }

  function test_spokeLiquidationConfigUpdate_ETHENA_ECOSYSTEM_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke.LiquidationConfig memory cfg = ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE())
      .getLiquidationConfig();
    assertEq(uint256(cfg.targetHealthFactor), uint256(1.0277e18), 'targetHealthFactor mismatch');
    assertEq(
      uint256(cfg.healthFactorForMaxBonus),
      uint256(0.99e18),
      'healthFactorForMaxBonus mismatch'
    );
    assertEq(
      uint256(cfg.liquidationBonusFactor),
      uint256(100_00),
      'liquidationBonusFactor mismatch'
    );
  }

  function test_hubSpokeToAssetsAddition_CORE_HUB_ETHENA_ECOSYSTEM_SPOKE_USDE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(proposal.USDE());
    assertTrue(hub.isSpokeListed(assetId, proposal.ETHENA_ECOSYSTEM_SPOKE()), 'spoke not listed');
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, proposal.ETHENA_ECOSYSTEM_SPOKE());
    assertEq(uint256(cfg.addCap), uint256(60_000_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(0), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(0), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_hubSpokeToAssetsAddition_CORE_HUB_ETHENA_ECOSYSTEM_SPOKE_USDt() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4AvalancheAssets.USDt_UNDERLYING));
    assertTrue(hub.isSpokeListed(assetId, proposal.ETHENA_ECOSYSTEM_SPOKE()), 'spoke not listed');
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, proposal.ETHENA_ECOSYSTEM_SPOKE());
    assertEq(uint256(cfg.addCap), uint256(0), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(50_000_000), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(1_100_00), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_hubSpokeToAssetsAddition_CORE_HUB_ETHENA_ECOSYSTEM_SPOKE_USDC() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4AvalancheAssets.USDC_UNDERLYING));
    assertTrue(hub.isSpokeListed(assetId, proposal.ETHENA_ECOSYSTEM_SPOKE()), 'spoke not listed');
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, proposal.ETHENA_ECOSYSTEM_SPOKE());
    assertEq(uint256(cfg.addCap), uint256(0), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(3_000_000), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(1_100_00), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_spokePositionManagerUpdate_ETHENA_ECOSYSTEM_SPOKE_GIVER_POSITION_MANAGER() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE()).isPositionManagerActive(
        address(AaveV4AvalanchePositionManagers.GIVER_POSITION_MANAGER)
      ),
      true,
      'positionManager active mismatch'
    );
  }

  function test_spokePositionManagerUpdate_ETHENA_ECOSYSTEM_SPOKE_TAKER_POSITION_MANAGER() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE()).isPositionManagerActive(
        address(AaveV4AvalanchePositionManagers.TAKER_POSITION_MANAGER)
      ),
      true,
      'positionManager active mismatch'
    );
  }

  function test_spokePositionManagerUpdate_ETHENA_ECOSYSTEM_SPOKE_CONFIG_POSITION_MANAGER() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE()).isPositionManagerActive(
        address(AaveV4AvalanchePositionManagers.CONFIG_POSITION_MANAGER)
      ),
      true,
      'positionManager active mismatch'
    );
  }

  function test_spokePositionManagerUpdate_ETHENA_ECOSYSTEM_SPOKE_SIGNATURE_GATEWAY() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      ISpoke(proposal.ETHENA_ECOSYSTEM_SPOKE()).isPositionManagerActive(
        address(AaveV4AvalanchePositionManagers.SIGNATURE_GATEWAY)
      ),
      true,
      'positionManager active mismatch'
    );
  }

  function test_hubAssetConfigUpdate_CORE_HUB_USDt() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4AvalancheAssets.USDt_UNDERLYING));
    IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
    assertEq(uint256(cfg.liquidityFee), uint256(10_00), 'liquidityFee mismatch');
    assertEq(cfg.feeReceiver, address(AaveV4Avalanche.TREASURY_SPOKE), 'feeReceiver mismatch');
    assertEq(
      cfg.irStrategy,
      address(AaveV4AvalancheIRStrategies.CORE_USDt_IR_STRATEGY),
      'irStrategy mismatch'
    );
    assertEq(cfg.reinvestmentController, address(0), 'reinvestmentController mismatch');
    IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(
      cfg.irStrategy
    ).getInterestRateData(assetId);
    assertEq(uint256(irData.optimalUsageRatio), uint256(94_00), 'optimalUsageRatio mismatch');
    assertEq(uint256(irData.baseDrawnRate), uint256(0), 'baseDrawnRate mismatch');
    assertEq(
      uint256(irData.rateGrowthBeforeOptimal),
      uint256(4_90),
      'rateGrowthBeforeOptimal mismatch'
    );
    assertEq(
      uint256(irData.rateGrowthAfterOptimal),
      uint256(20_00),
      'rateGrowthAfterOptimal mismatch'
    );
  }

  function test_hubAssetConfigUpdate_CORE_HUB_USDC() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4AvalancheAssets.USDC_UNDERLYING));
    IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
    assertEq(uint256(cfg.liquidityFee), uint256(10_00), 'liquidityFee mismatch');
    assertEq(cfg.feeReceiver, address(AaveV4Avalanche.TREASURY_SPOKE), 'feeReceiver mismatch');
    assertEq(
      cfg.irStrategy,
      address(AaveV4AvalancheIRStrategies.CORE_USDC_IR_STRATEGY),
      'irStrategy mismatch'
    );
    assertEq(cfg.reinvestmentController, address(0), 'reinvestmentController mismatch');
    IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(
      cfg.irStrategy
    ).getInterestRateData(assetId);
    assertEq(uint256(irData.optimalUsageRatio), uint256(90_00), 'optimalUsageRatio mismatch');
    assertEq(uint256(irData.baseDrawnRate), uint256(0), 'baseDrawnRate mismatch');
    assertEq(
      uint256(irData.rateGrowthBeforeOptimal),
      uint256(4_50),
      'rateGrowthBeforeOptimal mismatch'
    );
    assertEq(
      uint256(irData.rateGrowthAfterOptimal),
      uint256(20_00),
      'rateGrowthAfterOptimal mismatch'
    );
  }

  function test_hubSpokeConfigUpdate_CORE_HUB_MAIN_SPOKE_USDt() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4AvalancheAssets.USDt_UNDERLYING));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4AvalancheSpokes.MAIN_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(60_000_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(5_000_000), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(0), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_hubAssetListingsInput() public view {
    IConfigEngine.AssetListing[] memory items = proposal.hubAssetListings();
    assertEq(items.length, 1, 'length');
    assertEq(items[0].hub, address(AaveV4AvalancheHubs.CORE_HUB), 'hub');
    assertEq(items[0].underlying, proposal.USDE(), 'underlying');
    assertEq(items[0].feeReceiver, address(AaveV4Avalanche.TREASURY_SPOKE), 'feeReceiver');
    assertEq(items[0].liquidityFee, 0, 'liquidityFee');
    assertEq(
      items[0].irStrategy,
      address(AaveV4AvalancheIRStrategies.CORE_USDt_IR_STRATEGY),
      'irStrategy'
    );
    assertEq(
      uint256(items[0].irData.optimalUsageRatio),
      V4EngineDefaults.MAX_OPTIMAL_USAGE_RATIO,
      'optimalUsageRatio'
    );
    assertEq(uint256(items[0].irData.baseDrawnRate), 0, 'baseDrawnRate');
    assertEq(uint256(items[0].irData.rateGrowthBeforeOptimal), 0, 'rateGrowthBeforeOptimal');
    assertEq(uint256(items[0].irData.rateGrowthAfterOptimal), 0, 'rateGrowthAfterOptimal');
    assertEq(items[0].tokenization.addCap, 0, 'tokenization addCap');
    assertEq(items[0].tokenization.proxyAdminOwner, address(0), 'tokenization proxyAdminOwner');
    assertEq(items[0].tokenization.name, '', 'tokenization name');
    assertEq(items[0].tokenization.symbol, '', 'tokenization symbol');
  }

  function test_spokeReserveListingsInput() public view {
    IConfigEngine.ReserveListing[] memory items = proposal.spokeReserveListings();
    assertEq(items.length, 3, 'length');
    assertEq(items[0].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(items[0].hub, address(AaveV4AvalancheHubs.CORE_HUB), 'hub');
    assertEq(items[0].underlying, proposal.USDE(), 'underlying');
    assertEq(
      items[0].priceSource,
      AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDt_PRICE_FEED,
      'priceSource'
    );
    assertEq(uint256(items[0].config.collateralRisk), 16_50, 'collateralRisk');
    assertEq(items[0].config.paused, false, 'paused');
    assertEq(items[0].config.frozen, false, 'frozen');
    assertEq(items[0].config.borrowable, false, 'borrowable');
    assertEq(items[0].config.receiveSharesEnabled, true, 'receiveSharesEnabled');
    assertEq(uint256(items[0].dynamicConfig.collateralFactor), 93_00, 'collateralFactor');
    assertEq(uint256(items[0].dynamicConfig.maxLiquidationBonus), 102_00, 'maxLiquidationBonus');
    assertEq(uint256(items[0].dynamicConfig.liquidationFee), 10_00, 'liquidationFee');
    assertEq(items[1].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(items[1].hub, address(AaveV4AvalancheHubs.CORE_HUB), 'hub');
    assertEq(items[1].underlying, address(AaveV4AvalancheAssets.USDt_UNDERLYING), 'underlying');
    assertEq(
      items[1].priceSource,
      AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDt_PRICE_FEED,
      'priceSource'
    );
    assertEq(uint256(items[1].config.collateralRisk), 0, 'collateralRisk');
    assertEq(items[1].config.paused, false, 'paused');
    assertEq(items[1].config.frozen, false, 'frozen');
    assertEq(items[1].config.borrowable, true, 'borrowable');
    assertEq(items[1].config.receiveSharesEnabled, true, 'receiveSharesEnabled');
    assertEq(uint256(items[1].dynamicConfig.collateralFactor), 0, 'collateralFactor');
    assertEq(uint256(items[1].dynamicConfig.maxLiquidationBonus), 100_00, 'maxLiquidationBonus');
    assertEq(uint256(items[1].dynamicConfig.liquidationFee), 0, 'liquidationFee');
    assertEq(items[2].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(items[2].hub, address(AaveV4AvalancheHubs.CORE_HUB), 'hub');
    assertEq(items[2].underlying, address(AaveV4AvalancheAssets.USDC_UNDERLYING), 'underlying');
    assertEq(
      items[2].priceSource,
      AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDC_PRICE_FEED,
      'priceSource'
    );
    assertEq(uint256(items[2].config.collateralRisk), 0, 'collateralRisk');
    assertEq(items[2].config.paused, false, 'paused');
    assertEq(items[2].config.frozen, false, 'frozen');
    assertEq(items[2].config.borrowable, true, 'borrowable');
    assertEq(items[2].config.receiveSharesEnabled, true, 'receiveSharesEnabled');
    assertEq(uint256(items[2].dynamicConfig.collateralFactor), 0, 'collateralFactor');
    assertEq(uint256(items[2].dynamicConfig.maxLiquidationBonus), 100_00, 'maxLiquidationBonus');
    assertEq(uint256(items[2].dynamicConfig.liquidationFee), 0, 'liquidationFee');
  }

  function test_spokeLiquidationConfigUpdatesInput() public view {
    IConfigEngine.LiquidationConfigUpdate[] memory items = proposal.spokeLiquidationConfigUpdates();
    assertEq(items.length, 1, 'length');
    assertEq(items[0].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(items[0].targetHealthFactor, 1.0277e18, 'targetHealthFactor');
    assertEq(items[0].healthFactorForMaxBonus, 0.99e18, 'healthFactorForMaxBonus');
    assertEq(items[0].liquidationBonusFactor, 100_00, 'liquidationBonusFactor');
  }

  function test_hubSpokeToAssetsAdditionsInput() public view {
    IConfigEngine.SpokeToAssetsAddition[] memory items = proposal.hubSpokeToAssetsAdditions();
    assertEq(items.length, 1, 'length');
    assertEq(items[0].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(items[0].assets.length, 3, 'assets length');
    assertEq(items[0].assets[0].underlying, proposal.USDE(), 'underlying');
    assertEq(uint256(items[0].assets[0].config.addCap), 60_000_000, 'addCap');
    assertEq(uint256(items[0].assets[0].config.drawCap), 0, 'drawCap');
    assertEq(uint256(items[0].assets[0].config.riskPremiumThreshold), 0, 'riskPremiumThreshold');
    assertEq(items[0].assets[0].config.active, true, 'active');
    assertEq(items[0].assets[0].config.halted, false, 'halted');
    assertEq(
      items[0].assets[1].underlying,
      address(AaveV4AvalancheAssets.USDt_UNDERLYING),
      'underlying'
    );
    assertEq(uint256(items[0].assets[1].config.addCap), 0, 'addCap');
    assertEq(uint256(items[0].assets[1].config.drawCap), 50_000_000, 'drawCap');
    assertEq(
      uint256(items[0].assets[1].config.riskPremiumThreshold),
      1_100_00,
      'riskPremiumThreshold'
    );
    assertEq(items[0].assets[1].config.active, true, 'active');
    assertEq(items[0].assets[1].config.halted, false, 'halted');
    assertEq(
      items[0].assets[2].underlying,
      address(AaveV4AvalancheAssets.USDC_UNDERLYING),
      'underlying'
    );
    assertEq(uint256(items[0].assets[2].config.addCap), 0, 'addCap');
    assertEq(uint256(items[0].assets[2].config.drawCap), 3_000_000, 'drawCap');
    assertEq(
      uint256(items[0].assets[2].config.riskPremiumThreshold),
      1_100_00,
      'riskPremiumThreshold'
    );
    assertEq(items[0].assets[2].config.active, true, 'active');
    assertEq(items[0].assets[2].config.halted, false, 'halted');
  }

  function test_spokePositionManagerUpdatesInput() public view {
    IConfigEngine.PositionManagerUpdate[] memory items = proposal.spokePositionManagerUpdates();
    assertEq(items.length, 4, 'length');
    assertEq(items[0].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(
      items[0].positionManager,
      address(AaveV4AvalanchePositionManagers.GIVER_POSITION_MANAGER),
      'positionManager'
    );
    assertEq(items[0].active, true, 'active');
    assertEq(items[1].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(
      items[1].positionManager,
      address(AaveV4AvalanchePositionManagers.TAKER_POSITION_MANAGER),
      'positionManager'
    );
    assertEq(items[1].active, true, 'active');
    assertEq(items[2].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(
      items[2].positionManager,
      address(AaveV4AvalanchePositionManagers.CONFIG_POSITION_MANAGER),
      'positionManager'
    );
    assertEq(items[2].active, true, 'active');
    assertEq(items[3].spoke, proposal.ETHENA_ECOSYSTEM_SPOKE(), 'spoke');
    assertEq(
      items[3].positionManager,
      address(AaveV4AvalanchePositionManagers.SIGNATURE_GATEWAY),
      'positionManager'
    );
    assertEq(items[3].active, true, 'active');
  }
}
