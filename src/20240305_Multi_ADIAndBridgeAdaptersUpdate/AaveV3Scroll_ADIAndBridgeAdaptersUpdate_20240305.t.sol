// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Avalanche.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    ccc = GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER;
    proxyAdmin = MiscScroll.PROXY_ADMIN;

    vm.createSelectFork(vm.rpcUrl('scroll'), 3863980);
    proposal = new AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }
}
