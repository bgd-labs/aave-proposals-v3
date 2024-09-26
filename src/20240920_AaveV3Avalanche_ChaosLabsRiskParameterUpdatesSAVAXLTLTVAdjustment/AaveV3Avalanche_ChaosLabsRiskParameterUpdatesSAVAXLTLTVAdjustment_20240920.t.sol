// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920} from './AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920.sol';

/**
 * @dev Test for AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240920_AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment/AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920.t.sol -vv
 */
contract AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920_Test is
  ProtocolV3TestBase
{
  AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 50773736);
    proposal = new AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }
}
