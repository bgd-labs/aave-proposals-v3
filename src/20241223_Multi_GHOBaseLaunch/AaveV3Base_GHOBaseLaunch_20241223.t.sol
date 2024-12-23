// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_GHOBaseLaunch_20241223} from './AaveV3Base_GHOBaseLaunch_20241223.sol';

/**
 * @dev Test for AaveV3Base_GHOBaseLaunch_20241223
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241223_Multi_GHOBaseLaunch/AaveV3Base_GHOBaseLaunch_20241223.t.sol -vv
 */
contract AaveV3Base_GHOBaseLaunch_20241223_Test is ProtocolV3TestBase {
  AaveV3Base_GHOBaseLaunch_20241223 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 24072751);
    proposal = new AaveV3Base_GHOBaseLaunch_20241223(
      address(0),
      address(0),
      address(0),
      address(0),
      address(0)
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_GHOBaseLaunch_20241223', AaveV3Base.POOL, address(proposal));
  }
}
