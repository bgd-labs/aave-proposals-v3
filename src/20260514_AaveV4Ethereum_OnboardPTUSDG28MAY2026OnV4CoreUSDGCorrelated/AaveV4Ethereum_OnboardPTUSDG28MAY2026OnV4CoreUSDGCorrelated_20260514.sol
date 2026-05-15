// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumSpokePriceFeeds, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {AaveV4PayloadEthereum} from './dependencies/AaveV4PayloadEthereum.sol';

/**
 * @title Onboard PT-USDG-28MAY2026 on V4 Core / USDG Correlated
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: todo-forum-post
 */
contract AaveV4Ethereum_OnboardPTUSDG28MAY2026OnV4CoreUSDGCorrelated_20260514 is
  AaveV4PayloadEthereum
{
  // https://etherscan.io/address/0x956d8e0A89cfa3744428C4641b5a53B56167a7f9
  ISpoke internal constant USDG_CORRELATED_SPOKE =
    ISpoke(0x956d8e0A89cfa3744428C4641b5a53B56167a7f9);

  // PT-USDG-28MAY2026 is not yet in the V4 address book; reusing the V3 addresses.
  address internal constant PT_USDG_28MAY2026_UNDERLYING =
    AaveV3EthereumAssets.PT_USDG_28MAY2026_UNDERLYING;
  address internal constant PT_USDG_28MAY2026_PRICE_FEED =
    AaveV3EthereumAssets.PT_USDG_28MAY2026_ORACLE;

  // Same IR strategy already used by every other asset on CORE_HUB.
  // https://etherscan.io/address/0xAD88791B0F81D1FA242f637eB05bee0cbc53fe2f
  address internal constant CORE_HUB_IR_STRATEGY = 0xAD88791B0F81D1FA242f637eB05bee0cbc53fe2f;

  uint256 internal constant PT_USDG_28MAY2026_SUPPLY_CAP = 2_000_000;
  uint256 internal constant USDG_BORROW_CAP = 1_000_000;
  uint256 internal constant RISK_PREMIUM_THRESHOLD = 0;

  uint256 internal constant PT_USDG_28MAY2026_LIQUIDITY_FEE = 0;
  uint16 internal constant PT_USDG_28MAY2026_OPTIMAL_USAGE_RATIO = 99_00;
  uint32 internal constant PT_USDG_28MAY2026_BASE_DRAWN_RATE = 0;
  uint32 internal constant PT_USDG_28MAY2026_RATE_GROWTH_BEFORE_OPTIMAL = 0;
  uint32 internal constant PT_USDG_28MAY2026_RATE_GROWTH_AFTER_OPTIMAL = 0;

  // TODO: replace before deploying — TokenizationSpoke add cap is not finalized yet.
  uint256 public constant TOKENIZATION_SPOKE_ADD_CAP = 0;
  string public constant TOKENIZATION_SPOKE_NAME = 'Wrapped Aave Core PT_USDG_28MAY2026';
  string public constant TOKENIZATION_SPOKE_SYMBOL = 'waCorePT_USDG_28MAY2026';

  uint24 internal constant RESERVE_COLLATERAL_RISK = 0;

  uint16 internal constant PT_USDG_28MAY2026_COLLATERAL_FACTOR = 95_00;
  uint32 internal constant PT_USDG_28MAY2026_MAX_LIQUIDATION_BONUS = 102_00;
  uint16 internal constant PT_USDG_28MAY2026_LIQUIDATION_FEE = 10_00;

  uint16 internal constant USDG_COLLATERAL_FACTOR = 0;
  uint32 internal constant USDG_MAX_LIQUIDATION_BONUS = 100_00;
  uint16 internal constant USDG_LIQUIDATION_FEE = 0;

  uint128 internal constant LIQUIDATION_TARGET_HEALTH_FACTOR = 1.02e18;
  uint64 internal constant LIQUIDATION_HEALTH_FACTOR_FOR_MAX_BONUS = 0.99e18;
  uint16 internal constant LIQUIDATION_BONUS_FACTOR = 100_00;

  function accessManagerTargetFunctionRoleUpdates()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    bytes4[] memory configuratorSelectors = new bytes4[](7);
    configuratorSelectors[0] = ISpoke.addDynamicReserveConfig.selector;
    configuratorSelectors[1] = ISpoke.addReserve.selector;
    configuratorSelectors[2] = ISpoke.updateDynamicReserveConfig.selector;
    configuratorSelectors[3] = ISpoke.updateLiquidationConfig.selector;
    configuratorSelectors[4] = ISpoke.updatePositionManager.selector;
    configuratorSelectors[5] = ISpoke.updateReserveConfig.selector;
    configuratorSelectors[6] = ISpoke.updateReservePriceSource.selector;

    bytes4[] memory updaterSelectors = new bytes4[](2);
    updaterSelectors[0] = ISpoke.updateUserDynamicConfig.selector;
    updaterSelectors[1] = ISpoke.updateUserRiskPremium.selector;

    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[]
      memory updates = new IAaveV4ConfigEngine.TargetFunctionRoleUpdate[](2);
    updates[0] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
      authority: address(AaveV4Ethereum.ACCESS_MANAGER),
      target: address(USDG_CORRELATED_SPOKE),
      selectors: configuratorSelectors,
      roleId: Roles.SPOKE_CONFIGURATOR_ROLE
    });
    updates[1] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
      authority: address(AaveV4Ethereum.ACCESS_MANAGER),
      target: address(USDG_CORRELATED_SPOKE),
      selectors: updaterSelectors,
      roleId: Roles.SPOKE_USER_POSITION_UPDATER_ROLE
    });
    return updates;
  }

  function hubAssetListings()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.AssetListing[] memory)
  {
    IAaveV4ConfigEngine.AssetListing[] memory listings = new IAaveV4ConfigEngine.AssetListing[](1);
    listings[0] = IAaveV4ConfigEngine.AssetListing({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: PT_USDG_28MAY2026_UNDERLYING,
      feeReceiver: address(AaveV4Ethereum.TREASURY_SPOKE),
      liquidityFee: PT_USDG_28MAY2026_LIQUIDITY_FEE,
      irStrategy: CORE_HUB_IR_STRATEGY,
      irData: IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: PT_USDG_28MAY2026_OPTIMAL_USAGE_RATIO,
        baseDrawnRate: PT_USDG_28MAY2026_BASE_DRAWN_RATE,
        rateGrowthBeforeOptimal: PT_USDG_28MAY2026_RATE_GROWTH_BEFORE_OPTIMAL,
        rateGrowthAfterOptimal: PT_USDG_28MAY2026_RATE_GROWTH_AFTER_OPTIMAL
      }),
      tokenization: IAaveV4ConfigEngine.TokenizationSpokeConfig({
        addCap: TOKENIZATION_SPOKE_ADD_CAP,
        name: TOKENIZATION_SPOKE_NAME,
        symbol: TOKENIZATION_SPOKE_SYMBOL
      })
    });
    return listings;
  }

  function hubSpokeToAssetsAdditions()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.SpokeToAssetsAddition[] memory)
  {
    IAaveV4ConfigEngine.SpokeAssetConfig[]
      memory coreAssets = new IAaveV4ConfigEngine.SpokeAssetConfig[](2);
    coreAssets[0] = IAaveV4ConfigEngine.SpokeAssetConfig({
      underlying: PT_USDG_28MAY2026_UNDERLYING,
      config: IHub.SpokeConfig({
        addCap: uint40(PT_USDG_28MAY2026_SUPPLY_CAP),
        drawCap: 0,
        riskPremiumThreshold: uint24(RISK_PREMIUM_THRESHOLD),
        active: true,
        halted: false
      })
    });
    coreAssets[1] = IAaveV4ConfigEngine.SpokeAssetConfig({
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      config: IHub.SpokeConfig({
        addCap: 0,
        drawCap: uint40(USDG_BORROW_CAP),
        riskPremiumThreshold: uint24(RISK_PREMIUM_THRESHOLD),
        active: true,
        halted: false
      })
    });

    IAaveV4ConfigEngine.SpokeToAssetsAddition[]
      memory additions = new IAaveV4ConfigEngine.SpokeToAssetsAddition[](1);
    additions[0] = IAaveV4ConfigEngine.SpokeToAssetsAddition({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      spoke: address(USDG_CORRELATED_SPOKE),
      assets: coreAssets
    });
    return additions;
  }

  function spokeReserveListings()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.ReserveListing[] memory)
  {
    IAaveV4ConfigEngine.ReserveListing[] memory listings = new IAaveV4ConfigEngine.ReserveListing[](
      2
    );

    listings[0] = IAaveV4ConfigEngine.ReserveListing({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: address(USDG_CORRELATED_SPOKE),
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: PT_USDG_28MAY2026_UNDERLYING,
      priceSource: PT_USDG_28MAY2026_PRICE_FEED,
      config: ISpoke.ReserveConfig({
        collateralRisk: RESERVE_COLLATERAL_RISK,
        paused: false,
        frozen: false,
        borrowable: false,
        receiveSharesEnabled: true
      }),
      dynamicConfig: ISpoke.DynamicReserveConfig({
        collateralFactor: PT_USDG_28MAY2026_COLLATERAL_FACTOR,
        maxLiquidationBonus: PT_USDG_28MAY2026_MAX_LIQUIDATION_BONUS,
        liquidationFee: PT_USDG_28MAY2026_LIQUIDATION_FEE
      })
    });

    listings[1] = IAaveV4ConfigEngine.ReserveListing({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: address(USDG_CORRELATED_SPOKE),
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      priceSource: AaveV4EthereumSpokePriceFeeds.MAIN_USDG_PRICE_FEED,
      config: ISpoke.ReserveConfig({
        collateralRisk: RESERVE_COLLATERAL_RISK,
        paused: false,
        frozen: false,
        borrowable: true,
        receiveSharesEnabled: false
      }),
      dynamicConfig: ISpoke.DynamicReserveConfig({
        collateralFactor: USDG_COLLATERAL_FACTOR,
        maxLiquidationBonus: USDG_MAX_LIQUIDATION_BONUS,
        liquidationFee: USDG_LIQUIDATION_FEE
      })
    });
    return listings;
  }

  function spokeLiquidationConfigUpdates()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.LiquidationConfigUpdate[] memory)
  {
    IAaveV4ConfigEngine.LiquidationConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.LiquidationConfigUpdate[](1);
    updates[0] = IAaveV4ConfigEngine.LiquidationConfigUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: address(USDG_CORRELATED_SPOKE),
      targetHealthFactor: LIQUIDATION_TARGET_HEALTH_FACTOR,
      healthFactorForMaxBonus: LIQUIDATION_HEALTH_FACTOR_FOR_MAX_BONUS,
      liquidationBonusFactor: LIQUIDATION_BONUS_FACTOR
    });
    return updates;
  }

  function spokePositionManagerUpdates()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.PositionManagerUpdate[] memory)
  {
    IAaveV4ConfigEngine.PositionManagerUpdate[]
      memory updates = new IAaveV4ConfigEngine.PositionManagerUpdate[](4);
    updates[0] = IAaveV4ConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: address(USDG_CORRELATED_SPOKE),
      positionManager: address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      active: true
    });
    updates[1] = IAaveV4ConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: address(USDG_CORRELATED_SPOKE),
      positionManager: address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER),
      active: true
    });
    updates[2] = IAaveV4ConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: address(USDG_CORRELATED_SPOKE),
      positionManager: address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER),
      active: true
    });
    updates[3] = IAaveV4ConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: address(USDG_CORRELATED_SPOKE),
      positionManager: address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY),
      active: true
    });
    return updates;
  }

  function _preExecute() internal override {
    AaveV4Ethereum.ACCESS_MANAGER.grantRole({
      roleId: Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      account: address(this),
      executionDelay: 0
    });
  }
}
