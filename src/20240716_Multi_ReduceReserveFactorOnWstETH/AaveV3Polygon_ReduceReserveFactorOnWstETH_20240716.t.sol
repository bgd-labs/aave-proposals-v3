// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716} from './AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716.sol';

/**
 * @dev Test for AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716.t.sol -vv
 */
contract AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716_Test is ProtocolV3TestBase {
  AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 59439039);
    proposal = new AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_ReduceReserveFactorOnWstETH_20240716',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
