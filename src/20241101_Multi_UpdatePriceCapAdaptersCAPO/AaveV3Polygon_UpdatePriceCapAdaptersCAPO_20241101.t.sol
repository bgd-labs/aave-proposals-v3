// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.sol';

/**
 * @dev Test for AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101_Test is ProtocolV3TestBase {
  AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 63754354);
    proposal = new AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
