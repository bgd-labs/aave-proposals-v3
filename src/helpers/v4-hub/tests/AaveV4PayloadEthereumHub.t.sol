// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs} from 'aave-address-book/AaveV4Ethereum.sol';

import {AaveV4PayloadHub, AaveV4PayloadEthereumHub} from '../AaveV4PayloadHub.sol';
import {AaveV4PayloadEthereumHubTestBase} from '../AaveV4PayloadEthereumHubTestBase.sol';
import {MockHubProposal} from './MockHubProposal.sol';

/**
 * @dev command: forge test --match-path=src/helpers/v4-hub/tests/AaveV4PayloadEthereumHub.t.sol -vv
 */
contract AaveV4PayloadEthereumHubTest is AaveV4PayloadEthereumHubTestBase {
  MockHubProposal internal payload;

  function setUp() public {
    payload = new MockHubProposal();
  }

  function test_newHubs_returnsConfiguredHub() public view {
    IHub[] memory hubs = payload.newHubs();
    assertEq(hubs.length, 1);
  }

  function test_hubAssetListings_mapping() public view {
    IAaveV4ConfigEngine.AssetListing[] memory listings = payload.hubAssetListings();
    assertEq(listings.length, 1);
    assertEq(address(listings[0].hubConfigurator), address(AaveV4Ethereum.HUB_CONFIGURATOR));
    assertEq(listings[0].underlying, address(0xC1));
    assertEq(listings[0].feeReceiver, address(AaveV4Ethereum.TREASURY_SPOKE));
    assertEq(listings[0].liquidityFee, 10_00);
    assertEq(listings[0].irData.optimalUsageRatio, 99_00);
    assertEq(listings[0].tokenization.name, 'Wrapped Aave Mock MOCK');
    assertEq(listings[0].tokenization.symbol, 'waMockMOCK');
  }

  function test_accessManagerTargetFunctionRoleUpdates_coverNewHubOnly() public view {
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory updates = payload
      .accessManagerTargetFunctionRoleUpdates();
    // A hub-only payload emits the three Hub-role mappings and no Spoke-role updates.
    assertEq(updates.length, 3);
    assertEq(uint256(updates[0].roleId), uint256(Roles.HUB_CONFIGURATOR_ROLE));
    assertEq(uint256(updates[1].roleId), uint256(Roles.HUB_FEE_MINTER_ROLE));
    assertEq(uint256(updates[2].roleId), uint256(Roles.HUB_DEFICIT_ELIMINATOR_ROLE));
  }

  /// @dev `_hubName` resolves the new-hub override and the genesis hubs, and reverts on unknown.
  function test_hubName_resolvesKnownHubsAndRevertsOnUnknown() public {
    assertEq(payload.exposedHubName(payload.newHubs()[0]), 'Mock');
    assertEq(payload.exposedHubName(AaveV4EthereumHubs.CORE_HUB), 'Core');
    assertEq(payload.exposedHubName(AaveV4EthereumHubs.PLUS_HUB), 'Plus');
    assertEq(payload.exposedHubName(AaveV4EthereumHubs.PRIME_HUB), 'Prime');

    vm.expectRevert(bytes('AaveV4PayloadEthereumHub: unknown hub'));
    payload.exposedHubName(IHub(address(0xdead)));
  }

  function _hubPayload() internal view override returns (AaveV4PayloadHub) {
    return payload;
  }
}
