// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_EnableBalancerClaimer_20250115} from './AaveV3Gnosis_EnableBalancerClaimer_20250115.sol';

/**
 * @dev Test for AaveV3Gnosis_EnableBalancerClaimer_20250115
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20250115_Multi_EnableBalancerClaimer/AaveV3Gnosis_EnableBalancerClaimer_20250115.t.sol -vv
 */
contract AaveV3Gnosis_EnableBalancerClaimer_20250115_Test is ProtocolV3TestBase {
  AaveV3Gnosis_EnableBalancerClaimer_20250115 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 38060179);
    proposal = new AaveV3Gnosis_EnableBalancerClaimer_20250115();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_EnableBalancerClaimer_20250115',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
