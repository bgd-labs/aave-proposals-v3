// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4EthereumHubs, AaveV4Ethereum, AaveV4EthereumIRStrategies, AaveV4EthereumSpokes, AaveV4EthereumSpokePriceFeeds, AaveV4EthereumAssets} from 'aave-address-book/AaveV4Ethereum.sol';
import {IAaveV4ConfigEngine as IConfigEngine} from 'aave-address-book/AaveV4.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {IAaveOracle} from 'aave-v4/spoke/interfaces/IAaveOracle.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {V4EngineDefaults} from 'aave-helpers/src/v4-config-engine/V4EngineDefaults.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';

import 'forge-std/Test.sol';
import {ProtocolV4TestBaseEthereum} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseEthereum.sol';
import {AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824} from './AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824.sol';

/**
 * @dev Test for AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260824_AaveV4Ethereum_OnboardPAXGGlobalDollarHub/AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824.t.sol -vv
 */
contract AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824_Test is ProtocolV4TestBaseEthereum {
  AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25824176);
    proposal = new AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824', address(proposal));
  }

  function test_preState() public view {
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    uint256 usdgAssetId = hub.getAssetId(address(AaveV4EthereumAssets.USDG_UNDERLYING));

    assertFalse(hub.isUnderlyingListed(proposal.PAXG()), 'PAXG already listed');
    assertFalse(
      hub.isSpokeListed(usdgAssetId, address(AaveV4EthereumSpokes.GOLD_SPOKE)),
      'Global Dollar USDG already listed on Gold Spoke'
    );
    assertFalse(
      hub.isSpokeListed(usdgAssetId, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE)),
      'Global Dollar USDG already listed on Pendle Spoke'
    );

    ISpoke.LiquidationConfig memory cfg = ISpoke(address(AaveV4EthereumSpokes.GOLD_SPOKE))
      .getLiquidationConfig();
    assertEq(uint256(cfg.targetHealthFactor), uint256(1.3075e18), 'targetHealthFactor pre-state');
    assertEq(
      uint256(cfg.healthFactorForMaxBonus),
      uint256(0.9e18),
      'healthFactorForMaxBonus pre-state'
    );
    assertEq(uint256(cfg.liquidationBonusFactor), uint256(90_00), 'bonusFactor pre-state');
  }

  function test_existingGoldReserveConfigUnchanged() public {
    ISpoke spoke = ISpoke(address(AaveV4EthereumSpokes.GOLD_SPOKE));
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4EthereumAssets.XAUt_UNDERLYING));
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.DynamicReserveConfig memory before = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ISpoke.DynamicReserveConfig memory afterConfig = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );
    assertEq(afterConfig.collateralFactor, before.collateralFactor, 'collateralFactor changed');
    assertEq(
      afterConfig.maxLiquidationBonus,
      before.maxLiquidationBonus,
      'maxLiquidationBonus changed'
    );
    assertEq(afterConfig.liquidationFee, before.liquidationFee, 'liquidationFee changed');
  }

  function test_hubAssetListing_GLOBAL_DOLLAR_HUB_PAXG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    assertTrue(hub.isUnderlyingListed(proposal.PAXG()), 'asset not listed');
    uint256 assetId = hub.getAssetId(proposal.PAXG());
    IHub.Asset memory asset = hub.getAsset(assetId);
    IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
    assertEq(asset.underlying, proposal.PAXG(), 'underlying mismatch');
    assertEq(
      uint256(asset.decimals),
      IERC20Metadata(proposal.PAXG()).decimals(),
      'decimals mismatch'
    );
    assertEq(cfg.feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE), 'feeReceiver mismatch');
    assertEq(
      cfg.irStrategy,
      address(AaveV4EthereumIRStrategies.GLOBAL_DOLLAR_USDG_IR_STRATEGY),
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
      _findTokenizationSpoke(hub, proposal.PAXG()),
      address(0),
      'unexpected tokenization spoke'
    );
  }

  function test_spokeReserveListing_GOLD_SPOKE_PAXG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(address(AaveV4EthereumSpokes.GOLD_SPOKE));
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    uint256 assetId = hub.getAssetId(proposal.PAXG());
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
    assertEq(reserve.underlying, proposal.PAXG(), 'underlying mismatch');
    assertEq(address(reserve.hub), address(hub), 'hub mismatch');
    assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
    assertEq(
      uint256(reserve.decimals),
      IERC20Metadata(proposal.PAXG()).decimals(),
      'decimals mismatch'
    );
    assertEq(uint256(cfg.collateralRisk), uint256(0), 'collateralRisk mismatch');
    assertEq(cfg.paused, false, 'paused mismatch');
    assertEq(cfg.frozen, false, 'frozen mismatch');
    assertEq(cfg.borrowable, false, 'borrowable mismatch');
    assertEq(cfg.receiveSharesEnabled, true, 'receiveSharesEnabled mismatch');
    ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );
    assertEq(uint256(dyn.collateralFactor), uint256(75_00), 'collateralFactor mismatch');
    assertEq(uint256(dyn.maxLiquidationBonus), uint256(106_50), 'maxLiquidationBonus mismatch');
    assertEq(uint256(dyn.liquidationFee), uint256(10_00), 'liquidationFee mismatch');
  }

  function test_spokeReserveListing_GOLD_SPOKE_USDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(address(AaveV4EthereumSpokes.GOLD_SPOKE));
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4EthereumAssets.USDG_UNDERLYING));
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
    assertEq(
      reserve.underlying,
      address(AaveV4EthereumAssets.USDG_UNDERLYING),
      'underlying mismatch'
    );
    assertEq(address(reserve.hub), address(hub), 'hub mismatch');
    assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
    assertEq(
      uint256(reserve.decimals),
      IERC20Metadata(address(AaveV4EthereumAssets.USDG_UNDERLYING)).decimals(),
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

  function test_spokeReserveListing_USDG_PENDLE_SPOKE_USDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE));
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4EthereumAssets.USDG_UNDERLYING));
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
    assertEq(
      reserve.underlying,
      address(AaveV4EthereumAssets.USDG_UNDERLYING),
      'underlying mismatch'
    );
    assertEq(address(reserve.hub), address(hub), 'hub mismatch');
    assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
    assertEq(
      uint256(reserve.decimals),
      IERC20Metadata(address(AaveV4EthereumAssets.USDG_UNDERLYING)).decimals(),
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

  function test_reservePriceSources_GOLD_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(address(AaveV4EthereumSpokes.GOLD_SPOKE));
    IAaveOracle oracle = IAaveOracle(spoke.ORACLE());
    assertEq(
      oracle.getReserveSource(
        spoke.getReserveId(
          address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB),
          IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB)).getAssetId(proposal.PAXG())
        )
      ),
      AaveV4EthereumSpokePriceFeeds.GOLD_SPOKE_XAUt_PRICE_FEED,
      'PAXG price source mismatch'
    );
    assertEq(
      oracle.getReserveSource(
        spoke.getReserveId(
          address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB),
          IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB)).getAssetId(
            address(AaveV4EthereumAssets.USDG_UNDERLYING)
          )
        )
      ),
      AaveV4EthereumSpokePriceFeeds.GOLD_SPOKE_USDG_PRICE_FEED,
      'USDG price source mismatch'
    );
  }

  function test_reservePriceSources_USDG_PENDLE_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE));
    IAaveOracle oracle = IAaveOracle(spoke.ORACLE());
    assertEq(
      oracle.getReserveSource(
        spoke.getReserveId(
          address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB),
          IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB)).getAssetId(
            address(AaveV4EthereumAssets.USDG_UNDERLYING)
          )
        )
      ),
      AaveV4EthereumSpokePriceFeeds.USDG_PENDLE_SPOKE_USDG_PRICE_FEED,
      'USDG price source mismatch'
    );
  }

  function test_spokeLiquidationConfigUpdate_GOLD_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke.LiquidationConfig memory cfg = ISpoke(address(AaveV4EthereumSpokes.GOLD_SPOKE))
      .getLiquidationConfig();
    assertEq(uint256(cfg.targetHealthFactor), uint256(1.2e18), 'targetHealthFactor mismatch');
    assertEq(
      uint256(cfg.healthFactorForMaxBonus),
      uint256(0.9e18),
      'healthFactorForMaxBonus mismatch'
    );
    assertEq(
      uint256(cfg.liquidationBonusFactor),
      uint256(80_00),
      'liquidationBonusFactor mismatch'
    );
  }

  function test_hubSpokeToAssetsAddition_GLOBAL_DOLLAR_HUB_GOLD_SPOKE_PAXG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    uint256 assetId = hub.getAssetId(proposal.PAXG());
    assertTrue(
      hub.isSpokeListed(assetId, address(AaveV4EthereumSpokes.GOLD_SPOKE)),
      'spoke not listed'
    );
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.GOLD_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(2_500), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(0), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(0), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_hubSpokeToAssetsAddition_GLOBAL_DOLLAR_HUB_GOLD_SPOKE_USDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4EthereumAssets.USDG_UNDERLYING));
    assertTrue(
      hub.isSpokeListed(assetId, address(AaveV4EthereumSpokes.GOLD_SPOKE)),
      'spoke not listed'
    );
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.GOLD_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(5_000_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(9_500_000), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(0), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_hubSpokeToAssetsAddition_GLOBAL_DOLLAR_HUB_USDG_PENDLE_SPOKE_USDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB));
    uint256 assetId = hub.getAssetId(address(AaveV4EthereumAssets.USDG_UNDERLYING));
    assertTrue(
      hub.isSpokeListed(assetId, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE)),
      'spoke not listed'
    );
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(0), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(4_000_000), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(0), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_hubAssetListingsInput() public view {
    IConfigEngine.AssetListing[] memory items = proposal.hubAssetListings();
    assertEq(items.length, 1, 'length');
    assertEq(items[0].hub, address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB), 'hub');
    assertEq(items[0].underlying, proposal.PAXG(), 'underlying');
    assertEq(items[0].feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE), 'feeReceiver');
    assertEq(items[0].liquidityFee, 0, 'liquidityFee');
    assertEq(
      items[0].irStrategy,
      address(AaveV4EthereumIRStrategies.GLOBAL_DOLLAR_USDG_IR_STRATEGY),
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
  }

  function test_spokeReserveListingsInput() public view {
    IConfigEngine.ReserveListing[] memory items = proposal.spokeReserveListings();
    assertEq(items.length, 3, 'length');
    assertEq(items[0].spoke, address(AaveV4EthereumSpokes.GOLD_SPOKE), 'spoke');
    assertEq(items[0].hub, address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB), 'hub');
    assertEq(items[0].underlying, proposal.PAXG(), 'underlying');
    assertEq(
      items[0].priceSource,
      AaveV4EthereumSpokePriceFeeds.GOLD_SPOKE_XAUt_PRICE_FEED,
      'priceSource'
    );
    assertEq(uint256(items[0].config.collateralRisk), 0, 'collateralRisk');
    assertEq(items[0].config.paused, false, 'paused');
    assertEq(items[0].config.frozen, false, 'frozen');
    assertEq(items[0].config.borrowable, false, 'borrowable');
    assertEq(items[0].config.receiveSharesEnabled, true, 'receiveSharesEnabled');
    assertEq(uint256(items[0].dynamicConfig.collateralFactor), 75_00, 'collateralFactor');
    assertEq(uint256(items[0].dynamicConfig.maxLiquidationBonus), 106_50, 'maxLiquidationBonus');
    assertEq(uint256(items[0].dynamicConfig.liquidationFee), 10_00, 'liquidationFee');
    assertEq(items[1].spoke, address(AaveV4EthereumSpokes.GOLD_SPOKE), 'spoke');
    assertEq(items[1].hub, address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB), 'hub');
    assertEq(items[1].underlying, address(AaveV4EthereumAssets.USDG_UNDERLYING), 'underlying');
    assertEq(
      items[1].priceSource,
      AaveV4EthereumSpokePriceFeeds.GOLD_SPOKE_USDG_PRICE_FEED,
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
    assertEq(items[2].spoke, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE), 'spoke');
    assertEq(items[2].hub, address(AaveV4EthereumHubs.GLOBAL_DOLLAR_HUB), 'hub');
    assertEq(items[2].underlying, address(AaveV4EthereumAssets.USDG_UNDERLYING), 'underlying');
    assertEq(
      items[2].priceSource,
      AaveV4EthereumSpokePriceFeeds.USDG_PENDLE_SPOKE_USDG_PRICE_FEED,
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
    assertEq(items[0].spoke, address(AaveV4EthereumSpokes.GOLD_SPOKE), 'spoke');
    assertEq(items[0].targetHealthFactor, 1.2e18, 'targetHealthFactor');
    assertEq(items[0].healthFactorForMaxBonus, 0.9e18, 'healthFactorForMaxBonus');
    assertEq(items[0].liquidationBonusFactor, 80_00, 'liquidationBonusFactor');
  }

  function test_hubSpokeToAssetsAdditionsInput() public view {
    IConfigEngine.SpokeToAssetsAddition[] memory items = proposal.hubSpokeToAssetsAdditions();
    assertEq(items.length, 2, 'length');
    assertEq(items[0].spoke, address(AaveV4EthereumSpokes.GOLD_SPOKE), 'spoke');
    assertEq(items[0].assets.length, 2, 'assets length');
    assertEq(items[0].assets[0].underlying, proposal.PAXG(), 'underlying');
    assertEq(uint256(items[0].assets[0].config.addCap), 2_500, 'addCap');
    assertEq(uint256(items[0].assets[0].config.drawCap), 0, 'drawCap');
    assertEq(uint256(items[0].assets[0].config.riskPremiumThreshold), 0, 'riskPremiumThreshold');
    assertEq(items[0].assets[0].config.active, true, 'active');
    assertEq(items[0].assets[0].config.halted, false, 'halted');
    assertEq(
      items[0].assets[1].underlying,
      address(AaveV4EthereumAssets.USDG_UNDERLYING),
      'underlying'
    );
    assertEq(uint256(items[0].assets[1].config.addCap), 5_000_000, 'addCap');
    assertEq(uint256(items[0].assets[1].config.drawCap), 9_500_000, 'drawCap');
    assertEq(uint256(items[0].assets[1].config.riskPremiumThreshold), 0, 'riskPremiumThreshold');
    assertEq(items[0].assets[1].config.active, true, 'active');
    assertEq(items[0].assets[1].config.halted, false, 'halted');
    assertEq(items[1].spoke, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE), 'spoke');
    assertEq(items[1].assets.length, 1, 'assets length');
    assertEq(
      items[1].assets[0].underlying,
      address(AaveV4EthereumAssets.USDG_UNDERLYING),
      'underlying'
    );
    assertEq(uint256(items[1].assets[0].config.addCap), 0, 'addCap');
    assertEq(uint256(items[1].assets[0].config.drawCap), 4_000_000, 'drawCap');
    assertEq(uint256(items[1].assets[0].config.riskPremiumThreshold), 0, 'riskPremiumThreshold');
    assertEq(items[1].assets[0].config.active, true, 'active');
    assertEq(items[1].assets[0].config.halted, false, 'halted');
  }
}
