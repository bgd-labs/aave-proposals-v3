// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';
import {AaveV4PayloadEthereum} from 'aave-helpers/src/v4-config-engine/AaveV4PayloadEthereum.sol';

/// @dev Base payload for configuring a Spoke through the V4 config engine: registering the Spoke
///      on Hub assets (cross-hub credit lines included), listing its reserves, liquidation config
///      and position managers, plus the AccessManager wiring for a freshly-deployed Spoke.
///
///      Independent from `AaveV4PayloadEthereumHub`; a payload that also configures Hubs inherits
///      both and merges their `accessManagerTargetFunctionRoleUpdates()`.
abstract contract AaveV4PayloadEthereumSpoke is AaveV4PayloadEthereum {
  struct SpokeAssetConfig {
    IHub hub;
    address underlying;
    uint40 addCap;
    uint40 drawCap;
    uint24 riskPremiumThreshold;
  }

  struct ReserveListing {
    IHub hub;
    address underlying;
    address priceSource;
    uint24 collateralRisk;
    bool borrowable;
    bool receiveSharesEnabled;
    uint16 collateralFactor;
    uint32 maxLiquidationBonus;
    uint16 liquidationFee;
  }

  struct LiquidationConfigUpdate {
    uint256 targetHealthFactor;
    uint256 healthFactorForMaxBonus;
    uint256 liquidationBonusFactor;
  }

  function spoke() public view virtual returns (address);

  function hubSpokeToAssetsAdditions()
    public
    view
    virtual
    override
    returns (IAaveV4ConfigEngine.SpokeToAssetsAddition[] memory)
  {
    SpokeAssetConfig[] memory entries = _spokeAssetConfigs();
    if (entries.length == 0) {
      return new IAaveV4ConfigEngine.SpokeToAssetsAddition[](0);
    }

    address spokeAddress = spoke();

    IHub[] memory uniqueHubs = new IHub[](entries.length);
    uint256 uniqueHubCount;
    for (uint256 i; i < entries.length; ++i) {
      bool seen;
      for (uint256 j; j < uniqueHubCount; ++j) {
        if (uniqueHubs[j] == entries[i].hub) {
          seen = true;
          break;
        }
      }
      if (!seen) {
        uniqueHubs[uniqueHubCount++] = entries[i].hub;
      }
    }

    IAaveV4ConfigEngine.SpokeToAssetsAddition[]
      memory additions = new IAaveV4ConfigEngine.SpokeToAssetsAddition[](uniqueHubCount);
    for (uint256 hubIndex; hubIndex < uniqueHubCount; ++hubIndex) {
      IHub currentHub = uniqueHubs[hubIndex];
      uint256 entriesForHub;
      for (uint256 i; i < entries.length; ++i) {
        if (entries[i].hub == currentHub) ++entriesForHub;
      }
      IAaveV4ConfigEngine.SpokeAssetConfig[]
        memory assets = new IAaveV4ConfigEngine.SpokeAssetConfig[](entriesForHub);
      uint256 assetIndex;
      for (uint256 i; i < entries.length; ++i) {
        if (entries[i].hub == currentHub) {
          assets[assetIndex++] = IAaveV4ConfigEngine.SpokeAssetConfig({
            underlying: entries[i].underlying,
            config: IHub.SpokeConfig({
              addCap: entries[i].addCap,
              drawCap: entries[i].drawCap,
              riskPremiumThreshold: entries[i].riskPremiumThreshold,
              active: true,
              halted: false
            })
          });
        }
      }
      additions[hubIndex] = IAaveV4ConfigEngine.SpokeToAssetsAddition({
        hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
        hub: address(currentHub),
        spoke: spokeAddress,
        assets: assets
      });
    }
    return additions;
  }

  function spokeReserveListings()
    public
    view
    virtual
    override
    returns (IAaveV4ConfigEngine.ReserveListing[] memory)
  {
    ReserveListing[] memory entries = _spokeReserves();
    address spokeAddress = spoke();
    IAaveV4ConfigEngine.ReserveListing[] memory listings = new IAaveV4ConfigEngine.ReserveListing[](
      entries.length
    );
    for (uint256 i; i < entries.length; ++i) {
      listings[i] = IAaveV4ConfigEngine.ReserveListing({
        spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
        spoke: spokeAddress,
        hub: address(entries[i].hub),
        underlying: entries[i].underlying,
        priceSource: entries[i].priceSource,
        config: ISpoke.ReserveConfig({
          collateralRisk: entries[i].collateralRisk,
          paused: false,
          frozen: false,
          borrowable: entries[i].borrowable,
          receiveSharesEnabled: entries[i].receiveSharesEnabled
        }),
        dynamicConfig: ISpoke.DynamicReserveConfig({
          collateralFactor: entries[i].collateralFactor,
          maxLiquidationBonus: entries[i].maxLiquidationBonus,
          liquidationFee: entries[i].liquidationFee
        })
      });
    }
    return listings;
  }

  function spokeLiquidationConfigUpdates()
    public
    view
    virtual
    override
    returns (IAaveV4ConfigEngine.LiquidationConfigUpdate[] memory)
  {
    LiquidationConfigUpdate memory liquidation = _spokeLiquidation();
    IAaveV4ConfigEngine.LiquidationConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.LiquidationConfigUpdate[](1);
    updates[0] = IAaveV4ConfigEngine.LiquidationConfigUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: spoke(),
      targetHealthFactor: liquidation.targetHealthFactor,
      healthFactorForMaxBonus: liquidation.healthFactorForMaxBonus,
      liquidationBonusFactor: liquidation.liquidationBonusFactor
    });
    return updates;
  }

  function spokePositionManagerUpdates()
    public
    view
    virtual
    override
    returns (IAaveV4ConfigEngine.PositionManagerUpdate[] memory)
  {
    address spokeAddress = spoke();
    IAaveV4ConfigEngine.PositionManagerUpdate[]
      memory updates = new IAaveV4ConfigEngine.PositionManagerUpdate[](4);
    updates[0] = IAaveV4ConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: spokeAddress,
      positionManager: address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      active: true
    });
    updates[1] = IAaveV4ConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: spokeAddress,
      positionManager: address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER),
      active: true
    });
    updates[2] = IAaveV4ConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: spokeAddress,
      positionManager: address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER),
      active: true
    });
    updates[3] = IAaveV4ConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: spokeAddress,
      positionManager: address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY),
      active: true
    });
    return updates;
  }

  function accessManagerTargetFunctionRoleUpdates()
    public
    view
    virtual
    override
    returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    return _spokeTargetFunctionRoleUpdates();
  }

  /// @dev Maps the new Spoke's gated selectors to the Spoke roles on the shared AccessManager,
  ///      mirroring `AaveV4SpokeRolesProcedure`. Selector sets come from `Roles`, the deployment's
  ///      source of truth, exactly as the Hub-role wiring sources them.
  function _spokeTargetFunctionRoleUpdates()
    internal
    view
    returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    address spokeAddress = spoke();
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[]
      memory updates = new IAaveV4ConfigEngine.TargetFunctionRoleUpdate[](2);
    updates[0] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
      authority: address(AaveV4Ethereum.ACCESS_MANAGER),
      target: spokeAddress,
      selectors: Roles.getSpokeConfiguratorRoleSelectors(),
      roleId: Roles.SPOKE_CONFIGURATOR_ROLE
    });
    updates[1] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
      authority: address(AaveV4Ethereum.ACCESS_MANAGER),
      target: spokeAddress,
      selectors: Roles.getSpokePositionUpdaterRoleSelectors(),
      roleId: Roles.SPOKE_USER_POSITION_UPDATER_ROLE
    });
    return updates;
  }

  function _spokeAssetConfigs() internal view virtual returns (SpokeAssetConfig[] memory);

  function _spokeReserves() internal view virtual returns (ReserveListing[] memory);

  function _spokeLiquidation() internal view virtual returns (LiquidationConfigUpdate memory);
}
