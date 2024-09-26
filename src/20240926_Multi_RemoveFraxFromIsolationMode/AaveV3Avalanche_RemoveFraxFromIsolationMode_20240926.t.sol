// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926} from './AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926.sol';

/**
 * @dev Test for AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240926_Multi_RemoveFraxFromIsolationMode/AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926.t.sol -vv
 */
contract AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926_Test is ProtocolV3TestBase {
  AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 51028150);
    proposal = new AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }
}
