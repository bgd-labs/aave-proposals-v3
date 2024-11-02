// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.sol';

/**
 * @dev Test for AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101_Test is ProtocolV3TestBase {
  AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 43627345);
    proposal = new AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101', AaveV3BNB.POOL, address(proposal));
  }
}
