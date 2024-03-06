// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    ccc = GovernanceV3BNB.CROSS_CHAIN_CONTROLLER;
    proxyAdmin = MiscBNB.PROXY_ADMIN;

    vm.createSelectFork(vm.rpcUrl('bnb'), 36699072);
    proposal = new AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _testCurrentReceiversAreAllowed();
    _testAllReceiversAreRepresented();
    _testImplementationAddress(proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), false);

    executePayload(vm, address(proposal));

    _testAfterReceiversAreAllowed();
    _testAllReceiversAreRepresentedAfter();
    _testImplementationAddress(proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), true);
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
