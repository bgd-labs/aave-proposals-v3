// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612} from './AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612.sol';

/**
 * @dev Test for AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612.t.sol -vv
 */
contract AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612_Test is ProtocolV3TestBase {
  AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 39559153);
    proposal = new AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }
}
