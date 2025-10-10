// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007} from './AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007.sol';

/**
 * @dev Test for AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251007_AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance/AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007.t.sol -vv
 */
contract AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007_Test is
  ProtocolV3TestBase
{
  AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 36535639);
    proposal = new AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007',
      AaveV3Base.POOL,
      address(proposal)
    );
  }
}
