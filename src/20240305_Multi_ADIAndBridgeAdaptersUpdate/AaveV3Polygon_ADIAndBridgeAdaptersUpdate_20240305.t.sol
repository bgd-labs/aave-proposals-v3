// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Avalanche.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase, BaseTest {
  AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    ccc = GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER;
    proxyAdmin = MiscPolygon.PROXY_ADMIN;

    vm.createSelectFork(vm.rpcUrl('polygon'), 54289111);
    proposal = new AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
