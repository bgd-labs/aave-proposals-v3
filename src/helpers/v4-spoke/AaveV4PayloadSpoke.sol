// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {IHubConfigurator} from 'aave-v4/hub/interfaces/IHubConfigurator.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {ISpokeConfigurator} from 'aave-v4/spoke/interfaces/ISpokeConfigurator.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Payload} from 'aave-v4/config-engine/AaveV4Payload.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';

import {RoleUpdatesLib} from '../v4-config-engine/RoleUpdatesLib.sol';
import {AaveV4PayloadHub} from '../v4-hub/AaveV4PayloadHub.sol';

/// @dev Network-agnostic base payload for configuring a Spoke through the V4 config engine:
///      registering the Spoke on Hub assets (cross-hub credit lines included), listing its
///      reserves, liquidation config and position managers, plus the AccessManager wiring for a
///      freshly-deployed Spoke.
///
///      Extends {AaveV4PayloadHub}: a Spoke onboarding may also bring a new Hub online, and sharing
///      the hub base lets a combined payload reuse one inheritance chain (no per-payload
///      disambiguation) and merge the hub + spoke AccessManager wiring in one place. A spoke-only
///      payload simply returns empty `newHubs()` / `_hubAssetListings()`.
///
///      Network-specific addresses are supplied by a per-network subclass (see
///      {AaveV4PayloadEthereumSpoke}).
abstract contract AaveV4PayloadSpoke is AaveV4PayloadHub {
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
    IHubConfigurator hubConfigurator = _hubConfigurator();

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
        hubConfigurator: hubConfigurator,
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
    ISpokeConfigurator spokeConfigurator = _spokeConfigurator();
    IAaveV4ConfigEngine.ReserveListing[] memory listings = new IAaveV4ConfigEngine.ReserveListing[](
      entries.length
    );
    for (uint256 i; i < entries.length; ++i) {
      listings[i] = IAaveV4ConfigEngine.ReserveListing({
        spokeConfigurator: spokeConfigurator,
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
      spokeConfigurator: _spokeConfigurator(),
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
    ISpokeConfigurator spokeConfigurator = _spokeConfigurator();
    address[] memory positionManagers = _positionManagers();
    IAaveV4ConfigEngine.PositionManagerUpdate[]
      memory updates = new IAaveV4ConfigEngine.PositionManagerUpdate[](positionManagers.length);
    for (uint256 i; i < positionManagers.length; ++i) {
      updates[i] = IAaveV4ConfigEngine.PositionManagerUpdate({
        spokeConfigurator: spokeConfigurator,
        spoke: spokeAddress,
        positionManager: positionManagers[i],
        active: true
      });
    }
    return updates;
  }

  /// @dev Merges the Hub-role wiring (inherited) with the Spoke-role wiring into the single array
  ///      the engine consumes. With an empty `newHubs()` the hub part is empty (spoke-only payload).
  function accessManagerTargetFunctionRoleUpdates()
    public
    view
    virtual
    override
    returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    return RoleUpdatesLib.merge(_hubTargetFunctionRoleUpdates(), _spokeTargetFunctionRoleUpdates());
  }

  /// @dev Maps the new Spoke's gated selectors to the Spoke roles on the shared AccessManager,
  ///      mirroring `AaveV4SpokeRolesProcedure`. Selector sets come from `Roles`, the deployment's
  ///      source of truth.
  function _spokeTargetFunctionRoleUpdates()
    internal
    view
    returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    address spokeAddress = spoke();
    address accessManager = _accessManager();
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[]
      memory updates = new IAaveV4ConfigEngine.TargetFunctionRoleUpdate[](2);
    updates[0] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
      authority: accessManager,
      target: spokeAddress,
      selectors: Roles.getSpokeConfiguratorRoleSelectors(),
      roleId: Roles.SPOKE_CONFIGURATOR_ROLE
    });
    updates[1] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
      authority: accessManager,
      target: spokeAddress,
      selectors: Roles.getSpokePositionUpdaterRoleSelectors(),
      roleId: Roles.SPOKE_USER_POSITION_UPDATER_ROLE
    });
    return updates;
  }

  function _spokeAssetConfigs() internal view virtual returns (SpokeAssetConfig[] memory);

  function _spokeReserves() internal view virtual returns (ReserveListing[] memory);

  function _spokeLiquidation() internal view virtual returns (LiquidationConfigUpdate memory);

  function _spokeConfigurator() internal pure virtual returns (ISpokeConfigurator);

  /// @dev Position managers to activate on the new Spoke.
  function _positionManagers() internal pure virtual returns (address[] memory);
}

/// @dev Ethereum binding of {AaveV4PayloadSpoke}: supplies the config engine and the network
///      getters. A combined hub + spoke payload inherits only this contract — a single inheritance
///      chain (AaveV4Payload <- Hub <- Spoke <- here), so it needs no override disambiguation. This
///      is a standalone leaf (not inheriting {AaveV4PayloadEthereumHub}); inheriting it would create
///      a diamond on AaveV4Payload and reintroduce the forwarding overrides we are avoiding, so the
///      handful of network getters are restated here.
abstract contract AaveV4PayloadEthereumSpoke is AaveV4PayloadSpoke {
  constructor() AaveV4Payload(AaveV4Ethereum.CONFIG_ENGINE) {}

  function _hubName(IHub hub) internal pure virtual override returns (string memory) {
    if (hub == AaveV4EthereumHubs.CORE_HUB) return 'Core';
    if (hub == AaveV4EthereumHubs.PLUS_HUB) return 'Plus';
    if (hub == AaveV4EthereumHubs.PRIME_HUB) return 'Prime';
    revert('AaveV4PayloadEthereumSpoke: unknown hub');
  }

  function _hubConfigurator() internal pure override returns (IHubConfigurator) {
    return AaveV4Ethereum.HUB_CONFIGURATOR;
  }

  function _feeReceiver() internal pure override returns (address) {
    return address(AaveV4Ethereum.TREASURY_SPOKE);
  }

  function _accessManager() internal pure override returns (address) {
    return address(AaveV4Ethereum.ACCESS_MANAGER);
  }

  function _spokeConfigurator() internal pure override returns (ISpokeConfigurator) {
    return AaveV4Ethereum.SPOKE_CONFIGURATOR;
  }

  function _positionManagers() internal pure override returns (address[] memory) {
    address[] memory positionManagers = new address[](4);
    positionManagers[0] = address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER);
    positionManagers[1] = address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER);
    positionManagers[2] = address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER);
    positionManagers[3] = address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY);
    return positionManagers;
  }
}
