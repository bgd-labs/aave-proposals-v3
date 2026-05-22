// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';
import {AaveV4PayloadEthereum} from 'aave-helpers/src/v4-config-engine/AaveV4PayloadEthereum.sol';

abstract contract AaveV4PayloadEthereumSpoke is AaveV4PayloadEthereum {
  struct HubAssetListing {
    IHub hub;
    address underlying;
    uint256 liquidityFee;
    address irStrategy;
    IAssetInterestRateStrategy.InterestRateData irData;
    IAaveV4ConfigEngine.TokenizationSpokeConfig tokenization;
  }

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

  function hubAssetListings()
    public
    view
    override
    returns (IAaveV4ConfigEngine.AssetListing[] memory)
  {
    HubAssetListing[] memory entries = _hubAssetListings();
    IAaveV4ConfigEngine.AssetListing[] memory listings = new IAaveV4ConfigEngine.AssetListing[](
      entries.length
    );
    for (uint256 i; i < entries.length; ++i) {
      listings[i] = IAaveV4ConfigEngine.AssetListing({
        hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
        hub: address(entries[i].hub),
        underlying: entries[i].underlying,
        feeReceiver: address(AaveV4Ethereum.TREASURY_SPOKE),
        liquidityFee: entries[i].liquidityFee,
        irStrategy: entries[i].irStrategy,
        irData: entries[i].irData,
        tokenization: entries[i].tokenization
      });
    }
    return listings;
  }

  function hubSpokeToAssetsAdditions()
    public
    view
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
    override
    returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    bytes4[] memory configuratorSelectors = spokeConfiguratorSelectors();
    bytes4[] memory updaterSelectors = spokeUserPositionUpdaterSelectors();

    uint256 updateCount;
    if (configuratorSelectors.length > 0) ++updateCount;
    if (updaterSelectors.length > 0) ++updateCount;

    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[]
      memory updates = new IAaveV4ConfigEngine.TargetFunctionRoleUpdate[](updateCount);
    address spokeAddress = spoke();
    uint256 updateIndex;
    if (configuratorSelectors.length > 0) {
      updates[updateIndex++] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
        authority: address(AaveV4Ethereum.ACCESS_MANAGER),
        target: spokeAddress,
        selectors: configuratorSelectors,
        roleId: Roles.SPOKE_CONFIGURATOR_ROLE
      });
    }
    if (updaterSelectors.length > 0) {
      updates[updateIndex++] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
        authority: address(AaveV4Ethereum.ACCESS_MANAGER),
        target: spokeAddress,
        selectors: updaterSelectors,
        roleId: Roles.SPOKE_USER_POSITION_UPDATER_ROLE
      });
    }
    return updates;
  }

  /// @dev Source of truth: functions on `Spoke.sol` carrying the `restricted` modifier. The
  ///      companion assumption test pins the full ABI hash; keep this in sync on aave-v4 bumps.
  function spokeConfiguratorSelectors() public pure virtual returns (bytes4[] memory) {
    bytes4[] memory selectors = new bytes4[](7);
    selectors[0] = ISpoke.addDynamicReserveConfig.selector;
    selectors[1] = ISpoke.addReserve.selector;
    selectors[2] = ISpoke.updateDynamicReserveConfig.selector;
    selectors[3] = ISpoke.updateLiquidationConfig.selector;
    selectors[4] = ISpoke.updatePositionManager.selector;
    selectors[5] = ISpoke.updateReserveConfig.selector;
    selectors[6] = ISpoke.updateReservePriceSource.selector;
    return selectors;
  }

  /// @dev These functions are not `restricted` on Spoke.sol; they call `_checkCanCall` inline
  ///      when the caller isn't an active position manager for `onBehalfOf`.
  function spokeUserPositionUpdaterSelectors() public pure virtual returns (bytes4[] memory) {
    bytes4[] memory selectors = new bytes4[](2);
    selectors[0] = ISpoke.updateUserDynamicConfig.selector;
    selectors[1] = ISpoke.updateUserRiskPremium.selector;
    return selectors;
  }

  function _hubAssetListings() internal view virtual returns (HubAssetListing[] memory);

  function _spokeAssetConfigs() internal view virtual returns (SpokeAssetConfig[] memory);

  function _spokeReserves() internal view virtual returns (ReserveListing[] memory);

  function _spokeLiquidation() internal view virtual returns (LiquidationConfigUpdate memory);

  function _hubName(IHub hub) internal pure returns (string memory) {
    if (hub == AaveV4EthereumHubs.CORE_HUB) return 'Core';
    if (hub == AaveV4EthereumHubs.PLUS_HUB) return 'Plus';
    if (hub == AaveV4EthereumHubs.PRIME_HUB) return 'Prime';
    revert('AaveV4PayloadEthereumSpoke: unknown hub');
  }

  function _tokenizationName(
    IHub hub,
    string memory tokenName
  ) internal pure returns (string memory) {
    return string.concat('Wrapped Aave ', _hubName(hub), ' ', tokenName);
  }

  function _tokenizationSymbol(
    IHub hub,
    string memory tokenName
  ) internal pure returns (string memory) {
    return string.concat('wa', _hubName(hub), tokenName);
  }

  function _tokenization(
    IHub hub,
    string memory tokenName,
    uint256 addCap
  ) internal pure returns (IAaveV4ConfigEngine.TokenizationSpokeConfig memory) {
    return
      IAaveV4ConfigEngine.TokenizationSpokeConfig({
        addCap: addCap,
        name: _tokenizationName(hub, tokenName),
        symbol: _tokenizationSymbol(hub, tokenName)
      });
  }

  /// @dev IR data preset for collateral-only assets that should never accrue borrow interest.
  function _nonBorrowableIRData()
    internal
    pure
    returns (IAssetInterestRateStrategy.InterestRateData memory)
  {
    return
      IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: 99_00,
        baseDrawnRate: 0,
        rateGrowthBeforeOptimal: 0,
        rateGrowthAfterOptimal: 0
      });
  }
}
