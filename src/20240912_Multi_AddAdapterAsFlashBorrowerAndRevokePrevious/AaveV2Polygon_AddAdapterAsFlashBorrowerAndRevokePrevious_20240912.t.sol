// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912} from './AaveV2Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912.sol';

/**
 * @dev Test for AaveV2Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20240912_Multi_AddAdapterAsFlashBorrowerAndRevokePrevious/AaveV2Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912.t.sol -vv
 */
contract AaveV2Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912_Test is
  ProtocolV2TestBase
{
  AaveV2Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 61736270);
    proposal = new AaveV2Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912',
      AaveV2Polygon.POOL,
      address(proposal)
    );
  }
}
