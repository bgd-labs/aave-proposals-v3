// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_SUSDRiskParameterAdjustment_20250220} from './AaveV3Optimism_SUSDRiskParameterAdjustment_20250220.sol';

/**
 * @dev Test for AaveV3Optimism_SUSDRiskParameterAdjustment_20250220
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20250220_AaveV3Optimism_SUSDRiskParameterAdjustment/AaveV3Optimism_SUSDRiskParameterAdjustment_20250220.t.sol -vv
 */
contract AaveV3Optimism_SUSDRiskParameterAdjustment_20250220_Test is ProtocolV3TestBase {
  AaveV3Optimism_SUSDRiskParameterAdjustment_20250220 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 132221425);
    proposal = new AaveV3Optimism_SUSDRiskParameterAdjustment_20250220();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_SUSDRiskParameterAdjustment_20250220',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
