// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IHub} from './interfaces/IHub.sol';
import {IHubConfigurator} from './interfaces/IHubConfigurator.sol';
import {AaveV4EthereumAddresses} from './AaveV4EthereumAddresses.sol';
import {AaveV4Ethereum_ActivateV4Ethereum_20260319} from './AaveV4Ethereum_ActivateV4Ethereum_20260319.sol';

/**
 * @dev Test for AaveV4Ethereum_ActivateV4Ethereum_20260319
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_ActivateV4Ethereum_20260319.t.sol -vv
 */
contract AaveV4Ethereum_ActivateV4Ethereum_20260319_Test is ProtocolV3TestBase {
  AaveV4Ethereum_ActivateV4Ethereum_20260319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24693869);
    proposal = new AaveV4Ethereum_ActivateV4Ethereum_20260319();

    // Mock AccessManager to authorize the governance executor on the hub configurator
    vm.mockCall(
      AaveV4EthereumAddresses.ACCESS_MANAGER,
      abi.encodeWithSelector(
        bytes4(keccak256('canCall(address,address,bytes4)')),
        GovernanceV3Ethereum.EXECUTOR_LVL_1,
        AaveV4EthereumAddresses.HUB_CONFIGURATOR
      ),
      abi.encode(true, uint32(0))
    );

    // Deactivate all spokes so we start from a clean inactive state
    _deactivateAllSpokes();
  }

  function test_allSpokesActiveOnCoreHub() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _assertAllSpokesActiveOnHub(AaveV4EthereumAddresses.CORE_HUB);
  }

  function test_allSpokesActiveOnPlusHub() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _assertAllSpokesActiveOnHub(AaveV4EthereumAddresses.PLUS_HUB);
  }

  function test_allSpokesActiveOnPrimeHub() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _assertAllSpokesActiveOnHub(AaveV4EthereumAddresses.PRIME_HUB);
  }

  function test_allSpokesInactiveBeforeExecution() public view {
    address[3] memory hubs = AaveV4EthereumAddresses.getHubs();

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
    address[3] memory hubs = AaveV4EthereumAddresses.getHubs();

    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    for (uint256 h = 0; h < hubs.length; ++h) {
      uint256 assetCount = IHub(hubs[h]).getAssetCount();
      for (uint256 a = 0; a < assetCount; ++a) {
        uint256 spokeCount = IHub(hubs[h]).getSpokeCount(a);
        for (uint256 s = 0; s < spokeCount; ++s) {
          address spoke = IHub(hubs[h]).getSpokeAddress(a, s);
          IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).updateSpokeActive(
            hubs[h],
            a,
            spoke,
            false
          );
        }
      }
    }
    vm.stopPrank();
  }

  function _assertAllSpokesActiveOnHub(address hub) internal view {
    uint256 assetCount = IHub(hub).getAssetCount();
    assertGt(assetCount, 0, 'Hub should have at least one asset');

    for (uint256 a = 0; a < assetCount; ++a) {
      uint256 spokeCount = IHub(hub).getSpokeCount(a);
      for (uint256 s = 0; s < spokeCount; ++s) {
        address spoke = IHub(hub).getSpokeAddress(a, s);
        IHub.SpokeConfig memory config = IHub(hub).getSpokeConfig(a, spoke);
        assertTrue(config.active, 'Spoke should be active after execution');
      }
    }
  }
}
