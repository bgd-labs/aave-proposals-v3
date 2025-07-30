// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722} from './AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722.sol';

/**
 * @dev Test for AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250722_Multi_WSAndBTCBInterestRateCurveOptimization/AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722.t.sol -vv
 */
contract AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722_Test is ProtocolV3TestBase {
  AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 39723500);
    proposal = new AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722',
      AaveV3Sonic.POOL,
      address(proposal)
    );
  }
}
