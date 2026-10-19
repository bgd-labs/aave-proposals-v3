// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Avalanche, AaveV4AvalancheHubs, AaveV4AvalancheIRStrategies, AaveV4AvalancheAssets, AaveV4AvalanchePositionManagers, AaveV4AvalancheSpokePriceFeeds, AaveV4AvalancheSpokes} from 'aave-address-book/AaveV4Avalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4PayloadAvalanche} from 'aave-helpers/src/v4-config-engine/AaveV4PayloadAvalanche.sol';
import {IAaveV4ConfigEngine as IConfigEngine} from 'aave-address-book/AaveV4.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {V4EngineDefaults} from 'aave-helpers/src/v4-config-engine/V4EngineDefaults.sol';
import {V4RoleWiring} from 'aave-helpers/src/v4-config-engine/V4RoleWiring.sol';

/**
 * @title Onboard USDe to Aave V4 Core Instance on Avalanche
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-usde-to-aave-v4-core-instance-on-avalanche/25576
 */
contract AaveV4Avalanche_OnboardUSDeCoreHub_20261019 is AaveV4PayloadAvalanche {
  // https://snowscan.xyz/address/0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34
  address public constant USDE = 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34;

  // https://snowscan.xyz/address/0xaf22446124e566e54845f65b722E4dCbf12b650A
  address public constant ETHENA_ECOSYSTEM_SPOKE = 0xaf22446124e566e54845f65b722E4dCbf12b650A;

  // the executor needs the spoke configurator domain admin role to configure the new spoke
  function accessManagerRoleMemberships()
    public
    pure
    override
    returns (IConfigEngine.RoleMembership[] memory)
  {
    IConfigEngine.RoleMembership[] memory items = new IConfigEngine.RoleMembership[](1);
    items[0] = IConfigEngine.RoleMembership({
      authority: address(AaveV4Avalanche.ACCESS_MANAGER),
      roleId: Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      account: GovernanceV3Avalanche.EXECUTOR_LVL_1,
      granted: true,
      executionDelay: 0
    });
    return items;
  }

  function accessManagerTargetFunctionRoleUpdates()
    public
    pure
    override
    returns (IConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    return
      V4RoleWiring.spokeWiring(address(AaveV4Avalanche.ACCESS_MANAGER), ETHENA_ECOSYSTEM_SPOKE);
  }

  function hubAssetListings() public pure override returns (IConfigEngine.AssetListing[] memory) {
    IConfigEngine.AssetListing[] memory items = new IConfigEngine.AssetListing[](1);
    items[0] = IConfigEngine.AssetListing({
      hubConfigurator: AaveV4Avalanche.HUB_CONFIGURATOR,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: USDE,
      feeReceiver: address(AaveV4Avalanche.TREASURY_SPOKE),
      liquidityFee: 0,
      irStrategy: address(AaveV4AvalancheIRStrategies.CORE_USDt_IR_STRATEGY),
      irData: V4EngineDefaults.nonBorrowableIRData(),
      tokenization: V4EngineDefaults.noTokenization()
    });
    return items;
  }

  function spokeReserveListings()
    public
    pure
    override
    returns (IConfigEngine.ReserveListing[] memory)
  {
    IConfigEngine.ReserveListing[] memory items = new IConfigEngine.ReserveListing[](3);
    items[0] = IConfigEngine.ReserveListing({
      spokeConfigurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
      spoke: ETHENA_ECOSYSTEM_SPOKE,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: USDE,
      priceSource: AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDt_PRICE_FEED,
      config: ISpoke.ReserveConfig({
        collateralRisk: uint24(16_50),
        paused: false,
        frozen: false,
        borrowable: false,
        receiveSharesEnabled: true
      }),
      dynamicConfig: ISpoke.DynamicReserveConfig({
        collateralFactor: uint16(93_00),
        maxLiquidationBonus: uint32(102_00),
        liquidationFee: uint16(10_00)
      })
    });
    items[1] = IConfigEngine.ReserveListing({
      spokeConfigurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
      spoke: ETHENA_ECOSYSTEM_SPOKE,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: AaveV4AvalancheAssets.USDt_UNDERLYING,
      priceSource: AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDt_PRICE_FEED,
      config: ISpoke.ReserveConfig({
        collateralRisk: uint24(0),
        paused: false,
        frozen: false,
        borrowable: true,
        receiveSharesEnabled: true
      }),
      dynamicConfig: ISpoke.DynamicReserveConfig({
        collateralFactor: uint16(0),
        maxLiquidationBonus: uint32(100_00),
        liquidationFee: uint16(0)
      })
    });
    items[2] = IConfigEngine.ReserveListing({
      spokeConfigurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
      spoke: ETHENA_ECOSYSTEM_SPOKE,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: AaveV4AvalancheAssets.USDC_UNDERLYING,
      priceSource: AaveV4AvalancheSpokePriceFeeds.MAIN_SPOKE_USDC_PRICE_FEED,
      config: ISpoke.ReserveConfig({
        collateralRisk: uint24(0),
        paused: false,
        frozen: false,
        borrowable: true,
        receiveSharesEnabled: true
      }),
      dynamicConfig: ISpoke.DynamicReserveConfig({
        collateralFactor: uint16(0),
        maxLiquidationBonus: uint32(100_00),
        liquidationFee: uint16(0)
      })
    });
    return items;
  }

  function spokeLiquidationConfigUpdates()
    public
    pure
    override
    returns (IConfigEngine.LiquidationConfigUpdate[] memory)
  {
    IConfigEngine.LiquidationConfigUpdate[]
      memory items = new IConfigEngine.LiquidationConfigUpdate[](1);
    items[0] = IConfigEngine.LiquidationConfigUpdate({
      spokeConfigurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
      spoke: ETHENA_ECOSYSTEM_SPOKE,
      targetHealthFactor: 1.0277e18,
      healthFactorForMaxBonus: 0.99e18,
      liquidationBonusFactor: 100_00
    });
    return items;
  }

  function hubSpokeToAssetsAdditions()
    public
    pure
    override
    returns (IConfigEngine.SpokeToAssetsAddition[] memory)
  {
    IConfigEngine.SpokeToAssetsAddition[] memory items = new IConfigEngine.SpokeToAssetsAddition[](
      1
    );
    {
      IConfigEngine.SpokeAssetConfig[] memory subAssets = new IConfigEngine.SpokeAssetConfig[](3);
      subAssets[0] = IConfigEngine.SpokeAssetConfig({
        underlying: USDE,
        config: IHub.SpokeConfig({
          addCap: 60_000_000,
          drawCap: 0,
          riskPremiumThreshold: 0,
          active: true,
          halted: false
        })
      });
      subAssets[1] = IConfigEngine.SpokeAssetConfig({
        underlying: AaveV4AvalancheAssets.USDt_UNDERLYING,
        config: IHub.SpokeConfig({
          addCap: 0,
          drawCap: 50_000_000,
          riskPremiumThreshold: 1_100_00,
          active: true,
          halted: false
        })
      });
      subAssets[2] = IConfigEngine.SpokeAssetConfig({
        underlying: AaveV4AvalancheAssets.USDC_UNDERLYING,
        config: IHub.SpokeConfig({
          addCap: 0,
          drawCap: 3_000_000,
          riskPremiumThreshold: 1_100_00,
          active: true,
          halted: false
        })
      });
      items[0] = IConfigEngine.SpokeToAssetsAddition({
        hubConfigurator: AaveV4Avalanche.HUB_CONFIGURATOR,
        hub: address(AaveV4AvalancheHubs.CORE_HUB),
        spoke: ETHENA_ECOSYSTEM_SPOKE,
        assets: subAssets
      });
    }
    return items;
  }

  function spokePositionManagerUpdates()
    public
    pure
    override
    returns (IConfigEngine.PositionManagerUpdate[] memory)
  {
    IConfigEngine.PositionManagerUpdate[] memory items = new IConfigEngine.PositionManagerUpdate[](
      4
    );
    items[0] = IConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
      spoke: ETHENA_ECOSYSTEM_SPOKE,
      positionManager: address(AaveV4AvalanchePositionManagers.GIVER_POSITION_MANAGER),
      active: true
    });
    items[1] = IConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
      spoke: ETHENA_ECOSYSTEM_SPOKE,
      positionManager: address(AaveV4AvalanchePositionManagers.TAKER_POSITION_MANAGER),
      active: true
    });
    items[2] = IConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
      spoke: ETHENA_ECOSYSTEM_SPOKE,
      positionManager: address(AaveV4AvalanchePositionManagers.CONFIG_POSITION_MANAGER),
      active: true
    });
    items[3] = IConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Avalanche.SPOKE_CONFIGURATOR,
      spoke: ETHENA_ECOSYSTEM_SPOKE,
      positionManager: address(AaveV4AvalanchePositionManagers.SIGNATURE_GATEWAY),
      active: true
    });
    return items;
  }

  function hubAssetConfigUpdates()
    public
    pure
    override
    returns (IConfigEngine.AssetConfigUpdate[] memory)
  {
    IConfigEngine.AssetConfigUpdate[] memory items = new IConfigEngine.AssetConfigUpdate[](2);
    items[0] = IConfigEngine.AssetConfigUpdate({
      hubConfigurator: AaveV4Avalanche.HUB_CONFIGURATOR,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: AaveV4AvalancheAssets.USDt_UNDERLYING,
      liquidityFee: EngineFlags.KEEP_CURRENT,
      feeReceiver: EngineFlags.KEEP_CURRENT_ADDRESS,
      irStrategy: EngineFlags.KEEP_CURRENT_ADDRESS,
      irData: IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: uint16(94_00),
        baseDrawnRate: EngineFlags.KEEP_CURRENT_UINT32,
        rateGrowthBeforeOptimal: uint32(4_90),
        rateGrowthAfterOptimal: uint32(20_00)
      }),
      reinvestmentController: EngineFlags.KEEP_CURRENT_ADDRESS
    });
    items[1] = IConfigEngine.AssetConfigUpdate({
      hubConfigurator: AaveV4Avalanche.HUB_CONFIGURATOR,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: AaveV4AvalancheAssets.USDC_UNDERLYING,
      liquidityFee: EngineFlags.KEEP_CURRENT,
      feeReceiver: EngineFlags.KEEP_CURRENT_ADDRESS,
      irStrategy: EngineFlags.KEEP_CURRENT_ADDRESS,
      irData: IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT_UINT16,
        baseDrawnRate: EngineFlags.KEEP_CURRENT_UINT32,
        rateGrowthBeforeOptimal: uint32(4_50),
        rateGrowthAfterOptimal: uint32(20_00)
      }),
      reinvestmentController: EngineFlags.KEEP_CURRENT_ADDRESS
    });
    return items;
  }

  function hubSpokeConfigUpdates()
    public
    pure
    override
    returns (IConfigEngine.SpokeConfigUpdate[] memory)
  {
    IConfigEngine.SpokeConfigUpdate[] memory items = new IConfigEngine.SpokeConfigUpdate[](1);
    items[0] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Avalanche.HUB_CONFIGURATOR,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: AaveV4AvalancheAssets.USDt_UNDERLYING,
      spoke: address(AaveV4AvalancheSpokes.MAIN_SPOKE),
      addCap: 60_000_000,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    return items;
  }
}
