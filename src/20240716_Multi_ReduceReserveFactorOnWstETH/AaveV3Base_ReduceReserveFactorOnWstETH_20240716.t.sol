// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_ReduceReserveFactorOnWstETH_20240716} from './AaveV3Base_ReduceReserveFactorOnWstETH_20240716.sol';

/**
 * @dev Test for AaveV3Base_ReduceReserveFactorOnWstETH_20240716
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Base_ReduceReserveFactorOnWstETH_20240716.t.sol -vv
 */
contract AaveV3Base_ReduceReserveFactorOnWstETH_20240716_Test is ProtocolV3TestBase {
  AaveV3Base_ReduceReserveFactorOnWstETH_20240716 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 17182417);
    proposal = new AaveV3Base_ReduceReserveFactorOnWstETH_20240716();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_ReduceReserveFactorOnWstETH_20240716',
      AaveV3Base.POOL,
      address(proposal)
    );
  }
}
