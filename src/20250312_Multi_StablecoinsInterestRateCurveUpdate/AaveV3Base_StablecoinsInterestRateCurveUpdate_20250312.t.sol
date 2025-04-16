// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312} from './AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312.sol';

/**
 * @dev Test for AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312.t.sol -vv
 */
contract AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312_Test is ProtocolV3TestBase {
  AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 27505200);
    proposal = new AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312',
      AaveV3Base.POOL,
      address(proposal)
    );
  }
}
