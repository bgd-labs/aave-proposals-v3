// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112} from './AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112.sol';

/**
 * @dev Test for AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112.t.sol -vv
 */
contract AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112_Test is ProtocolV3TestBase {
  AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('celo'), 56278094);
    proposal = new AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112',
      AaveV3Celo.POOL,
      address(proposal)
    );
  }
}
