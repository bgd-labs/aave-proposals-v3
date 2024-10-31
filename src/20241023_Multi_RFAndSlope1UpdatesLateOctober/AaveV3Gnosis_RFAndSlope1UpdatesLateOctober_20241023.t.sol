// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_RFAndSlope1UpdatesLateOctober_20241023} from './AaveV3Gnosis_RFAndSlope1UpdatesLateOctober_20241023.sol';

/**
 * @dev Test for AaveV3Gnosis_RFAndSlope1UpdatesLateOctober_20241023
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20241023_Multi_RFAndSlope1UpdatesLateOctober/AaveV3Gnosis_RFAndSlope1UpdatesLateOctober_20241023.t.sol -vv
 */
contract AaveV3Gnosis_RFAndSlope1UpdatesLateOctober_20241023_Test is ProtocolV3TestBase {
  AaveV3Gnosis_RFAndSlope1UpdatesLateOctober_20241023 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 36654660);
    proposal = new AaveV3Gnosis_RFAndSlope1UpdatesLateOctober_20241023();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_RFAndSlope1UpdatesLateOctober_20241023',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
