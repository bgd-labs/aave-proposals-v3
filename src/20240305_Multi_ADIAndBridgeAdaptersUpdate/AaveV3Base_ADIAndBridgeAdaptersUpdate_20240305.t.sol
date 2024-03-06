// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 11420130);
    proposal = new AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    // get receiver adapters
    address[] memory receiverAdapters = ICrossChainReceiver(GovernanceV3Base.CROSS_CHAIN_CONTROLLER)
      .getReceiverBridgeAdaptersByChain(ChainIds.MAINNET);

    assertEq(receiverAdapters.length, 1);
    assertEq(receiverAdapters[0] != proposal.NEW_ADAPTER(), true);
    assertEq(receiverAdapters[0], proposal.ADAPTER_TO_REMOVE());
    assertEq(
      ICrossChainReceiver(GovernanceV3Base.CROSS_CHAIN_CONTROLLER).isReceiverBridgeAdapterAllowed(
        proposal.ADAPTER_TO_REMOVE(),
        ChainIds.MAINNET
      ),
      true
    );

    // get proxy information
    address cccImplementation = ProxyAdmin(MiscBase.PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(GovernanceV3Base.CROSS_CHAIN_CONTROLLER))
    );

    assertEq(cccImplementation != proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), true);

    executePayload(vm, address(proposal));

    address[] memory receiverAdaptersAfter = ICrossChainReceiver(
      GovernanceV3Base.CROSS_CHAIN_CONTROLLER
    ).getReceiverBridgeAdaptersByChain(ChainIds.MAINNET);

    assertEq(proposal.NEW_ADAPTER(), receiverAdaptersAfter[0]);
    assertEq(
      ICrossChainReceiver(GovernanceV3Base.CROSS_CHAIN_CONTROLLER).isReceiverBridgeAdapterAllowed(
        proposal.NEW_ADAPTER(),
        ChainIds.MAINNET
      ),
      true
    );
    assertEq(
      ICrossChainReceiver(GovernanceV3Base.CROSS_CHAIN_CONTROLLER).isReceiverBridgeAdapterAllowed(
        proposal.ADAPTER_TO_REMOVE(),
        ChainIds.MAINNET
      ),
      false
    );

    address cccImplementationAfter = ProxyAdmin(MiscBase.PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(GovernanceV3Base.CROSS_CHAIN_CONTROLLER))
    );

    assertEq(cccImplementationAfter, proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION());

    // TODO: does it make sense to check other configs? required confirmations etc
  }
}
