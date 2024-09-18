// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Avalanche_RescueTokensFromAdapters_20240916} from './AaveV2Avalanche_RescueTokensFromAdapters_20240916.sol';

/**
 * @dev Test for AaveV2Avalanche_RescueTokensFromAdapters_20240916
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240912_Multi_RescueTokensFromAdapters/AaveV2Avalanche_RescueTokensFromAdapters_20240916.t.sol -vv
 */
contract AaveV2Avalanche_RescueTokensFromAdapters_20240916_Test is ProtocolV2TestBase {
  AaveV2Avalanche_RescueTokensFromAdapters_20240916 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 50442196);
    proposal = new AaveV2Avalanche_RescueTokensFromAdapters_20240916();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_RescueTokensFromAdapters_20240916',
      AaveV2Avalanche.POOL,
      address(proposal)
    );
  }
}
