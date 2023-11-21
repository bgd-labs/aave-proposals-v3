// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

/**
 * @dev Test for AaveV3Avalanche_DebtTokenUpdates_20231106
 * command: make test-contract filter=AaveV3Avalanche_DebtTokenUpdates_20231106
 */
contract AaveV3Avalanche_DebtTokenUpdates_20231106_Test is ProtocolV3TestBase {
  address internal proposal = address(0x5c15edC83E044D0956fd3F845c15934aB8034BBA);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 37423983);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_DebtTokenUpdates_20231106',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }
}
