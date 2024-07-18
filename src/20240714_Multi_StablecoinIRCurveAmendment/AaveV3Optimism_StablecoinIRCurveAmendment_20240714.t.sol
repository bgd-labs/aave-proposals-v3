// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_StablecoinIRCurveAmendment_20240714} from './AaveV3Optimism_StablecoinIRCurveAmendment_20240714.sol';

/**
 * @dev Test for AaveV3Optimism_StablecoinIRCurveAmendment_20240714
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Optimism_StablecoinIRCurveAmendment_20240714.t.sol -vv
 */
contract AaveV3Optimism_StablecoinIRCurveAmendment_20240714_Test is ProtocolV3TestBase {
  AaveV3Optimism_StablecoinIRCurveAmendment_20240714 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 122693669);
    proposal = new AaveV3Optimism_StablecoinIRCurveAmendment_20240714();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_StablecoinIRCurveAmendment_20240714',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
