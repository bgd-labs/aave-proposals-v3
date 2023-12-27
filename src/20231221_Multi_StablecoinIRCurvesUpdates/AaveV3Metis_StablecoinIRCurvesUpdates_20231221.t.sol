// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Metis_StablecoinIRCurvesUpdates_20231221} from './AaveV3Metis_StablecoinIRCurvesUpdates_20231221.sol';

/**
 * @dev Test for AaveV3Metis_StablecoinIRCurvesUpdates_20231221
 * command: make test-contract filter=AaveV3Metis_StablecoinIRCurvesUpdates_20231221
 */
contract AaveV3Metis_StablecoinIRCurvesUpdates_20231221_Test is ProtocolV3TestBase {
  AaveV3Metis_StablecoinIRCurvesUpdates_20231221 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 10103586);
    proposal = new AaveV3Metis_StablecoinIRCurvesUpdates_20231221();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_StablecoinIRCurvesUpdates_20231221',
      AaveV3Metis.POOL,
      address(proposal)
    );
  }
}
