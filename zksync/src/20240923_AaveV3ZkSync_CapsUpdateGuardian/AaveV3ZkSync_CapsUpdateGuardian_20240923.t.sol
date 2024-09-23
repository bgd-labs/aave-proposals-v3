// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {MiscZkSync} from 'aave-address-book/MiscZkSync.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_CapsUpdateGuardian_20240923} from './AaveV3ZkSync_CapsUpdateGuardian_20240923.sol';

/**
 * @dev Test for AaveV3ZkSync_CapsUpdateGuardian_20240923
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20240923_AaveV3ZkSync_CapsUpdateGuardian/AaveV3ZkSync_CapsUpdateGuardian_20240923.t.sol -vv
 */
contract AaveV3ZkSync_CapsUpdateGuardian_20240923_Test is ProtocolV3TestBase {
  AaveV3ZkSync_CapsUpdateGuardian_20240923 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 44894485);
    proposal = new AaveV3ZkSync_CapsUpdateGuardian_20240923();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3ZkSync_CapsUpdateGuardian_20240923', AaveV3ZkSync.POOL, address(proposal));
  }

  function test_executionByGuardian() public {
    vm.startPrank(MiscZkSync.PROTOCOL_GUARDIAN);
    proposal.execute();
    vm.stopPrank();
  }
}
