// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {ProtocolV3TestBase} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928} from './AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol';

/**
 * @dev Test for AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.t.sol -vv
 */
contract AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Test is
  ProtocolV3TestBase
{
  AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 64934655);
    proposal = new AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function test_sentinelConfigured() public {
    executePayload(vm, address(proposal));

    assertEq(
      AaveV3ZkSync.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel(),
      proposal.PRICE_ORACLE_SENTINEL()
    );
  }
}
