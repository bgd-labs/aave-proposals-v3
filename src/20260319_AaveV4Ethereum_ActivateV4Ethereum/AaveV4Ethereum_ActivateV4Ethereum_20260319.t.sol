// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV4TestBase} from 'src/helpers/v4/tests/utils/ProtocolV4TestBase.sol';
import {IAccessManager} from './interfaces/IAccessManager.sol';
import {IHub} from './interfaces/IHub.sol';
import {IHubConfigurator} from './interfaces/IHubConfigurator.sol';
import {AaveV4EthereumAddresses} from './AaveV4EthereumAddresses.sol';
import {AaveV4Ethereum_ActivateV4Ethereum_20260319} from './AaveV4Ethereum_ActivateV4Ethereum_20260319.sol';

/**
 * @dev Test for AaveV4Ethereum_ActivateV4Ethereum_20260319
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_ActivateV4Ethereum_20260319.t.sol -vv
 */
contract AaveV4Ethereum_ActivateV4Ethereum_20260319_Test is ProtocolV4TestBase {
  AaveV4Ethereum_ActivateV4Ethereum_20260319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24693869);
    proposal = new AaveV4Ethereum_ActivateV4Ethereum_20260319();

    // TODO: This should be done outside AIP?
    // Grant the governance executor role 200 to call functions on the hub configurator
    vm.prank(0x9Fdf83e26ABb83d97424F5851F61601d9B8264e1);
    IAccessManager(AaveV4EthereumAddresses.ACCESS_MANAGER).grantRole(
      200,
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      0
    );

    // TODO: This is just for testing, remove when we have final deployed contracts
    // Deactivate all spokes so we start from a clean inactive state
    // todo: remove this once we migrate from dry run to final deploymennt
    _deactivateAllSpokes();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV4Ethereum_ActivateV4Ethereum_20260319',
      AaveV4EthereumAddresses.getUserSpokes(),
      address(proposal)
    );
  }

  function test_allSpokesActiveOnAllHubs() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address[] memory hubs = AaveV4EthereumAddresses.getHubs();
    for (uint256 h = 0; h < hubs.length; ++h) {
      _assertAllSpokesActiveOnHub(hubs[h]);
    }
  }

  function test_allSpokesInactiveBeforeExecution() public view {
    address[] memory hubs = AaveV4EthereumAddresses.getHubs();

    for (uint256 h = 0; h < hubs.length; ++h) {
      uint256 assetCount = IHub(hubs[h]).getAssetCount();
      for (uint256 a = 0; a < assetCount; ++a) {
        uint256 spokeCount = IHub(hubs[h]).getSpokeCount(a);
        for (uint256 s = 0; s < spokeCount; ++s) {
          address spoke = IHub(hubs[h]).getSpokeAddress(a, s);
          IHub.SpokeConfig memory config = IHub(hubs[h]).getSpokeConfig(a, spoke);
          assertFalse(config.active, 'Spoke should be inactive before execution');
        }
      }
    }
  }

  function _deactivateAllSpokes() internal {
    address[] memory hubs = AaveV4EthereumAddresses.getHubs();
    address[] memory spokes = AaveV4EthereumAddresses.getSpokes();

    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    for (uint256 h = 0; h < hubs.length; ++h) {
      for (uint256 s = 0; s < spokes.length; ++s) {
        IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).deactivateSpoke(
          hubs[h],
          spokes[s]
        );
      }
    }
    vm.stopPrank();
  }

  function _assertAllSpokesActiveOnHub(address hub_) internal view {
    IHub hub = IHub(hub_);

    for (uint256 a = 0; a < hub.getAssetCount(); ++a) {
      uint256 spokeCount = hub.getSpokeCount(a);
      for (uint256 s = 0; s < spokeCount; ++s) {
        address spoke = hub.getSpokeAddress(a, s);
        IHub.SpokeConfig memory config = hub.getSpokeConfig(a, spoke);
        assertTrue(config.active, 'Spoke should be active after execution');
      }
    }
  }
}
