// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';
import {IAaveV4ConfigEngine as IConfigEngine} from 'aave-address-book/AaveV4.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {Ownable} from 'openzeppelin-contracts/contracts/access/Ownable.sol';

import 'forge-std/Test.sol';
import {ProtocolV4TestBaseEthereum} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseEthereum.sol';
import {AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723} from './AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723.sol';

/**
 * @dev Test for AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260723_AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum/AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723.t.sol -vv
 */
contract AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723_Test is
  ProtocolV4TestBaseEthereum
{
  bytes32 internal constant ERC1967_ADMIN_SLOT =
    0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;

  AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25595817);
    proposal = new AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723', address(proposal));
  }

  function test_accessManagerTargetFunctionRoleUpdatesInput() public view {
    IConfigEngine.TargetFunctionRoleUpdate[] memory updates = proposal
      .accessManagerTargetFunctionRoleUpdates();
    assertEq(updates.length, 1, 'updates length mismatch');
    assertEq(updates[0].authority, address(AaveV4Ethereum.ACCESS_MANAGER), 'authority');
    assertEq(updates[0].target, proposal.MAPLE_SPOKE(), 'target');
    assertEq(uint256(updates[0].roleId), 301, 'roleId');
    assertEq(updates[0].selectors.length, 7, 'selectors length');
    assertEq(
      uint32(updates[0].selectors[0]),
      uint32(ISpoke.updateLiquidationConfig.selector),
      's0'
    );
    assertEq(uint32(updates[0].selectors[1]), uint32(ISpoke.addReserve.selector), 's1');
    assertEq(uint32(updates[0].selectors[2]), uint32(ISpoke.updateReserveConfig.selector), 's2');
    assertEq(
      uint32(updates[0].selectors[3]),
      uint32(ISpoke.updateDynamicReserveConfig.selector),
      's3'
    );
    assertEq(
      uint32(updates[0].selectors[4]),
      uint32(ISpoke.addDynamicReserveConfig.selector),
      's4'
    );
    assertEq(uint32(updates[0].selectors[5]), uint32(ISpoke.updatePositionManager.selector), 's5');
    assertEq(
      uint32(updates[0].selectors[6]),
      uint32(ISpoke.updateReservePriceSource.selector),
      's6'
    );
  }

  function test_spokeConfiguratorRolesWired_MAPLE_SPOKE() public {
    IConfigEngine.TargetFunctionRoleUpdate[] memory updates = proposal
      .accessManagerTargetFunctionRoleUpdates();
    GovV3Helpers.executePayload(vm, address(proposal));
    for (uint256 i; i < updates[0].selectors.length; ++i) {
      assertEq(
        uint256(
          AaveV4Ethereum.ACCESS_MANAGER.getTargetFunctionRole(
            updates[0].target,
            updates[0].selectors[i]
          )
        ),
        uint256(updates[0].roleId),
        'spoke configurator role not wired'
      );
    }
  }

  function test_hubAssetListingsInput() public view {
    IConfigEngine.AssetListing[] memory listings = proposal.hubAssetListings();
    assertEq(listings.length, 2, 'listings length mismatch');

    assertEq(listings[0].underlying, AaveV4EthereumAssets.USDG_UNDERLYING, 'USDG underlying');
    assertEq(listings[0].hub, address(AaveV4EthereumHubs.PAXOS_HUB), 'USDG hub');
    assertEq(listings[0].feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE), 'USDG feeReceiver');
    assertEq(listings[0].liquidityFee, 20_00, 'USDG liquidityFee');
    assertEq(listings[0].irStrategy, proposal.PAXOS_HUB_USDG_IR_STRATEGY(), 'USDG irStrategy');
    assertEq(uint256(listings[0].irData.optimalUsageRatio), 90_00, 'USDG optimalUsageRatio');
    assertEq(uint256(listings[0].irData.baseDrawnRate), 0, 'USDG baseDrawnRate');
    assertEq(uint256(listings[0].irData.rateGrowthBeforeOptimal), 4_00, 'USDG slope1');
    assertEq(uint256(listings[0].irData.rateGrowthAfterOptimal), 35_00, 'USDG slope2');
    assertEq(listings[0].tokenization.addCap, 1000000, 'USDG tokenization addCap');
    assertEq(
      listings[0].tokenization.proxyAdminOwner,
      proposal.SECURITY_COUNCIL_V4(),
      'USDG tokenization proxyAdminOwner'
    );
    assertEq(listings[0].tokenization.name, 'Wrapped Aave Paxos USDG', 'USDG tokenization name');
    assertEq(listings[0].tokenization.symbol, 'waPaxosUSDG', 'USDG tokenization symbol');

    assertEq(listings[1].underlying, proposal.SYRUPUSDG(), 'syrupUSDG underlying');
    assertEq(listings[1].hub, address(AaveV4EthereumHubs.PAXOS_HUB), 'syrupUSDG hub');
    assertEq(
      listings[1].feeReceiver,
      address(AaveV4Ethereum.TREASURY_SPOKE),
      'syrupUSDG feeReceiver'
    );
    assertEq(listings[1].liquidityFee, 0, 'syrupUSDG liquidityFee');
    assertEq(
      listings[1].irStrategy,
      proposal.PAXOS_HUB_SYRUPUSDG_IR_STRATEGY(),
      'syrupUSDG irStrategy'
    );
    assertEq(uint256(listings[1].irData.optimalUsageRatio), 99_00, 'syrupUSDG optimalUsageRatio');
    assertEq(uint256(listings[1].irData.baseDrawnRate), 0, 'syrupUSDG baseDrawnRate');
    assertEq(uint256(listings[1].irData.rateGrowthBeforeOptimal), 0, 'syrupUSDG slope1');
    assertEq(uint256(listings[1].irData.rateGrowthAfterOptimal), 0, 'syrupUSDG slope2');
  }

  function test_spokeReserveListingsInput() public view {
    IConfigEngine.ReserveListing[] memory listings = proposal.spokeReserveListings();
    assertEq(listings.length, 2, 'listings length mismatch');

    assertEq(listings[0].spoke, proposal.MAPLE_SPOKE(), 'USDG spoke');
    assertEq(listings[0].hub, address(AaveV4EthereumHubs.PAXOS_HUB), 'USDG hub');
    assertEq(listings[0].underlying, AaveV4EthereumAssets.USDG_UNDERLYING, 'USDG underlying');
    assertEq(listings[0].priceSource, proposal.MAPLE_SPOKE_USDG_PRICE_FEED(), 'USDG priceSource');
    assertEq(uint256(listings[0].config.collateralRisk), 0, 'USDG collateralRisk');
    assertEq(listings[0].config.borrowable, true, 'USDG borrowable');
    assertEq(listings[0].config.receiveSharesEnabled, true, 'USDG receiveSharesEnabled');
    assertEq(uint256(listings[0].dynamicConfig.collateralFactor), 0, 'USDG collateralFactor');
    assertEq(uint256(listings[0].dynamicConfig.maxLiquidationBonus), 100_00, 'USDG maxLiqBonus');
    assertEq(uint256(listings[0].dynamicConfig.liquidationFee), 0, 'USDG liquidationFee');

    assertEq(listings[1].spoke, proposal.MAPLE_SPOKE(), 'syrupUSDG spoke');
    assertEq(listings[1].hub, address(AaveV4EthereumHubs.PAXOS_HUB), 'syrupUSDG hub');
    assertEq(listings[1].underlying, proposal.SYRUPUSDG(), 'syrupUSDG underlying');
    assertEq(
      listings[1].priceSource,
      proposal.MAPLE_SPOKE_SYRUPUSDG_PRICE_FEED(),
      'syrupUSDG priceSource'
    );
    assertEq(uint256(listings[1].config.collateralRisk), 0, 'syrupUSDG collateralRisk');
    assertEq(listings[1].config.borrowable, false, 'syrupUSDG borrowable');
    assertEq(listings[1].config.receiveSharesEnabled, true, 'syrupUSDG receiveSharesEnabled');
    assertEq(
      uint256(listings[1].dynamicConfig.collateralFactor),
      92_00,
      'syrupUSDG collateralFactor'
    );
    assertEq(
      uint256(listings[1].dynamicConfig.maxLiquidationBonus),
      104_00,
      'syrupUSDG maxLiqBonus'
    );
    assertEq(uint256(listings[1].dynamicConfig.liquidationFee), 10_00, 'syrupUSDG liquidationFee');
  }

  function test_hubSpokeToAssetsAdditionsInput() public view {
    IConfigEngine.SpokeToAssetsAddition[] memory additions = proposal.hubSpokeToAssetsAdditions();
    assertEq(additions.length, 2, 'additions length mismatch');

    assertEq(additions[0].spoke, proposal.MAPLE_SPOKE(), 'USDG spoke');
    assertEq(
      additions[0].assets[0].underlying,
      AaveV4EthereumAssets.USDG_UNDERLYING,
      'USDG underlying'
    );
    assertEq(uint256(additions[0].assets[0].config.addCap), 10000000, 'USDG addCap');
    assertEq(uint256(additions[0].assets[0].config.drawCap), 9500000, 'USDG drawCap');
    assertEq(
      uint256(additions[0].assets[0].config.riskPremiumThreshold),
      0,
      'USDG riskPremiumThreshold'
    );
    assertEq(additions[0].assets[0].config.active, true, 'USDG active');
    assertEq(additions[0].assets[0].config.halted, false, 'USDG halted');

    assertEq(additions[1].spoke, proposal.MAPLE_SPOKE(), 'syrupUSDG spoke');
    assertEq(additions[1].assets[0].underlying, proposal.SYRUPUSDG(), 'syrupUSDG underlying');
    assertEq(uint256(additions[1].assets[0].config.addCap), 10000000, 'syrupUSDG addCap');
    assertEq(uint256(additions[1].assets[0].config.drawCap), 0, 'syrupUSDG drawCap');
    assertEq(
      uint256(additions[1].assets[0].config.riskPremiumThreshold),
      0,
      'syrupUSDG riskPremiumThreshold'
    );
    assertEq(additions[1].assets[0].config.active, true, 'syrupUSDG active');
    assertEq(additions[1].assets[0].config.halted, false, 'syrupUSDG halted');
  }

  function test_spokeLiquidationConfigUpdatesInput() public view {
    IConfigEngine.LiquidationConfigUpdate[] memory updates = proposal
      .spokeLiquidationConfigUpdates();
    assertEq(updates.length, 1, 'updates length mismatch');

    assertEq(updates[0].spoke, proposal.MAPLE_SPOKE(), 'spoke');
    assertEq(updates[0].targetHealthFactor, 1_027_700_000_000_000_000, 'targetHealthFactor');
    assertEq(
      updates[0].healthFactorForMaxBonus,
      990_000_000_000_000_000,
      'healthFactorForMaxBonus'
    );
    assertEq(updates[0].liquidationBonusFactor, 10_000, 'liquidationBonusFactor');
  }

  function test_spokePositionManagerUpdatesInput() public view {
    IConfigEngine.PositionManagerUpdate[] memory updates = proposal.spokePositionManagerUpdates();
    assertEq(updates.length, 4, 'updates length mismatch');

    assertEq(updates[0].spoke, proposal.MAPLE_SPOKE(), 'giver spoke');
    assertEq(
      updates[0].positionManager,
      address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      'giver positionManager'
    );
    assertEq(updates[0].active, true, 'giver active');
    assertEq(
      updates[1].positionManager,
      address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER),
      'taker positionManager'
    );
    assertEq(updates[1].active, true, 'taker active');
    assertEq(
      updates[2].positionManager,
      address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER),
      'config positionManager'
    );
    assertEq(updates[2].active, true, 'config active');
    assertEq(
      updates[3].positionManager,
      address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY),
      'signature gateway positionManager'
    );
    assertEq(updates[3].active, true, 'signature gateway active');
  }

  function test_hubAssetListing_PAXOS_HUB_USDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.PAXOS_HUB));
    assertTrue(hub.isUnderlyingListed(AaveV4EthereumAssets.USDG_UNDERLYING), 'asset not listed');
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    IHub.Asset memory asset = hub.getAsset(assetId);
    IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
    assertEq(asset.underlying, AaveV4EthereumAssets.USDG_UNDERLYING, 'underlying mismatch');
    assertEq(
      uint256(asset.decimals),
      IERC20Metadata(AaveV4EthereumAssets.USDG_UNDERLYING).decimals(),
      'decimals mismatch'
    );
    assertEq(cfg.feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE), 'feeReceiver mismatch');
    assertEq(cfg.irStrategy, proposal.PAXOS_HUB_USDG_IR_STRATEGY(), 'irStrategy mismatch');
    assertEq(uint256(cfg.liquidityFee), uint256(20_00), 'liquidityFee mismatch');
    IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(
      cfg.irStrategy
    ).getInterestRateData(assetId);
    assertEq(uint256(irData.optimalUsageRatio), uint256(90_00), 'optimalUsageRatio mismatch');
    assertEq(uint256(irData.baseDrawnRate), uint256(0), 'baseDrawnRate mismatch');
    assertEq(
      uint256(irData.rateGrowthBeforeOptimal),
      uint256(4_00),
      'rateGrowthBeforeOptimal mismatch'
    );
    assertEq(
      uint256(irData.rateGrowthAfterOptimal),
      uint256(35_00),
      'rateGrowthAfterOptimal mismatch'
    );
    address tokenizationSpoke = _findTokenizationSpoke(hub, assetId);
    IHub.SpokeConfig memory tokenizationCfg = hub.getSpokeConfig(assetId, tokenizationSpoke);
    assertEq(uint256(tokenizationCfg.addCap), uint256(1000000), 'tokenization addCap mismatch');
    assertEq(
      IERC20Metadata(tokenizationSpoke).name(),
      'Wrapped Aave Paxos USDG',
      'tokenization name mismatch'
    );
    assertEq(
      IERC20Metadata(tokenizationSpoke).symbol(),
      'waPaxosUSDG',
      'tokenization symbol mismatch'
    );
  }

  function test_hubAssetListing_PAXOS_HUB_SYRUPUSDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.PAXOS_HUB));
    assertTrue(hub.isUnderlyingListed(proposal.SYRUPUSDG()), 'asset not listed');
    uint256 assetId = hub.getAssetId(proposal.SYRUPUSDG());
    IHub.Asset memory asset = hub.getAsset(assetId);
    IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
    assertEq(asset.underlying, proposal.SYRUPUSDG(), 'underlying mismatch');
    assertEq(
      uint256(asset.decimals),
      IERC20Metadata(proposal.SYRUPUSDG()).decimals(),
      'decimals mismatch'
    );
    assertEq(cfg.feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE), 'feeReceiver mismatch');
    assertEq(cfg.irStrategy, proposal.PAXOS_HUB_SYRUPUSDG_IR_STRATEGY(), 'irStrategy mismatch');
    assertEq(uint256(cfg.liquidityFee), uint256(0), 'liquidityFee mismatch');
    IAssetInterestRateStrategy.InterestRateData memory irData = IAssetInterestRateStrategy(
      cfg.irStrategy
    ).getInterestRateData(assetId);
    assertEq(uint256(irData.optimalUsageRatio), uint256(99_00), 'optimalUsageRatio mismatch');
    assertEq(uint256(irData.baseDrawnRate), uint256(0), 'baseDrawnRate mismatch');
    assertEq(
      uint256(irData.rateGrowthBeforeOptimal),
      uint256(0),
      'rateGrowthBeforeOptimal mismatch'
    );
    assertEq(uint256(irData.rateGrowthAfterOptimal), uint256(0), 'rateGrowthAfterOptimal mismatch');
  }

  function test_tokenizationSpoke_PAXOS_HUB_USDG_proxyAdminOwner() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.PAXOS_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    address tokenizationSpoke = _findTokenizationSpoke(hub, assetId);
    address proxyAdmin = address(uint160(uint256(vm.load(tokenizationSpoke, ERC1967_ADMIN_SLOT))));
    assertEq(
      Ownable(proxyAdmin).owner(),
      proposal.SECURITY_COUNCIL_V4(),
      'proxyAdmin owner mismatch'
    );
  }

  function test_spokeReserveListing_MAPLE_SPOKE_USDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(proposal.MAPLE_SPOKE());
    IHub hub = IHub(address(AaveV4EthereumHubs.PAXOS_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
    assertEq(reserve.underlying, AaveV4EthereumAssets.USDG_UNDERLYING, 'underlying mismatch');
    assertEq(address(reserve.hub), address(hub), 'hub mismatch');
    assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
    assertEq(
      uint256(reserve.decimals),
      IERC20Metadata(AaveV4EthereumAssets.USDG_UNDERLYING).decimals(),
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

  function test_spokeReserveListing_MAPLE_SPOKE_SYRUPUSDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke spoke = ISpoke(proposal.MAPLE_SPOKE());
    IHub hub = IHub(address(AaveV4EthereumHubs.PAXOS_HUB));
    uint256 assetId = hub.getAssetId(proposal.SYRUPUSDG());
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
    assertEq(reserve.underlying, proposal.SYRUPUSDG(), 'underlying mismatch');
    assertEq(address(reserve.hub), address(hub), 'hub mismatch');
    assertEq(uint256(reserve.assetId), assetId, 'assetId mismatch');
    assertEq(
      uint256(reserve.decimals),
      IERC20Metadata(proposal.SYRUPUSDG()).decimals(),
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
    assertEq(uint256(dyn.collateralFactor), uint256(92_00), 'collateralFactor mismatch');
    assertEq(uint256(dyn.maxLiquidationBonus), uint256(104_00), 'maxLiquidationBonus mismatch');
    assertEq(uint256(dyn.liquidationFee), uint256(10_00), 'liquidationFee mismatch');
  }

  function test_spokeLiquidationConfigUpdate_MAPLE_SPOKE() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    ISpoke.LiquidationConfig memory cfg = ISpoke(proposal.MAPLE_SPOKE()).getLiquidationConfig();
    assertEq(
      uint256(cfg.targetHealthFactor),
      uint256(1_027_700_000_000_000_000),
      'targetHealthFactor mismatch'
    );
    assertEq(
      uint256(cfg.healthFactorForMaxBonus),
      uint256(990_000_000_000_000_000),
      'healthFactorForMaxBonus mismatch'
    );
    assertEq(
      uint256(cfg.liquidationBonusFactor),
      uint256(10_000),
      'liquidationBonusFactor mismatch'
    );
  }

  function test_hubSpokeToAssetsAddition_PAXOS_HUB_MAPLE_SPOKE_USDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.PAXOS_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    assertTrue(hub.isSpokeListed(assetId, proposal.MAPLE_SPOKE()), 'spoke not listed');
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, proposal.MAPLE_SPOKE());
    assertEq(uint256(cfg.addCap), uint256(10000000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(9500000), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(0), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_hubSpokeToAssetsAddition_PAXOS_HUB_MAPLE_SPOKE_SYRUPUSDG() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub hub = IHub(address(AaveV4EthereumHubs.PAXOS_HUB));
    uint256 assetId = hub.getAssetId(proposal.SYRUPUSDG());
    assertTrue(hub.isSpokeListed(assetId, proposal.MAPLE_SPOKE()), 'spoke not listed');
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, proposal.MAPLE_SPOKE());
    assertEq(uint256(cfg.addCap), uint256(10000000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(0), 'drawCap mismatch');
    assertEq(uint256(cfg.riskPremiumThreshold), uint256(0), 'riskPremiumThreshold mismatch');
    assertEq(cfg.active, true, 'active mismatch');
    assertEq(cfg.halted, false, 'halted mismatch');
  }

  function test_spokePositionManagerUpdate_MAPLE_SPOKE_GIVER_POSITION_MANAGER() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      ISpoke(proposal.MAPLE_SPOKE()).isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER)
      ),
      true,
      'positionManager active mismatch'
    );
  }

  function test_spokePositionManagerUpdate_MAPLE_SPOKE_TAKER_POSITION_MANAGER() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      ISpoke(proposal.MAPLE_SPOKE()).isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER)
      ),
      true,
      'positionManager active mismatch'
    );
  }

  function test_spokePositionManagerUpdate_MAPLE_SPOKE_CONFIG_POSITION_MANAGER() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      ISpoke(proposal.MAPLE_SPOKE()).isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER)
      ),
      true,
      'positionManager active mismatch'
    );
  }

  function test_spokePositionManagerUpdate_MAPLE_SPOKE_SIGNATURE_GATEWAY() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      ISpoke(proposal.MAPLE_SPOKE()).isPositionManagerActive(
        address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY)
      ),
      true,
      'positionManager active mismatch'
    );
  }

  /// @dev The TokenizationSpoke is the USDG spoke that is neither the fee receiver
  /// (registered at index 0 on listing) nor the Maple Spoke.
  function _findTokenizationSpoke(IHub hub, uint256 assetId) internal view returns (address) {
    uint256 count = hub.getSpokeCount(assetId);
    for (uint256 i; i < count; ++i) {
      address spoke = hub.getSpokeAddress(assetId, i);
      if (spoke != address(AaveV4Ethereum.TREASURY_SPOKE) && spoke != proposal.MAPLE_SPOKE()) {
        return spoke;
      }
    }
    revert('tokenization spoke not found');
  }
}
