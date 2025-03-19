// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311} from './AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311.sol';

/**
 * @dev Test for AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20250311_AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance/AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311.t.sol -vv
 */
contract AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311_Test is ProtocolV3TestBase {
  AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 39102561);
    proposal = new AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_EnhancementsInAaveV3GnosisChainInstance_20250311',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
