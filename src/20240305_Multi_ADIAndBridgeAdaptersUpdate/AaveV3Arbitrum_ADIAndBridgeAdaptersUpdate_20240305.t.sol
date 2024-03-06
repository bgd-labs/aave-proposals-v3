// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 187288037);
    proposal = new AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    // get receiver adapters
    address[] memory receiverAdapters = ICrossChainReceiver(
      GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER
    ).getReceiverBridgeAdaptersByChain(ChainIds.MAINNET);

    assertEq(receiverAdapters.length, 1);
    assertEq(receiverAdapters[0] != proposal.NEW_ADAPTER(), true);
    assertEq(receiverAdapters[0], proposal.ADAPTER_TO_REMOVE());
    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.ADAPTER_TO_REMOVE(), ChainIds.MAINNET),
      true
    );

    // get proxy information
    address cccImplementation = ProxyAdmin(MiscArbitrum.PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER))
    );

    assertEq(cccImplementation != proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), true);

    executePayload(vm, address(proposal));

    address[] memory receiverAdaptersAfter = ICrossChainReceiver(
      GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER
    ).getReceiverBridgeAdaptersByChain(ChainIds.MAINNET);

    assertEq(proposal.NEW_ADAPTER(), receiverAdaptersAfter[0]);
    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.NEW_ADAPTER(), ChainIds.MAINNET),
      true
    );
    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.ADAPTER_TO_REMOVE(), ChainIds.MAINNET),
      false
    );

    address cccImplementationAfter = ProxyAdmin(MiscArbitrum.PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER))
    );

    assertEq(cccImplementationAfter, proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION());

    // TODO: does it make sense to check other configs? required confirmations etc
  }
}
