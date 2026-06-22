// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV4TestBase} from 'aave-helpers/src/ProtocolV4TestBase.sol';
import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {IAccessManaged} from 'aave-v4/dependencies/openzeppelin/IAccessManaged.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IAccessManagerEnumerable, ITokenizationSpoke} from 'aave-address-book/AaveV4.sol';
import {AaveV4Ethereum} from 'aave-address-book/AaveV4Ethereum.sol';

import {AaveV4PayloadEthereumHubTestBase} from './AaveV4PayloadEthereumHubTestBase.sol';
import {TokenizationSpokeLib} from './TokenizationSpokeLib.sol';

/// @dev On-chain (post-execution) bring-up assertions for any payload that lists assets on Hubs,
///      including those that deploy a new Hub.
abstract contract AaveV4PayloadEthereumHubForkTestBase is
  AaveV4PayloadEthereumHubTestBase,
  ProtocolV4TestBase
{
  IAccessManagerEnumerable internal constant HUB_ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  /// @dev Assumed precondition: the HubConfigurator already holds HUB_CONFIGURATOR_ROLE.
  function test_assumedRole_hubConfiguratorHoldsConfiguratorRole() public view virtual {
    (bool isMember, ) = HUB_ACCESS_MANAGER.hasRole(
      Roles.HUB_CONFIGURATOR_ROLE,
      address(AaveV4Ethereum.HUB_CONFIGURATOR)
    );
    assertTrue(isMember, 'HubConfigurator must already hold HUB_CONFIGURATOR_ROLE');
  }

  /// @dev The role wiring targets `AaveV4Ethereum.ACCESS_MANAGER`, so each new Hub must be governed
  ///      by it; otherwise the wiring lands on the wrong authority.
  function test_newHubs_governedBySharedAccessManager() public view virtual {
    IHub[] memory hubs = _hubPayload().newHubs();
    for (uint256 i; i < hubs.length; ++i) {
      assertEq(
        IAccessManaged(address(hubs[i])).authority(),
        address(AaveV4Ethereum.ACCESS_MANAGER),
        'new Hub must be governed by the shared protocol AccessManager'
      );
    }
  }

  /// @dev A freshly-deployed Hub ships with its restricted selectors ungated on the shared
  ///      AccessManager; the payload is what gates them.
  function test_newHubs_selectorsUngatedBeforePayload() public view virtual {
    IHub[] memory hubs = _hubPayload().newHubs();
    for (uint256 i; i < hubs.length; ++i) {
      assertEq(
        HUB_ACCESS_MANAGER.getTargetFunctionRole(address(hubs[i]), IHub.addAsset.selector),
        0,
        'new Hub selectors should be ungated before execution'
      );
    }
  }

  function test_newHubs_configuredAfterPayload() public virtual {
    IHub[] memory hubs = _hubPayload().newHubs();
    GovV3Helpers.executePayload(vm, address(_hubPayload()));
    for (uint256 i; i < hubs.length; ++i) {
      address hub = address(hubs[i]);
      _assertSelectorsMapped(
        hub,
        Roles.getHubConfiguratorRoleSelectors(),
        Roles.HUB_CONFIGURATOR_ROLE
      );
      _assertSelectorsMapped(hub, Roles.getHubFeeMinterRoleSelectors(), Roles.HUB_FEE_MINTER_ROLE);
      _assertSelectorsMapped(
        hub,
        Roles.getHubDeficitEliminatorRoleSelectors(),
        Roles.HUB_DEFICIT_ELIMINATOR_ROLE
      );

      (bool allowed, uint32 delay) = HUB_ACCESS_MANAGER.canCall(
        address(AaveV4Ethereum.HUB_CONFIGURATOR),
        hub,
        IHub.addAsset.selector
      );
      assertTrue(allowed, 'HubConfigurator should be allowed to call the new Hub');
      assertEq(delay, 0, 'No execution delay expected');
    }
  }

  function test_hubAssetsListedAfterPayload() public virtual {
    IAaveV4ConfigEngine.AssetListing[] memory listings = _hubPayload().hubAssetListings();
    GovV3Helpers.executePayload(vm, address(_hubPayload()));
    for (uint256 i; i < listings.length; ++i) {
      IHub hub = IHub(listings[i].hub);
      uint256 assetId = hub.getAssetId(listings[i].underlying);
      IHub.AssetConfig memory config = hub.getAssetConfig(assetId);
      assertEq(config.irStrategy, listings[i].irStrategy, 'asset IR strategy mismatch');
      assertEq(config.feeReceiver, listings[i].feeReceiver, 'asset fee receiver mismatch');
      assertEq(config.liquidityFee, listings[i].liquidityFee, 'asset liquidity fee mismatch');
    }
  }

  /// @dev A TokenizationSpoke must exist for a listing iff its tokenization name/symbol are
  ///      non-empty; an empty config (`_noTokenization()`) must leave none on the Hub.
  function test_hubTokenizationSpokesMatchListings() public virtual {
    IAaveV4ConfigEngine.AssetListing[] memory listings = _hubPayload().hubAssetListings();
    GovV3Helpers.executePayload(vm, address(_hubPayload()));
    for (uint256 i; i < listings.length; ++i) {
      IHub hub = IHub(listings[i].hub);
      address tokenizationSpoke = TokenizationSpokeLib.find(hub, listings[i].underlying);

      bool tokenizationDeclared = bytes(listings[i].tokenization.name).length != 0 &&
        bytes(listings[i].tokenization.symbol).length != 0;

      if (!tokenizationDeclared) {
        assertEq(
          tokenizationSpoke,
          address(0),
          'no TokenizationSpoke expected when name/symbol are empty'
        );
        continue;
      }

      assertTrue(tokenizationSpoke != address(0), 'TokenizationSpoke missing for declared listing');
      assertEq(ITokenizationSpoke(tokenizationSpoke).name(), listings[i].tokenization.name);
      assertEq(ITokenizationSpoke(tokenizationSpoke).symbol(), listings[i].tokenization.symbol);
      uint256 assetId = hub.getAssetId(listings[i].underlying);
      assertEq(
        hub.getSpokeConfig(assetId, tokenizationSpoke).addCap,
        uint40(listings[i].tokenization.addCap),
        'TokenizationSpoke addCap mismatch'
      );
    }
  }

  function _assertSelectorsMapped(
    address hub,
    bytes4[] memory selectors,
    uint64 roleId
  ) internal view {
    for (uint256 i; i < selectors.length; ++i) {
      assertEq(
        HUB_ACCESS_MANAGER.getTargetFunctionRole(hub, selectors[i]),
        roleId,
        'new Hub selector mapped to unexpected role'
      );
    }
  }
}
