// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004} from './AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004.sol';

/**
 * @dev Test for AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004.t.sol -vv
 */
contract AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 262378595);
    proposal = new AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_ReserveFactorUpdatesMidOctober_20241004',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
