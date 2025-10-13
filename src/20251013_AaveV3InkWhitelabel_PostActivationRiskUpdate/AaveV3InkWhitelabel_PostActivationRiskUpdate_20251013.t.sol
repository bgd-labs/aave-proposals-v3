// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013} from './AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251013_AaveV3InkWhitelabel_PostActivationRiskUpdate/AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013.t.sol -vv
 */
contract AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013_Test is ProtocolV3TestBase {
  AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 26846519);
    proposal = new AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }
}
