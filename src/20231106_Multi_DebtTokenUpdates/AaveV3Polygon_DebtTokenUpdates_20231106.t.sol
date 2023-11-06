// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

/**
 * @dev Test for AaveV3Polygon_DebtTokenUpdates_20231106
 * command: make test-contract filter=AaveV3Polygon_DebtTokenUpdates_20231106
 */
contract AaveV3Polygon_DebtTokenUpdates_20231106_Test is ProtocolV3TestBase {
  address internal proposal = address(0x9CbC0C27Fd72e78b6e297ABb5A54f0faAde59180);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49625199);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Polygon_DebtTokenUpdates_20231106', AaveV3Polygon.POOL, address(proposal));
  }
}
