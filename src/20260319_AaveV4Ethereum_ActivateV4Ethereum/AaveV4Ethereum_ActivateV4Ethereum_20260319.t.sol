// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IHub} from '../interfaces/v4/IHub.sol';
import {IHubConfigurator} from '../interfaces/v4/IHubConfigurator.sol';
import {AaveV4Ethereum_ActivateV4Ethereum_20260319} from './AaveV4Ethereum_ActivateV4Ethereum_20260319.sol';
import {AaveV4EthereumAddresses} from './AaveV4EthereumAddresses.sol';

/**
 * @dev Test for AaveV4Ethereum_ActivateV4Ethereum_20260319
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_ActivateV4Ethereum_20260319.t.sol -vv
 */
contract AaveV4Ethereum_ActivateV4Ethereum_20260319_Test is ProtocolV3TestBase {
  AaveV4Ethereum_ActivateV4Ethereum_20260319 internal proposal;

  address[3] internal hubs;
  address[10] internal spokes;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24693869);
    proposal = new AaveV4Ethereum_ActivateV4Ethereum_20260319();

    hubs[0] = AaveV4EthereumAddresses.CORE_HUB;
    hubs[1] = AaveV4EthereumAddresses.PLUS_HUB;
    hubs[2] = AaveV4EthereumAddresses.PRIME_HUB;

    spokes[0] = AaveV4EthereumAddresses.MAIN_SPOKE;
    spokes[1] = AaveV4EthereumAddresses.BLUECHIP_SPOKE;
    spokes[2] = AaveV4EthereumAddresses.ETHENA_CORRELATED_SPOKE;
    spokes[3] = AaveV4EthereumAddresses.ETHENA_ECOSYSTEM_SPOKE;
    spokes[4] = AaveV4EthereumAddresses.ETHERFI_ESPOKE;
    spokes[5] = AaveV4EthereumAddresses.FOREX_SPOKE;
    spokes[6] = AaveV4EthereumAddresses.GOLD_SPOKE;
    spokes[7] = AaveV4EthereumAddresses.KELP_ESPOKE;
    spokes[8] = AaveV4EthereumAddresses.LIDO_ESPOKE;
    spokes[9] = AaveV4EthereumAddresses.LOMBARD_BTC_SPOKE;

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

  function test_proposalExecution() public {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function test_allListedSpokesInactiveBeforeExecution() public view {
    for (uint256 h = 0; h < hubs.length; ++h) {
      uint256 assetCount = IHub(hubs[h]).getAssetCount();
      for (uint256 a = 0; a < assetCount; ++a) {
        for (uint256 s = 0; s < spokes.length; ++s) {
          if (IHub(hubs[h]).isSpokeListed(a, spokes[s])) {
            IHub.SpokeConfig memory config = IHub(hubs[h]).getSpokeConfig(a, spokes[s]);
            assertFalse(config.active, 'Spoke should be inactive before execution');
          }
        }
      }
    }
  }

  function test_allListedSpokesActiveOnCoreHub() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _assertAllListedSpokesActiveOnHub(AaveV4EthereumAddresses.CORE_HUB);
  }

  function test_allListedSpokesActiveOnPlusHub() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _assertAllListedSpokesActiveOnHub(AaveV4EthereumAddresses.PLUS_HUB);
  }

  function test_allListedSpokesActiveOnPrimeHub() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _assertAllListedSpokesActiveOnHub(AaveV4EthereumAddresses.PRIME_HUB);
  }

  function test_treasurySpokeActiveOnAllHubsForAllAssets() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address treasurySpoke = AaveV4EthereumAddresses.TREASURY_SPOKE;
    for (uint256 h = 0; h < hubs.length; ++h) {
      uint256 assetCount = IHub(hubs[h]).getAssetCount();
      for (uint256 a = 0; a < assetCount; ++a) {
        assertTrue(
          IHub(hubs[h]).isSpokeListed(a, treasurySpoke),
          'Treasury spoke should be listed on every asset'
        );
        IHub.SpokeConfig memory config = IHub(hubs[h]).getSpokeConfig(a, treasurySpoke);
        assertTrue(config.active, 'Treasury spoke should be active on every asset');
      }
    }
  }

  function test_treasurySpokeHasCorrectCaps() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address treasurySpoke = AaveV4EthereumAddresses.TREASURY_SPOKE;
    for (uint256 h = 0; h < hubs.length; ++h) {
      uint256 assetCount = IHub(hubs[h]).getAssetCount();
      for (uint256 a = 0; a < assetCount; ++a) {
        IHub.SpokeConfig memory config = IHub(hubs[h]).getSpokeConfig(a, treasurySpoke);
        assertEq(config.addCap, type(uint40).max, 'Treasury spoke addCap should be unlimited');
        assertEq(config.drawCap, 0, 'Treasury spoke drawCap should be zero');
      }
    }
  }

  function _deactivateAllSpokes() internal {
    address treasurySpoke = AaveV4EthereumAddresses.TREASURY_SPOKE;
    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    for (uint256 h = 0; h < hubs.length; ++h) {
      for (uint256 s = 0; s < spokes.length; ++s) {
        IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).deactivateSpoke(
          hubs[h],
          spokes[s]
        );
      }
      IHubConfigurator(AaveV4EthereumAddresses.HUB_CONFIGURATOR).deactivateSpoke(
        hubs[h],
        treasurySpoke
      );
    }
    vm.stopPrank();
  }

  function _assertAllListedSpokesActiveOnHub(address hub) internal view {
    uint256 assetCount = IHub(hub).getAssetCount();
    assertGt(assetCount, 0, 'Hub should have at least one asset');

    for (uint256 a = 0; a < assetCount; ++a) {
      for (uint256 s = 0; s < spokes.length; ++s) {
        if (IHub(hub).isSpokeListed(a, spokes[s])) {
          IHub.SpokeConfig memory config = IHub(hub).getSpokeConfig(a, spokes[s]);
          assertTrue(config.active, 'Spoke should be active after execution');
        }
      }
    }
  }
}
