// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_GHOStewardV2Upgrade_20241007} from './AaveV3Arbitrum_GHOStewardV2Upgrade_20241007.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOStewardV2Upgrade_20241007
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Arbitrum_GHOStewardV2Upgrade_20241007.t.sol -vv
 */
contract AaveV3Arbitrum_GHOStewardV2Upgrade_20241007_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_GHOStewardV2Upgrade_20241007 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 261341067);
    proposal = new AaveV3Arbitrum_GHOStewardV2Upgrade_20241007();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_GHOStewardV2Upgrade_20241007',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
