// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112} from './AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112.sol';

/**
 * @dev Test for AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112.t.sol -vv
 */
contract AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112_Test is ProtocolV3TestBase {
  AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 67694817);
    proposal = new AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }
}
