// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_SeptemberFundingUpdatePartA_20241020} from './AaveV3Polygon_SeptemberFundingUpdatePartA_20241020.sol';

/**
 * @dev Test for AaveV3Polygon_SeptemberFundingUpdatePartA_20241020
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20241020_Multi_SeptemberFundingUpdatePartA/AaveV3Polygon_SeptemberFundingUpdatePartA_20241020.t.sol -vv
 */
contract AaveV3Polygon_SeptemberFundingUpdatePartA_20241020_Test is ProtocolV3TestBase {
  AaveV3Polygon_SeptemberFundingUpdatePartA_20241020 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 63291551);
    proposal = new AaveV3Polygon_SeptemberFundingUpdatePartA_20241020();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_SeptemberFundingUpdatePartA_20241020',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
