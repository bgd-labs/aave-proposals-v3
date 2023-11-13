// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_WMATICInterestRateUpdate_20231112} from './AaveV3Polygon_WMATICInterestRateUpdate_20231112.sol';

/**
 * @dev Test for AaveV3Polygon_WMATICInterestRateUpdate_20231112
 * command: make test-contract filter=AaveV3Polygon_WMATICInterestRateUpdate_20231112
 */
contract AaveV3Polygon_WMATICInterestRateUpdate_20231112_Test is ProtocolV3TestBase {
  AaveV3Polygon_WMATICInterestRateUpdate_20231112 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49901774);
    proposal = AaveV3Polygon_WMATICInterestRateUpdate_20231112(0xF07633d14da9Dbca112ddE58C6d585CA8F4e845D);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_WMATICInterestRateUpdate_20231112',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
