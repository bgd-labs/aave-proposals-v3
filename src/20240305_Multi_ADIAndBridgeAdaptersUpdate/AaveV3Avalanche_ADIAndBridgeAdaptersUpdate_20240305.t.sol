// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';

/**
 * @dev Test for AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase {
  AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 42502057);
    proposal = new AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.CCIP_ADAPTER_TO_REMOVE(), ChainIds.MAINNET),
      true
    );
    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.LZ_ADAPTER_TO_REMOVE(), ChainIds.MAINNET),
      true
    );
    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.HL_ADAPTER_TO_REMOVE(), ChainIds.MAINNET),
      true
    );
    // get receiver adapters
    address[] memory receiverAdapters = ICrossChainReceiver(
      GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER
    ).getReceiverBridgeAdaptersByChain(ChainIds.MAINNET);

    // get forwarder adapters
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory forwarderBridgeAdaptersEthereum = ICrossChainForwarder(
        GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER
      ).getForwarderBridgeAdaptersByChain(ChainIds.MAINNET);

    // get proxy information
    address cccImplementation = ProxyAdmin(MiscAvalanche.PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER))
    );

    uint256 receiverAdaptersCount;
    for (uint256 i = 0; i < receiverAdapters.length; i++) {
      if (
        receiverAdapters[i] == proposal.CCIP_ADAPTER_TO_REMOVE() ||
        receiverAdapters[i] == proposal.LZ_ADAPTER_TO_REMOVE() ||
        receiverAdapters[i] == proposal.HL_ADAPTER_TO_REMOVE()
      ) {
        receiverAdaptersCount++;
      }
    }
    assertEq(receiverAdaptersCount, receiverAdapters.length);
    assertEq(receiverAdapters.length, 3);

    uint256 forwarderAdaptersCount;
    for (uint256 i = 0; i < forwarderBridgeAdaptersEthereum.length; i++) {
      if (
        forwarderBridgeAdaptersEthereum[i].currentChainBridgeAdapter ==
        proposal.CCIP_ADAPTER_TO_REMOVE() ||
        forwarderBridgeAdaptersEthereum[i].currentChainBridgeAdapter ==
        proposal.LZ_ADAPTER_TO_REMOVE() ||
        forwarderBridgeAdaptersEthereum[i].currentChainBridgeAdapter ==
        proposal.HL_ADAPTER_TO_REMOVE()
      ) {
        forwarderAdaptersCount++;
      }
    }
    assertEq(forwarderAdaptersCount, forwarderBridgeAdaptersEthereum.length);
    assertEq(forwarderBridgeAdaptersEthereum.length, 3);

    assertEq(cccImplementation != proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(), true);

    defaultTest(
      'AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305',
      AaveV3Avalanche.POOL,
      address(proposal)
    );

    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.CCIP_ADAPTER_TO_REMOVE(), ChainIds.MAINNET),
      false
    );
    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.LZ_ADAPTER_TO_REMOVE(), ChainIds.MAINNET),
      false
    );
    assertEq(
      ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)
        .isReceiverBridgeAdapterAllowed(proposal.HL_ADAPTER_TO_REMOVE(), ChainIds.MAINNET),
      false
    );

    // get receiver adapters
    address[] memory receiverAdaptersAfter = ICrossChainReceiver(
      GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER
    ).getReceiverBridgeAdaptersByChain(ChainIds.MAINNET);

    // get forwarder adapters
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory forwarderBridgeAdaptersEthereumAfter = ICrossChainForwarder(
        GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER
      ).getForwarderBridgeAdaptersByChain(ChainIds.MAINNET);

    // get proxy information
    address cccImplementationAfter = ProxyAdmin(MiscAvalanche.PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER))
    );

    assertEq(cccImplementationAfter, proposal.NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION());

    uint256 receiverAdaptersCountAfter;
    for (uint256 i = 0; i < receiverAdaptersAfter.length; i++) {
      if (
        receiverAdaptersAfter[i] == proposal.CCIP_NEW_ADAPTER() ||
        receiverAdaptersAfter[i] == proposal.LZ_NEW_ADAPTER() ||
        receiverAdaptersAfter[i] == proposal.HL_NEW_ADAPTER()
      ) {
        receiverAdaptersCountAfter++;
      }
    }
    assertEq(receiverAdaptersCountAfter, receiverAdaptersAfter.length);
    assertEq(receiverAdaptersAfter.length, 3);

    uint256 forwarderAdaptersCount;
    for (uint256 i = 0; i < forwarderBridgeAdaptersEthereumAfter.length; i++) {
      if (
        forwarderBridgeAdaptersEthereumAfter[i].currentChainBridgeAdapter ==
        (proposal.CCIP_NEW_ADAPTER() &&
          forwarderBridgeAdaptersEthereumAfter[i].destinationBridgeAdapter ==
          proposal.DESTINATION_CCIP_NEW_ADAPTER()) ||
        (forwarderBridgeAdaptersEthereumAfter[i].currentChainBridgeAdapter ==
          proposal.LZ_NEW_ADAPTER() &&
          forwarderBridgeAdaptersEthereumAfter[i].destinationBridgeAdapter ==
          proposal.DESTINATION_LZ_NEW_ADAPTER()) ||
        (forwarderBridgeAdaptersEthereumAfter[i].currentChainBridgeAdapter ==
          proposal.HL_NEW_ADAPTER() &&
          forwarderBridgeAdaptersEthereumAfter[i].destinationBridgeAdapter ==
          proposal.DESTINATION_HL_NEW_ADAPTER())
      ) {
        forwarderAdaptersCount++;
      }
    }
    assertEq(forwarderAdaptersCount, forwarderBridgeAdaptersEthereumAfter.length);
    assertEq(forwarderBridgeAdaptersEthereumAfter.length, 3);
  }
}
