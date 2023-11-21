// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117} from './AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117.sol';

/**
 * @dev Test for AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117
 * command: make test-contract filter=AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117
 */
contract AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117_Test is
  ProtocolV3TestBase
{
  AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 50068954);
    proposal = new AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
