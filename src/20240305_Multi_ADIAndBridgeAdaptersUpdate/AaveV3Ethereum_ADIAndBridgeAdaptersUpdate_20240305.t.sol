// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    ccc = GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER;
    proxyAdmin = MiscEthereum.PROXY_ADMIN;

    vm.createSelectFork(vm.rpcUrl('mainnet'), 19367957);
    proposal = new AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _testCurrentReceiversAreAllowed();
    _testCurrentForwarders();
    _testImplementationAddress(proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), false);

    executePayload(vm, address(proposal));

    _testAfterReceiversAreAllowed();
    _testAfterForwarders();
    _testImplementationAddress(proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), true);
  }

  function _testCurrentForwarders() internal {
    uint256[] memory forwarderChains = new uint256[](9);
    forwarderChains[0] = ChainIds.POLYGON;
    forwarderChains[1] = ChainIds.AVALANCHE;
    forwarderChains[2] = ChainIds.BNB;
    forwarderChains[3] = ChainIds.GNOSIS;
    forwarderChains[4] = ChainIds.ARBITRUM;
    forwarderChains[5] = ChainIds.OPTIMISM;
    forwarderChains[6] = ChainIds.BASE;
    forwarderChains[7] = ChainIds.METIS;
    forwarderChains[8] = ChainIds.SCROLL;

    for (uint256 i = 0; i < forwarderChains.length; i++) {
      if (forwarderChains[i] == ChainIds.POLYGON) {
        address[] memory adapters = new address[](4);
        adapters[0] = proposal.CCIP_ADAPTER_TO_REMOVE();
        adapters[1] = proposal.LZ_ADAPTER_TO_REMOVE();
        adapters[2] = proposal.HL_ADAPTER_TO_REMOVE();
        adapters[3] = proposal.POL_ADAPTER_TO_REMOVE();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.AVALANCHE || forwarderChains[i] == ChainIds.BNB) {
        address[] memory adapters = new address[](3);
        adapters[0] = proposal.CCIP_ADAPTER_TO_REMOVE();
        adapters[1] = proposal.LZ_ADAPTER_TO_REMOVE();
        adapters[2] = proposal.HL_ADAPTER_TO_REMOVE();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.GNOSIS) {
        address[] memory adapters = new address[](3);
        adapters[0] = proposal.GNOSIS_ADAPTER_TO_REMOVE();
        adapters[1] = proposal.LZ_ADAPTER_TO_REMOVE_GNOSIS();
        adapters[2] = proposal.HL_ADAPTER_TO_REMOVE();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.ARBITRUM) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.ARB_ADAPTER_TO_REMOVE();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.OPTIMISM) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.OPT_ADAPTER_TO_REMOVE();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.METIS) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.METIS_ADAPTER_TO_REMOVE();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.SCROLL) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.SCROLL_ADAPTER_TO_REMOVE();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.BASE) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.BASE_ADAPTER_TO_REMOVE();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
    }
  }

  function _testAfterForwarders() internal {
    uint256[] memory forwarderChains = new uint256[](9);
    forwarderChains[0] = ChainIds.POLYGON;
    forwarderChains[1] = ChainIds.AVALANCHE;
    forwarderChains[2] = ChainIds.BNB;
    forwarderChains[3] = ChainIds.GNOSIS;
    forwarderChains[4] = ChainIds.ARBITRUM;
    forwarderChains[5] = ChainIds.OPTIMISM;
    forwarderChains[6] = ChainIds.BASE;
    forwarderChains[7] = ChainIds.METIS;
    forwarderChains[8] = ChainIds.SCROLL;

    for (uint256 i = 0; i < forwarderChains.length; i++) {
      if (forwarderChains[i] == ChainIds.POLYGON) {
        address[] memory adapters = new address[](4);
        adapters[0] = proposal.CCIP_NEW_ADAPTER();
        adapters[1] = proposal.LZ_NEW_ADAPTER();
        adapters[2] = proposal.HL_NEW_ADAPTER();
        adapters[3] = proposal.POL_NEW_ADAPTER();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.AVALANCHE || forwarderChains[i] == ChainIds.BNB) {
        address[] memory adapters = new address[](3);
        adapters[0] = proposal.CCIP_NEW_ADAPTER();
        adapters[1] = proposal.LZ_NEW_ADAPTER();
        adapters[2] = proposal.HL_NEW_ADAPTER();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.GNOSIS) {
        address[] memory adapters = new address[](3);
        adapters[0] = proposal.GNOSIS_NEW_ADAPTER();
        adapters[1] = proposal.LZ_NEW_ADAPTER();
        adapters[2] = proposal.HL_NEW_ADAPTER();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.ARBITRUM) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.ARB_NEW_ADAPTER();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.OPTIMISM) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.OPT_NEW_ADAPTER();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.METIS) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.METIS_NEW_ADAPTER();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.SCROLL) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.SCROLL_NEW_ADAPTER();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
      if (forwarderChains[i] == ChainIds.BASE) {
        address[] memory adapters = new address[](1);
        adapters[0] = proposal.BASE_NEW_ADAPTER();

        _checkAdapterCorrectness(forwarderChains[i], adapters);
      }
    }
  }

  function _testCurrentReceiversAreAllowed() internal {
    // check that current bridges are allowed
    _testReceiverAdapterAllowed(proposal.CCIP_ADAPTER_TO_REMOVE(), ChainIds.AVALANCHE, true);
    _testReceiverAdapterAllowed(proposal.CCIP_ADAPTER_TO_REMOVE(), ChainIds.POLYGON, true);
    _testReceiverAdapterAllowed(proposal.LZ_ADAPTER_TO_REMOVE(), ChainIds.AVALANCHE, true);
    _testReceiverAdapterAllowed(proposal.LZ_ADAPTER_TO_REMOVE(), ChainIds.POLYGON, true);
    _testReceiverAdapterAllowed(proposal.HL_ADAPTER_TO_REMOVE(), ChainIds.AVALANCHE, true);
    _testReceiverAdapterAllowed(proposal.HL_ADAPTER_TO_REMOVE(), ChainIds.POLYGON, true);
    _testReceiverAdapterAllowed(proposal.POL_ADAPTER_TO_REMOVE(), ChainIds.POLYGON, true);
  }

  function _testAfterReceiversAreAllowed() internal {
    // check that old bridges are no longer allowed
    _testReceiverAdapterAllowed(proposal.CCIP_ADAPTER_TO_REMOVE(), ChainIds.AVALANCHE, false);
    _testReceiverAdapterAllowed(proposal.CCIP_ADAPTER_TO_REMOVE(), ChainIds.POLYGON, false);
    _testReceiverAdapterAllowed(proposal.LZ_ADAPTER_TO_REMOVE(), ChainIds.AVALANCHE, false);
    _testReceiverAdapterAllowed(proposal.LZ_ADAPTER_TO_REMOVE(), ChainIds.POLYGON, false);
    _testReceiverAdapterAllowed(proposal.HL_ADAPTER_TO_REMOVE(), ChainIds.AVALANCHE, false);
    _testReceiverAdapterAllowed(proposal.HL_ADAPTER_TO_REMOVE(), ChainIds.POLYGON, false);
    _testReceiverAdapterAllowed(proposal.POL_ADAPTER_TO_REMOVE(), ChainIds.POLYGON, false);

    // check that new bridges are allowed
    _testReceiverAdapterAllowed(proposal.CCIP_NEW_ADAPTER(), ChainIds.AVALANCHE, true);
    _testReceiverAdapterAllowed(proposal.CCIP_NEW_ADAPTER(), ChainIds.POLYGON, true);
    _testReceiverAdapterAllowed(proposal.LZ_NEW_ADAPTER(), ChainIds.AVALANCHE, true);
    _testReceiverAdapterAllowed(proposal.LZ_NEW_ADAPTER(), ChainIds.POLYGON, true);
    _testReceiverAdapterAllowed(proposal.HL_NEW_ADAPTER(), ChainIds.AVALANCHE, true);
    _testReceiverAdapterAllowed(proposal.HL_NEW_ADAPTER(), ChainIds.POLYGON, true);
    _testReceiverAdapterAllowed(proposal.POL_NEW_ADAPTER(), ChainIds.POLYGON, true);
  }
}
