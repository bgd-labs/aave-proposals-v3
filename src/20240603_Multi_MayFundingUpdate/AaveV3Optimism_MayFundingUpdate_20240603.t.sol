// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_MayFundingUpdate_20240603} from './AaveV3Optimism_MayFundingUpdate_20240603.sol';

/**
 * @dev Test for AaveV3Optimism_MayFundingUpdate_20240603
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240603_Multi_MayFundingUpdate/AaveV3Optimism_MayFundingUpdate_20240603.t.sol -vv
 */
contract AaveV3Optimism_MayFundingUpdate_20240603_Test is ProtocolV3TestBase {
  AaveV3Optimism_MayFundingUpdate_20240603 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 120915803);
    proposal = new AaveV3Optimism_MayFundingUpdate_20240603();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Optimism_MayFundingUpdate_20240603', AaveV3Optimism.POOL, address(proposal));
  }
}
