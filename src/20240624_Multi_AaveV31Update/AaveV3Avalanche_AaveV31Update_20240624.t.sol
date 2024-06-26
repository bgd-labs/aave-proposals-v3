// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {Payloads} from './AaveV31Update_20240624.s.sol';

/**
 * @dev Test for AaveV3Avalanche_AaveV31Update_20240624
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240624_Multi_AaveV31Update/AaveV3Avalanche_AaveV31Update_20240624.t.sol -vv
 */
contract AaveV3Avalanche_AaveV31Update_20240624_Test is ProtocolV3TestBase {
  address internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 47114314);
    proposal = Payloads.AaveV3Avalanche;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Avalanche_AaveV31Update_20240624', AaveV3Avalanche.POOL, address(proposal));
  }
}
