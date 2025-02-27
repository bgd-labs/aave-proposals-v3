// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213} from './AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213.sol';

/**
 * @dev Test for AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250213_Multi_SUSDeAndUSDePriceFeedUpdate/AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213.t.sol -vv
 */
contract AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213_Test is ProtocolV3TestBase {
  AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 55890667);
    proposal = new AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }
}
