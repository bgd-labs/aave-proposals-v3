// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

/**
 * @dev Test for AaveV2Avalanche_MultichainStableDebtTokenUpgrades_20231107
 * command: make test-contract filter=AaveV2Avalanche_MultichainStableDebtTokenUpgrades_20231107
 */
contract AaveV2Avalanche_MultichainStableDebtTokenUpgrades_20231107_Test is ProtocolV2TestBase {
  address internal proposal = address(0xD61BF98649EA8F8D09e184184777b1867F00E5CB);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 37456030);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_MultichainStableDebtTokenUpgradesSentinel_20231107',
      AaveV2Avalanche.POOL,
      address(0xD61BF98649EA8F8D09e184184777b1867F00E5CB)
    );
  }
}
