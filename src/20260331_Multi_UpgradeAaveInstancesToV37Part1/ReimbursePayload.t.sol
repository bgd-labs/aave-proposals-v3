// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {ReimbursePayload} from './ReimbursePayload.sol';

/**
 * @dev Test for ReimbursePayload
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part1/ReimbursePayload.t.sol -vv
 */
contract ReimbursePayload_Test is ProtocolV3TestBase {
  ReimbursePayload internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24780007);
    proposal = new ReimbursePayload();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('ReimbursePayload', AaveV3Ethereum.POOL, address(proposal));
  }
}
