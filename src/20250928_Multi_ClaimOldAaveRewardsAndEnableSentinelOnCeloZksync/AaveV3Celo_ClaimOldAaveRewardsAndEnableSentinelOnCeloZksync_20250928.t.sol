// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928} from './AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.sol';

/**
 * @dev Test for AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250928_Multi_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync/AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928.t.sol -vv
 */
contract AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928_Test is
  ProtocolV3TestBase
{
  AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('celo'), 47164416);
    proposal = new AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928',
      AaveV3Celo.POOL,
      address(proposal)
    );
  }

  function test_sentinelConfigured() public {
    executePayload(vm, address(proposal));

    assertEq(
      AaveV3Celo.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel(),
      proposal.PRICE_ORACLE_SENTINEL()
    );
  }
}
