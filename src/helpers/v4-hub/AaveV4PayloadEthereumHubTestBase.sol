// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum} from 'aave-address-book/AaveV4Ethereum.sol';

import {AaveV4PayloadHub} from './AaveV4PayloadHub.sol';

/// @dev Reusable, payload-agnostic checks for any proposal that configures Hubs. On-chain
///      (post-execution) assertions live in the fork test base.
abstract contract AaveV4PayloadEthereumHubTestBase is Test {
  function test_hubAssetListings_useCanonicalConfiguratorAndFeeReceiver() public view {
    IAaveV4ConfigEngine.AssetListing[] memory listings = _hubPayload().hubAssetListings();
    for (uint256 i; i < listings.length; ++i) {
      assertEq(
        address(listings[i].hubConfigurator),
        address(AaveV4Ethereum.HUB_CONFIGURATOR),
        'asset listing must route through the canonical HubConfigurator'
      );
      assertEq(
        listings[i].feeReceiver,
        address(AaveV4Ethereum.TREASURY_SPOKE),
        'asset listing fee receiver must be the TreasurySpoke'
      );
    }
  }

  /// @dev Each new Hub must map its restricted selectors to the three Hub roles, as genesis does.
  function test_newHubRoleWiring_matchesGenesis() public view {
    IHub[] memory hubs = _hubPayload().newHubs();
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory updates = _hubPayload()
      .accessManagerTargetFunctionRoleUpdates();

    for (uint256 i; i < hubs.length; ++i) {
      address hub = address(hubs[i]);
      _assertHubRoleMapped(
        updates,
        hub,
        Roles.HUB_CONFIGURATOR_ROLE,
        Roles.getHubConfiguratorRoleSelectors()
      );
      _assertHubRoleMapped(
        updates,
        hub,
        Roles.HUB_FEE_MINTER_ROLE,
        Roles.getHubFeeMinterRoleSelectors()
      );
      _assertHubRoleMapped(
        updates,
        hub,
        Roles.HUB_DEFICIT_ELIMINATOR_ROLE,
        Roles.getHubDeficitEliminatorRoleSelectors()
      );
    }
  }

  function _assertHubRoleMapped(
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory updates,
    address hub,
    uint64 roleId,
    bytes4[] memory expectedSelectors
  ) internal pure {
    for (uint256 i; i < updates.length; ++i) {
      if (updates[i].target != hub || updates[i].roleId != roleId) continue;
      assertEq(
        updates[i].authority,
        address(AaveV4Ethereum.ACCESS_MANAGER),
        'role update must target the protocol AccessManager'
      );
      assertEq(updates[i].selectors.length, expectedSelectors.length, 'hub role selector count');
      for (uint256 j; j < expectedSelectors.length; ++j) {
        assertEq(updates[i].selectors[j], expectedSelectors[j], 'hub role selector mismatch');
      }
      return;
    }
    revert('hub role mapping missing');
  }

  function _hubPayload() internal view virtual returns (AaveV4PayloadHub);
}
