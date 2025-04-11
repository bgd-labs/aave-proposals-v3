// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320} from './AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320.sol';

/**
 * @dev Test for AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320
 * command: FOUNDRY_PROFILE=metis forge test --match-path=src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320.t.sol -vv
 */
contract AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320_Test is ProtocolV3TestBase {
  AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 19964518);
    proposal = new AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320',
      AaveV3Metis.POOL,
      address(proposal)
    );
  }
}
