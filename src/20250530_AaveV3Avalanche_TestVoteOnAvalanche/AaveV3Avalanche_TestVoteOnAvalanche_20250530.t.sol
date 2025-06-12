// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_TestVoteOnAvalanche_20250530} from './AaveV3Avalanche_TestVoteOnAvalanche_20250530.sol';

/**
 * @dev Test for AaveV3Avalanche_TestVoteOnAvalanche_20250530
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250530_AaveV3Avalanche_TestVoteOnAvalanche/AaveV3Avalanche_TestVoteOnAvalanche_20250530.t.sol -vv
 */
/// forge-config: default.evm_version = 'cancun'
contract AaveV3Avalanche_TestVoteOnAvalanche_20250530_Test is ProtocolV3TestBase {
  AaveV3Avalanche_TestVoteOnAvalanche_20250530 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 63005641);
    proposal = new AaveV3Avalanche_TestVoteOnAvalanche_20250530();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_TestVoteOnAvalanche_20250530',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }
}
