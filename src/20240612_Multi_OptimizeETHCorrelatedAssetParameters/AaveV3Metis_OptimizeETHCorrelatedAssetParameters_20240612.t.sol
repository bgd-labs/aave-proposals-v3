// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612} from './AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612.sol';

/**
 * @dev Test for AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612
 * command: FOUNDRY_PROFILE=metis forge test --match-path=src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612.t.sol -vv
 */
contract AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612_Test is ProtocolV3TestBase {
  AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 17329826);
    proposal = new AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612',
      AaveV3Metis.POOL,
      address(proposal)
    );
  }
}
