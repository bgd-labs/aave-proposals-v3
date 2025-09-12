// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912} from './AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912.sol';

/**
 * @dev Test for AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250912_AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance/AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912.t.sol -vv
 */
contract AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912_Test is
  ProtocolV3TestBase
{
  AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 21105921);
    proposal = new AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }
}
