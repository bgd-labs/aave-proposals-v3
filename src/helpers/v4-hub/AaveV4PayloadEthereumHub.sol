// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs} from 'aave-address-book/AaveV4Ethereum.sol';
import {AaveV4PayloadEthereum} from 'aave-helpers/src/v4-config-engine/AaveV4PayloadEthereum.sol';

/// @dev Base payload for configuring Liquidity Hubs through the V4 config engine, including
///      bringing a freshly-deployed Hub online. A new Hub ships with its restricted functions
///      ungated on the shared AccessManager: the configurator domain roles are already held by
///      their holders, but the per-target selector mappings are only set for the genesis Hubs.
///      `newHubs()` returns the Hubs whose selector mappings this payload must add.
///
///      Hub-only and Spoke-only concerns are intentionally split across this contract and
///      `AaveV4PayloadEthereumSpoke`. A payload that does both inherits both and merges their
///      `accessManagerTargetFunctionRoleUpdates()` via `RoleUpdatesLib.merge`.
abstract contract AaveV4PayloadEthereumHub is AaveV4PayloadEthereum {
  struct HubAssetListing {
    IHub hub;
    address underlying;
    uint256 liquidityFee;
    address irStrategy;
    IAssetInterestRateStrategy.InterestRateData irData;
    IAaveV4ConfigEngine.TokenizationSpokeConfig tokenization;
  }

  function hubAssetListings()
    public
    view
    virtual
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

  function accessManagerTargetFunctionRoleUpdates()
    public
    view
    virtual
    override
    returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    return _hubTargetFunctionRoleUpdates();
  }

  /// @dev Freshly-deployed Hubs that need their AccessManager selector mappings configured.
  ///      Return an empty array when listing assets only on existing Hubs (Core/Plus/Prime).
  ///      Intentionally abstract: a default would silently skip the role wiring for a payload
  ///      that brings a new Hub online but forgets to declare it.
  function newHubs() public view virtual returns (IHub[] memory);

  /// @dev Mirrors `AaveV4HubRolesProcedure.setupHubAllRoles`: maps each new Hub's restricted
  ///      selectors to HUB_CONFIGURATOR_ROLE, HUB_FEE_MINTER_ROLE and HUB_DEFICIT_ELIMINATOR_ROLE
  ///      on the shared AccessManager. The role holders themselves are global and already set.
  function _hubTargetFunctionRoleUpdates()
    internal
    view
    returns (IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    IHub[] memory hubs = newHubs();
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[]
      memory updates = new IAaveV4ConfigEngine.TargetFunctionRoleUpdate[](hubs.length * 3);
    uint256 index;
    for (uint256 i; i < hubs.length; ++i) {
      address hub = address(hubs[i]);
      updates[index++] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
        authority: address(AaveV4Ethereum.ACCESS_MANAGER),
        target: hub,
        selectors: Roles.getHubConfiguratorRoleSelectors(),
        roleId: Roles.HUB_CONFIGURATOR_ROLE
      });
      updates[index++] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
        authority: address(AaveV4Ethereum.ACCESS_MANAGER),
        target: hub,
        selectors: Roles.getHubFeeMinterRoleSelectors(),
        roleId: Roles.HUB_FEE_MINTER_ROLE
      });
      updates[index++] = IAaveV4ConfigEngine.TargetFunctionRoleUpdate({
        authority: address(AaveV4Ethereum.ACCESS_MANAGER),
        target: hub,
        selectors: Roles.getHubDeficitEliminatorRoleSelectors(),
        roleId: Roles.HUB_DEFICIT_ELIMINATOR_ROLE
      });
    }
    require(index == updates.length, 'hub role update index mismatch');
    return updates;
  }

  function _hubAssetListings() internal view virtual returns (HubAssetListing[] memory);

  function _hubName(IHub hub) internal pure virtual returns (string memory) {
    if (hub == AaveV4EthereumHubs.CORE_HUB) return 'Core';
    if (hub == AaveV4EthereumHubs.PLUS_HUB) return 'Plus';
    if (hub == AaveV4EthereumHubs.PRIME_HUB) return 'Prime';
    revert('AaveV4PayloadEthereumHub: unknown hub');
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

  /// @dev Empty tokenization config: the asset is listed on the Hub without an ERC4626 wrapper.
  ///      The fork test base asserts no TokenizationSpoke is deployed when name/symbol are empty.
  function _noTokenization()
    internal
    pure
    returns (IAaveV4ConfigEngine.TokenizationSpokeConfig memory)
  {
    return IAaveV4ConfigEngine.TokenizationSpokeConfig({addCap: 0, name: '', symbol: ''});
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
