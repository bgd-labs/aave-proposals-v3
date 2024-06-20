// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612} from './AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612.sol';

/**
 * @dev Test for AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612
 * command: FOUNDRY_PROFILE=scroll forge test --match-path=src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612.t.sol -vv
 */
contract AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612_Test is ProtocolV3TestBase {
  AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 6508767);
    proposal = new AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }
}
