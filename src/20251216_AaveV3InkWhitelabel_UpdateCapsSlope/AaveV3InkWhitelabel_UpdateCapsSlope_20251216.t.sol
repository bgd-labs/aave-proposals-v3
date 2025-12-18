// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_UpdateCapsSlope_20251216} from './AaveV3InkWhitelabel_UpdateCapsSlope_20251216.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_UpdateCapsSlope_20251216
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251216_AaveV3InkWhitelabel_UpdateCapsSlope/AaveV3InkWhitelabel_UpdateCapsSlope_20251216.t.sol -vv
 */
contract AaveV3InkWhitelabel_UpdateCapsSlope_20251216_Test is ProtocolV3TestBase {
  AaveV3InkWhitelabel_UpdateCapsSlope_20251216 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 32390733);
    proposal = new AaveV3InkWhitelabel_UpdateCapsSlope_20251216();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_UpdateCapsSlope_20251216',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }
}
