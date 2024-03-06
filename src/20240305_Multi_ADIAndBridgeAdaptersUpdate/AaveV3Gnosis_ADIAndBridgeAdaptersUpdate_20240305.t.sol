// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Avalanche.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    ccc = GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER;
    proxyAdmin = MiscGnosis.PROXY_ADMIN;

    vm.createSelectFork(vm.rpcUrl('gnosis'), 32774450);
    proposal = new AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
