// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {ActivationPayload_20250228} from './ActivationPayload_20250228.sol';
import {Stewards, Bots} from './ClinicStewardActivation_20250228.s.sol';

/**
 * @dev Test for AaveV3Arbitrum_ClinicStewardActivation_20250228
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250228_Multi_ClinicStewardActivation/AaveV3Arbitrum_ClinicStewardActivation_20250228.t.sol -vv
 */
contract ActivationPayload_20250228_Test is ProtocolV3TestBase {
  ActivationPayload_20250228 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 310733493);
    proposal = new ActivationPayload_20250228(
      address(AaveV3Arbitrum.COLLECTOR),
      Stewards.ARBITRUM,
      Bots.ARBITRUM
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('ActivationPayload_20250228', AaveV3Arbitrum.POOL, address(proposal));

    // TODO: test permissions are set correctly
  }
}
