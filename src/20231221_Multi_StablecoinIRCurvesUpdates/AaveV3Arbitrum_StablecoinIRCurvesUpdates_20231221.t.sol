// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221} from './AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221.sol';

/**
 * @dev Test for AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221
 * command: make test-contract filter=AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221
 */
contract AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 164209360);
    proposal = new AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
