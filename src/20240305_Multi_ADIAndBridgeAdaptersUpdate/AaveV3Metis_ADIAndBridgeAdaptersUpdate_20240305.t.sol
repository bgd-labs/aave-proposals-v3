// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Avalanche.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    ccc = GovernanceV3Metis.CROSS_CHAIN_CONTROLLER;
    proxyAdmin = MiscMetis.PROXY_ADMIN;

    vm.createSelectFork(vm.rpcUrl('metis'), 14662925);
    proposal = new AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305',
      AaveV3Metis.POOL,
      address(proposal)
    );
  }
}
