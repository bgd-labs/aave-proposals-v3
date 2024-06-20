// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620} from './AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620.sol';

/**
 * @dev Test for AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240620_AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork/AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620.t.sol -vv
 */
contract AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620_Test is
  ProtocolV3TestBase
{
  AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 46972185);
    proposal = new AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }
}
