// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3XLayer} from 'aave-address-book/AaveV3XLayer.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3XLayer_GhoXLayerActivation_20260203} from '../AaveV3XLayer_GhoXLayerActivation_20260203.sol';

/**
 * @dev Test for AaveV3Mantle_GhoMantleActivation_20260105
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260203_Multi_GhoXLayerActivation/tests/AaveV3XLayer_GhoXLayerActivation_20260203.t.sol -vv
 */
contract AaveV3XLayer_GhoXLayerActivation_20260203_Test is ProtocolV3TestBase {
  AaveV3XLayer_GhoXLayerActivation_20260203 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('xlayer'), 54420880);
    proposal = new AaveV3XLayer_GhoXLayerActivation_20260203();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3XLayer_GhoXLayerActivation_20260203',
      AaveV3XLayer.POOL,
      address(proposal),
      false,
      false
    );
  }
}
