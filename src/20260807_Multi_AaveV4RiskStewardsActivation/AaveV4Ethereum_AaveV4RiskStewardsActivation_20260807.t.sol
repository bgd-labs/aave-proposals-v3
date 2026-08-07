// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets} from 'aave-address-book/AaveV4Ethereum.sol';
import {IAaveV4ConfigEngine as IConfigEngine, IHub, ISpoke, ITokenizationSpoke} from 'aave-address-book/AaveV4.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';
import {IRiskStewardV4} from 'src/interfaces/IRiskStewardV4.sol';
import {ProtocolV4TestBaseEthereum} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseEthereum.sol';
import {AaveV4Ethereum_AaveV4RiskStewardsActivation_20260807} from './AaveV4Ethereum_AaveV4RiskStewardsActivation_20260807.sol';

/**
 * @dev Test for AaveV4Ethereum_AaveV4RiskStewardsActivation_20260807
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260807_Multi_AaveV4RiskStewardsActivation/AaveV4Ethereum_AaveV4RiskStewardsActivation_20260807.t.sol -vv
 */
contract AaveV4Ethereum_AaveV4RiskStewardsActivation_20260807_Test is ProtocolV4TestBaseEthereum {
  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;
  ISpoke internal constant MAIN_SPOKE = AaveV4EthereumSpokes.MAIN_SPOKE;
  address internal constant WETH = AaveV4EthereumAssets.WETH_UNDERLYING;

  AaveV4Ethereum_AaveV4RiskStewardsActivation_20260807 internal proposal;
  IRiskStewardV4 internal steward;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25701834);
    proposal = new AaveV4Ethereum_AaveV4RiskStewardsActivation_20260807();
    steward = IRiskStewardV4(proposal.RISK_STEWARD());
  }

  modifier activated() {
    GovV3Helpers.executePayload(vm, address(proposal));
    _;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV4Ethereum_AaveV4RiskStewardsActivation_20260807', address(proposal));
  }

  function test_stewardOwnerAndCouncil() public view {
    assertEq(steward.owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1, 'owner mismatch');
    assertEq(
      steward.RISK_COUNCIL(),
      IRiskSteward(AaveV3Ethereum.RISK_STEWARD).RISK_COUNCIL(),
      'council diverges from the v3 risk steward'
    );
  }

  function test_rolesGranted() public activated {
    (bool isHubAdmin, uint32 hubDelay) = AaveV4Ethereum.ACCESS_MANAGER.hasRole(
      Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      proposal.RISK_STEWARD()
    );
    assertTrue(isHubAdmin, 'hub configurator role not granted');
    assertEq(uint256(hubDelay), 0, 'hub configurator role delay');

    (bool isSpokeAdmin, uint32 spokeDelay) = AaveV4Ethereum.ACCESS_MANAGER.hasRole(
      Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      proposal.RISK_STEWARD()
    );
    assertTrue(isSpokeAdmin, 'spoke configurator role not granted');
    assertEq(uint256(spokeDelay), 0, 'spoke configurator role delay');
  }

  function test_riskStewardConfig() public activated {
    _assertConfig(steward.getConfig());
  }

  /// @dev Covers the bounds LlamaRisk carried over from the v3 Risk Steward unchanged. The params
  /// they widened (baseDrawnRate, rateGrowthBeforeOptimal, collateralRisk, the dynamicAdd bounds)
  /// and those with no v3 counterpart are asserted in `_assertConfig` only.
  function test_boundsMatchV3RiskSteward() public activated {
    IRiskSteward.Config memory v3 = IRiskSteward(AaveV3Ethereum.RISK_STEWARD).getRiskConfig();
    IRiskStewardV4.Config memory v4 = steward.getConfig();

    assertEq(
      uint256(v4.hub.rate.optimalUsageRatio.maxPercentChange),
      v3.rateConfig.optimalUsageRatio.maxPercentChange,
      'optimalUsageRatio bound'
    );
    assertEq(
      uint256(v4.hub.rate.rateGrowthAfterOptimal.maxPercentChange),
      v3.rateConfig.variableRateSlope2.maxPercentChange,
      'rateGrowthAfterOptimal bound'
    );
    assertEq(
      uint256(v4.hub.cap.addCap.maxPercentChange),
      v3.capConfig.supplyCap.maxPercentChange,
      'addCap bound'
    );
    assertEq(
      uint256(v4.hub.cap.drawCap.maxPercentChange),
      v3.capConfig.borrowCap.maxPercentChange,
      'drawCap bound'
    );
    assertEq(
      uint256(v4.spoke.dynamicUpdate.collateralFactor.maxPercentChange),
      v3.collateralConfig.ltv.maxPercentChange,
      'collateralFactor bound'
    );
    assertEq(
      uint256(v4.spoke.dynamicUpdate.maxLiquidationBonus.maxPercentChange),
      v3.collateralConfig.liquidationBonus.maxPercentChange,
      'maxLiquidationBonus bound'
    );
    assertEq(
      uint256(v4.oracle.priceCapLst.maxPercentChange),
      v3.priceCapConfig.priceCapLst.maxPercentChange,
      'priceCapLst bound'
    );
    assertEq(
      uint256(v4.oracle.priceCapStable.maxPercentChange),
      v3.priceCapConfig.priceCapStable.maxPercentChange,
      'priceCapStable bound'
    );
    assertEq(
      uint256(v4.oracle.discountRatePendle.maxPercentChange),
      v3.priceCapConfig.discountRatePendle.maxPercentChange,
      'discountRatePendle bound'
    );
    assertEq(
      uint256(v4.oracle.discountRatePendle.minDelay),
      uint256(v3.priceCapConfig.discountRatePendle.minDelay),
      'discountRatePendle cooldown'
    );
  }

  function test_riskCouncilCanUpdateAddCap() public activated {
    uint256 assetId = CORE_HUB.getAssetId(WETH);
    uint256 addCapBefore = CORE_HUB.getSpokeConfig(assetId, address(MAIN_SPOKE)).addCap;

    vm.prank(steward.RISK_COUNCIL());
    steward.updateHubSpokeCaps(_addCapUpdate(addCapBefore + addCapBefore / 2));

    assertEq(
      uint256(CORE_HUB.getSpokeConfig(assetId, address(MAIN_SPOKE)).addCap),
      addCapBefore + addCapBefore / 2,
      'addCap not updated'
    );
  }

  function test_riskCouncilCannotUpdateAddCapAboveBound() public activated {
    uint256 assetId = CORE_HUB.getAssetId(WETH);
    uint256 addCapBefore = CORE_HUB.getSpokeConfig(assetId, address(MAIN_SPOKE)).addCap;
    address riskCouncil = steward.RISK_COUNCIL();

    vm.expectRevert(IRiskStewardV4.UpdateNotInRange.selector);
    vm.prank(riskCouncil);
    steward.updateHubSpokeCaps(_addCapUpdate(2 * addCapBefore + 1));
  }

  function _getTokenizationSpokes() internal view override returns (ITokenizationSpoke[] memory) {
    ITokenizationSpoke[] memory all = super._getTokenizationSpokes();
    uint256 activeCount;
    for (uint256 i; i < all.length; ++i) {
      if (_isTokenizationSpokeActive(all[i])) ++activeCount;
    }
    ITokenizationSpoke[] memory active = new ITokenizationSpoke[](activeCount);
    uint256 index;
    for (uint256 i; i < all.length; ++i) {
      if (_isTokenizationSpokeActive(all[i])) active[index++] = all[i];
    }
    return active;
  }

  function _isTokenizationSpokeActive(
    ITokenizationSpoke tokenizationSpoke
  ) internal view returns (bool) {
    return
      IHub(tokenizationSpoke.hub())
        .getSpokeConfig(tokenizationSpoke.assetId(), address(tokenizationSpoke))
        .active;
  }

  function _addCapUpdate(
    uint256 addCap
  ) internal pure returns (IConfigEngine.SpokeConfigUpdate[] memory) {
    IConfigEngine.SpokeConfigUpdate[] memory updates = new IConfigEngine.SpokeConfigUpdate[](1);
    updates[0] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(CORE_HUB),
      underlying: WETH,
      spoke: address(MAIN_SPOKE),
      addCap: addCap,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    return updates;
  }

  function _assertConfig(IRiskStewardV4.Config memory config) internal pure {
    assertEq(
      address(config.hub.configurator),
      address(AaveV4Ethereum.HUB_CONFIGURATOR),
      'hub configurator mismatch'
    );
    assertEq(
      address(config.spoke.configurator),
      address(AaveV4Ethereum.SPOKE_CONFIGURATOR),
      'spoke configurator mismatch'
    );

    // prettier-ignore
    {
      //           param                                           minDelay  maxChange   relative  label
      _assertParam(config.hub.rate.optimalUsageRatio,               36 hours, 3_00,       false,    'optimalUsageRatio');
      _assertParam(config.hub.rate.baseDrawnRate,                   36 hours, 3_00,       false,    'baseDrawnRate');
      _assertParam(config.hub.rate.rateGrowthBeforeOptimal,         36 hours, 3_00,       false,    'rateGrowthBeforeOptimal');
      _assertParam(config.hub.rate.rateGrowthAfterOptimal,          36 hours, 20_00,      false,    'rateGrowthAfterOptimal');
      _assertParam(config.hub.cap.addCap,                           36 hours, 100_00,     true,     'addCap');
      _assertParam(config.hub.cap.drawCap,                          36 hours, 100_00,     true,     'drawCap');
      _assertParam(config.spoke.collateralRisk,                     36 hours, 300_00,     false,    'collateralRisk');
      _assertParam(config.spoke.dynamicUpdate.collateralFactor,     72 hours, 50,         false,    'dynamicUpdate collateralFactor');
      _assertParam(config.spoke.dynamicUpdate.maxLiquidationBonus,  72 hours, 50,         false,    'dynamicUpdate maxLiquidationBonus');
      _assertParam(config.spoke.dynamicAdd.collateralFactor,        72 hours, 100_00,     false,    'dynamicAdd collateralFactor');
      _assertParam(config.spoke.dynamicAdd.maxLiquidationBonus,     72 hours, 50,         false,    'dynamicAdd maxLiquidationBonus');
      _assertParam(config.spoke.liquidation.targetHealthFactor,     72 hours, 5_00,       true,     'targetHealthFactor');
      _assertParam(config.spoke.liquidation.healthFactorForMaxBonus,72 hours, 5_00,       true,     'healthFactorForMaxBonus');
      _assertParam(config.spoke.liquidation.liquidationBonusFactor, 72 hours, 5_00,       false,    'liquidationBonusFactor');
      _assertParam(config.oracle.priceCapLst,                       72 hours, 5_00,       true,     'priceCapLst');
      _assertParam(config.oracle.priceCapStable,                    72 hours, 50,         true,     'priceCapStable');
      _assertParam(config.oracle.discountRatePendle,                48 hours, 0.025e18,   false,    'discountRatePendle');
    }
  }

  function _assertParam(
    IRiskStewardV4.RiskParamConfig memory param,
    uint256 minDelay,
    uint256 maxPercentChange,
    bool isChangeRelative,
    string memory label
  ) internal pure {
    assertEq(uint256(param.minDelay), minDelay, string.concat(label, ' minDelay'));
    assertEq(
      uint256(param.maxPercentChange),
      maxPercentChange,
      string.concat(label, ' maxPercentChange')
    );
    assertEq(param.isChangeRelative, isChangeRelative, string.concat(label, ' isChangeRelative'));
  }
}
