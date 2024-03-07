// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    ccc = GovernanceV3Optimism.CROSS_CHAIN_CONTROLLER;
    proxyAdmin = MiscOptimism.PROXY_ADMIN;

    vm.createSelectFork(vm.rpcUrl('optimism'), 117015407);
    proposal = new AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _testTrustedRemotes();

    _testImplementationAddress(proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), false);
    _testCurrentReceiversAreAllowed();
    _testAllReceiversAreRepresented();

    executePayload(vm, address(proposal));

    _testImplementationAddress(proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), true);
    _testAfterReceiversAreAllowed();
    _testAllReceiversAreRepresentedAfter();
  }

  function _testTrustedRemotes() internal {
    _testTrustedRemoteByChain(
      proposal.NEW_ADAPTER(),
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      ChainIds.MAINNET
    );
  }

  function _testAllReceiversAreRepresented() internal {
    address[] memory adapters = new address[](1);
    adapters[0] = proposal.ADAPTER_TO_REMOVE();

    _testReceiverAdaptersByChain(ChainIds.MAINNET, adapters);
  }

  function _testAllReceiversAreRepresentedAfter() internal {
    address[] memory adapters = new address[](1);
    adapters[0] = proposal.NEW_ADAPTER();

    _testReceiverAdaptersByChain(ChainIds.MAINNET, adapters);
  }

  function _testCurrentReceiversAreAllowed() internal {
    _testReceiverAdapterAllowed(proposal.ADAPTER_TO_REMOVE(), ChainIds.MAINNET, true);
  }

  function _testAfterReceiversAreAllowed() internal {
    // check that old bridges are no longer allowed
    _testReceiverAdapterAllowed(proposal.ADAPTER_TO_REMOVE(), ChainIds.MAINNET, false);

    // check that new bridges are allowed
    _testReceiverAdapterAllowed(proposal.NEW_ADAPTER(), ChainIds.MAINNET, true);
  }
}
