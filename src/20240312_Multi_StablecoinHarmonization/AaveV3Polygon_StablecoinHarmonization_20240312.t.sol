// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_StablecoinHarmonization_20240312} from './AaveV3Polygon_StablecoinHarmonization_20240312.sol';

/**
 * @dev Test for AaveV3Polygon_StablecoinHarmonization_20240312
 * command: make test-contract filter=AaveV3Polygon_StablecoinHarmonization_20240312
 */
contract AaveV3Polygon_StablecoinHarmonization_20240312_Test is ProtocolV3TestBase {
  AaveV3Polygon_StablecoinHarmonization_20240312 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 54552463);
    proposal = new AaveV3Polygon_StablecoinHarmonization_20240312();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_StablecoinHarmonization_20240312',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
