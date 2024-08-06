// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {SnapshotHelpersV3} from 'aave-helpers/zksync/src/SnapshotHelpersV3.sol';
import {AaveV3ZkSync_AaveV3ZkSyncActivation_20240805} from './AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';

/**
 * @dev Test for AaveV3ZkSync_AaveV3ZkSyncActivation_20240805
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_Snapshot_20240805.t.sol -vv
 */
contract AaveV3ZkSync_AaveV3ZkSyncActivation_Snapshot_20240805_Test is SnapshotHelpersV3 {
  AaveV3ZkSync_AaveV3ZkSyncActivation_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('zksync'), 40933332);
    proposal = new AaveV3ZkSync_AaveV3ZkSyncActivation_20240805();

    // TODO: remove later
    _transferPermission();
  }

  /**
   * @dev executes the config snapshots
   */
  function test_defaultGenerateReport() public {
    generateDiffReport(
      'AaveV3ZkSync_AaveV3ZkSyncActivation_20240805',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function _transferPermission() internal {
    // transfer executor ownership to payloads controller
    vm.startPrank(0x6ec33534BE07d45cc4E02Fbd127F8ed2aE919a6b);
    IOwnable(0x04cE39789e11a49595cD0ECEf6f4Bd54ABF4d020).transferOwnership(
      0x2E79349c3F5e4751E87b966812C9E65E805996F1
    );
    vm.stopPrank();
  }
}
