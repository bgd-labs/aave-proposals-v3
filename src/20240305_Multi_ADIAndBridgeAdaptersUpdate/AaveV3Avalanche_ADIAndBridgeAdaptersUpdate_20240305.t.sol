// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    ccc = GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER;
    proxyAdmin = MiscAvalanche.PROXY_ADMIN;

    vm.createSelectFork(vm.rpcUrl('avalanche'), 42502057);
    proposal = new AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _testTrustedRemotes();

    _testCurrentReceiversAreAllowed();
    _testAllReceiversAreRepresented();
    _testCurrentForwarders();
    _testImplementationAddress(proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), false);

    executePayload(vm, address(proposal));

    _testAfterReceiversAreAllowed();
    _testAllReceiversAreRepresentedAfter();
    _testAfterForwarders();
    _testImplementationAddress(proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), true);
  }

  function _testTrustedRemotes() internal {
    _testTrustedRemoteByChain(
      proposal.CCIP_NEW_ADAPTER(),
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      ChainIds.MAINNET
    );
    _testTrustedRemoteByChain(
      proposal.LZ_NEW_ADAPTER(),
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      ChainIds.MAINNET
    );
    _testTrustedRemoteByChain(
      proposal.HL_NEW_ADAPTER(),
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      ChainIds.MAINNET
    );
  }

  function _testCurrentForwarders() internal {
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory adapters = new ICrossChainForwarder.ChainIdBridgeConfig[](3);
    adapters[0].currentChainBridgeAdapter = proposal.CCIP_ADAPTER_TO_REMOVE();
    adapters[1].currentChainBridgeAdapter = proposal.LZ_ADAPTER_TO_REMOVE();
    adapters[2].currentChainBridgeAdapter = proposal.HL_ADAPTER_TO_REMOVE();

    _checkForwarderAdapterCorrectness(ChainIds.MAINNET, adapters, false);
  }

  function _testAfterForwarders() internal {
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory adapters = new ICrossChainForwarder.ChainIdBridgeConfig[](3);
    adapters[0].currentChainBridgeAdapter = proposal.CCIP_NEW_ADAPTER();
    adapters[1].currentChainBridgeAdapter = proposal.LZ_NEW_ADAPTER();
    adapters[2].currentChainBridgeAdapter = proposal.HL_NEW_ADAPTER();
    adapters[0].destinationBridgeAdapter = proposal.DESTINATION_CCIP_NEW_ADAPTER();
    adapters[1].destinationBridgeAdapter = proposal.DESTINATION_LZ_NEW_ADAPTER();
    adapters[2].destinationBridgeAdapter = proposal.DESTINATION_HL_NEW_ADAPTER();

    _checkForwarderAdapterCorrectness(ChainIds.MAINNET, adapters, true);
  }

  function _testAllReceiversAreRepresented() internal {
    address[] memory adapters = new address[](3);
    adapters[0] = proposal.CCIP_ADAPTER_TO_REMOVE();
    adapters[1] = proposal.LZ_ADAPTER_TO_REMOVE();
    adapters[2] = proposal.HL_ADAPTER_TO_REMOVE();

    _testReceiverAdaptersByChain(ChainIds.MAINNET, adapters);
  }

  function _testAllReceiversAreRepresentedAfter() internal {
    address[] memory adapters = new address[](3);
    adapters[0] = proposal.CCIP_NEW_ADAPTER();
    adapters[1] = proposal.LZ_NEW_ADAPTER();
    adapters[2] = proposal.HL_NEW_ADAPTER();

    _testReceiverAdaptersByChain(ChainIds.MAINNET, adapters);
  }

  function _testCurrentReceiversAreAllowed() internal {
    // check that current bridges are allowed
    _testReceiverAdapterAllowed(proposal.CCIP_ADAPTER_TO_REMOVE(), ChainIds.MAINNET, true);
    _testReceiverAdapterAllowed(proposal.LZ_ADAPTER_TO_REMOVE(), ChainIds.MAINNET, true);
    _testReceiverAdapterAllowed(proposal.HL_ADAPTER_TO_REMOVE(), ChainIds.MAINNET, true);
  }

  function _testAfterReceiversAreAllowed() internal {
    // check that old bridges are no longer allowed
    _testReceiverAdapterAllowed(proposal.CCIP_ADAPTER_TO_REMOVE(), ChainIds.MAINNET, false);
    _testReceiverAdapterAllowed(proposal.LZ_ADAPTER_TO_REMOVE(), ChainIds.MAINNET, false);
    _testReceiverAdapterAllowed(proposal.HL_ADAPTER_TO_REMOVE(), ChainIds.MAINNET, false);

    // check that new bridges are allowed
    _testReceiverAdapterAllowed(proposal.CCIP_NEW_ADAPTER(), ChainIds.MAINNET, true);
    _testReceiverAdapterAllowed(proposal.LZ_NEW_ADAPTER(), ChainIds.MAINNET, true);
    _testReceiverAdapterAllowed(proposal.HL_NEW_ADAPTER(), ChainIds.MAINNET, true);
  }
}
