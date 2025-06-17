// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_TestVoteOnEthereum_20250530} from './AaveV3Ethereum_TestVoteOnEthereum_20250530.sol';

/**
 * @dev Test for AaveV3Ethereum_TestVoteOnEthereum_20250530
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250530_AaveV3Ethereum_TestVoteOnEthereum/AaveV3Ethereum_TestVoteOnEthereum_20250530.t.sol -vv
 */
/// forge-config: default.evm_version = 'cancun'
contract AaveV3Ethereum_TestVoteOnEthereum_20250530_Test is ProtocolV3TestBase {
  AaveV3Ethereum_TestVoteOnEthereum_20250530 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22595989);
    proposal = new AaveV3Ethereum_TestVoteOnEthereum_20250530();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_TestVoteOnEthereum_20250530',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
