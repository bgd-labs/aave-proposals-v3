// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';

import {AaveV4PayloadEthereumSpoke} from '../AaveV4PayloadSpoke.sol';
import {AaveV4PayloadEthereumSpokeTestBase} from '../AaveV4PayloadEthereumSpokeTestBase.sol';
import {MockSpokeProposal, MockMultiAssetSpokeProposal} from './MockSpokeProposal.sol';

/**
 * @dev command: forge test --match-path=src/helpers/v4-spoke/tests/AaveV4PayloadEthereumSpoke.t.sol -vv
 */
contract AaveV4PayloadEthereumSpokeTest is AaveV4PayloadEthereumSpokeTestBase {
  MockSpokeProposal internal payload;

  function setUp() public {
    payload = new MockSpokeProposal();
  }

  function test_hubSpokeToAssetsAdditions_mapping() public view {
    IAaveV4ConfigEngine.SpokeToAssetsAddition[] memory additions = payload
      .hubSpokeToAssetsAdditions();
    assertEq(additions.length, 2);

    assertEq(address(additions[0].hubConfigurator), address(AaveV4Ethereum.HUB_CONFIGURATOR));
    assertEq(additions[0].hub, address(AaveV4EthereumHubs.CORE_HUB));
    assertEq(additions[0].spoke, address(0x7777777777777777777777777777777777777777));
    assertEq(additions[0].assets.length, 1);
    assertEq(additions[0].assets[0].config.addCap, 2_000_000);
    assertEq(additions[0].assets[0].config.drawCap, 0);

    assertEq(additions[1].hub, address(AaveV4EthereumHubs.PLUS_HUB));
    assertEq(additions[1].spoke, address(0x7777777777777777777777777777777777777777));
    assertEq(additions[1].assets.length, 1);
    assertEq(additions[1].assets[0].config.drawCap, 1_000_000);
  }

  /// @dev Pins that assets sharing a hub are grouped into one addition.
  function test_hubSpokeToAssetsAdditions_groupsMultipleAssetsPerHub() public {
    MockMultiAssetSpokeProposal multi = new MockMultiAssetSpokeProposal();
    IAaveV4ConfigEngine.SpokeToAssetsAddition[] memory additions = multi
      .hubSpokeToAssetsAdditions();
    assertEq(additions.length, 2, 'two unique hubs expected');

    assertEq(additions[0].hub, address(AaveV4EthereumHubs.CORE_HUB));
    assertEq(additions[0].assets.length, 2, 'both Core assets grouped under one addition');
    assertEq(additions[0].assets[0].config.addCap, 1);
    assertEq(additions[0].assets[1].config.addCap, 2);

    assertEq(additions[1].hub, address(AaveV4EthereumHubs.PLUS_HUB));
    assertEq(additions[1].assets.length, 1);
    assertEq(additions[1].assets[0].config.drawCap, 3);
  }

  function test_spokeReserveListings_mapping() public view {
    IAaveV4ConfigEngine.ReserveListing[] memory listings = payload.spokeReserveListings();
    assertEq(listings.length, 2);
    assertEq(address(listings[0].spokeConfigurator), address(AaveV4Ethereum.SPOKE_CONFIGURATOR));
    assertEq(listings[0].spoke, address(0x7777777777777777777777777777777777777777));
    assertEq(listings[0].hub, address(AaveV4EthereumHubs.CORE_HUB));
    assertTrue(listings[0].config.receiveSharesEnabled);
    assertFalse(listings[0].config.borrowable);
    assertEq(listings[0].dynamicConfig.collateralFactor, 95_00);
    assertEq(listings[1].hub, address(AaveV4EthereumHubs.PLUS_HUB));
    assertFalse(listings[1].config.receiveSharesEnabled);
    assertTrue(listings[1].config.borrowable);
    assertEq(listings[1].dynamicConfig.collateralFactor, 0);
  }

  function test_spokeLiquidationConfigUpdates_mapping() public view {
    IAaveV4ConfigEngine.LiquidationConfigUpdate[] memory updates = payload
      .spokeLiquidationConfigUpdates();
    assertEq(updates.length, 1);
    assertEq(updates[0].targetHealthFactor, 1.02e18);
    assertEq(updates[0].healthFactorForMaxBonus, 0.99e18);
    assertEq(updates[0].liquidationBonusFactor, 100_00);
  }

  function test_spokePositionManagerUpdates_mapping() public view {
    IAaveV4ConfigEngine.PositionManagerUpdate[] memory updates = payload
      .spokePositionManagerUpdates();
    assertEq(updates.length, 4);
    assertEq(
      updates[0].positionManager,
      address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER)
    );
    assertEq(
      updates[1].positionManager,
      address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER)
    );
    assertEq(
      updates[2].positionManager,
      address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER)
    );
    assertEq(updates[3].positionManager, address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY));
    for (uint256 i; i < updates.length; ++i) {
      assertTrue(updates[i].active);
      assertEq(updates[i].spoke, address(0x7777777777777777777777777777777777777777));
    }
  }

  function test_accessManagerTargetFunctionRoleUpdates_mapping() public view {
    IAaveV4ConfigEngine.TargetFunctionRoleUpdate[] memory updates = payload
      .accessManagerTargetFunctionRoleUpdates();
    assertEq(updates.length, 2);

    assertEq(updates[0].authority, address(AaveV4Ethereum.ACCESS_MANAGER));
    assertEq(updates[0].target, address(0x7777777777777777777777777777777777777777));
    assertEq(uint256(updates[0].roleId), uint256(Roles.SPOKE_CONFIGURATOR_ROLE));
    assertEq(updates[0].selectors.length, 7);

    assertEq(updates[1].target, address(0x7777777777777777777777777777777777777777));
    assertEq(uint256(updates[1].roleId), uint256(Roles.SPOKE_USER_POSITION_UPDATER_ROLE));
    assertEq(updates[1].selectors.length, 2);
  }

  function _payload() internal view override returns (AaveV4PayloadEthereumSpoke) {
    return payload;
  }
}
