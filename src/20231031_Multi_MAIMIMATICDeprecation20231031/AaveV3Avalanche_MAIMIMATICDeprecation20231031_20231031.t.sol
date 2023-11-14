// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031} from './AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031.sol';

/**
 * @dev Test for AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031
 * command: make test-contract filter=AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031
 */
contract AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031_Test is ProtocolV3TestBase {
  AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 37728010);
    proposal = new AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }
}
