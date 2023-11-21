// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

/**
 * @dev Test for AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107
 * command: make test-contract filter=AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107
 */
contract AaveV3Polygon_MultichainStableDebtTokenUpgrades_20231107_Test is ProtocolV3TestBase {
  address internal proposal = address(0x79bdFC73c39Ce05051959a87D78deA6B193ADcf8);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49657792);
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

/**
 * @dev Test for AaveV2Polygon_MultichainStableDebtTokenUpgradesSentinel_20231107
 * command: make test-contract filter=AaveV2Polygon_MultichainStableDebtTokenUpgradesSentinel_20231107
 */
contract AaveV2Polygon_MultichainStableDebtTokenUpgradesSentinel_20231107_Test is
  ProtocolV2TestBase
{
  address internal proposal = address(0x2cC18D5Be60bFE2D7F3016524d2E4F1653Afeb60);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49657792);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Polygon_MultichainStableDebtTokenUpgrades_20231107',
      AaveV2Polygon.POOL,
      address(proposal)
    );
  }
}
