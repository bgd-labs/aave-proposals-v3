// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

/**
 * @dev Test for AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107
 * command: make test-contract filter=AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107
 */
contract AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107_Test is ProtocolV3TestBase {
  address internal proposal = address(0);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49647812);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
