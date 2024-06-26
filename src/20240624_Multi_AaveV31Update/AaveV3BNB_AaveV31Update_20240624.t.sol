// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {Payloads} from './AaveV31Update_20240624.s.sol';

/**
 * @dev Test for AaveV3BNB_AaveV31Update_20240624
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20240624_Multi_AaveV31Update/AaveV3BNB_AaveV31Update_20240624.t.sol -vv
 */
contract AaveV3BNB_AaveV31Update_20240624_Test is ProtocolV3TestBase {
  address internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 39885953);
    proposal = Payloads.AaveV3BNB;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_AaveV31Update_20240624', AaveV3BNB.POOL, address(proposal));
  }
}
