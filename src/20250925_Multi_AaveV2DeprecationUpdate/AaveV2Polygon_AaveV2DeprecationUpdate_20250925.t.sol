// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Polygon_AaveV2DeprecationUpdate_20250925} from './AaveV2Polygon_AaveV2DeprecationUpdate_20250925.sol';

/**
 * @dev Test for AaveV2Polygon_AaveV2DeprecationUpdate_20250925
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250925.t.sol -vv
 */
contract AaveV2Polygon_AaveV2DeprecationUpdate_20250925_Test is ProtocolV2TestBase {
  AaveV2Polygon_AaveV2DeprecationUpdate_20250925 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 76860330);
    proposal = new AaveV2Polygon_AaveV2DeprecationUpdate_20250925();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Polygon_AaveV2DeprecationUpdate_20250925',
      AaveV2Polygon.POOL,
      address(proposal)
    );
  }
}
