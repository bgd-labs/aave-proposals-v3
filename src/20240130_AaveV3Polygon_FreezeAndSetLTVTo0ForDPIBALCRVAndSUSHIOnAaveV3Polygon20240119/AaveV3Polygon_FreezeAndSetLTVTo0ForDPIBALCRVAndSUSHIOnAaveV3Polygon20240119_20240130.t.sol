// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130} from './AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130.sol';

/**
 * @dev Test for AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130
 * command: make test-contract filter=AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130
 */
contract AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130_Test is
  ProtocolV3TestBase
{
  AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 52940636);
    proposal = new AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
