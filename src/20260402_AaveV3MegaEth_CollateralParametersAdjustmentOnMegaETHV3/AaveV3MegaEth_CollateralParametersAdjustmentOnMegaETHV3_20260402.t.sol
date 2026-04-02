// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MegaEth} from 'aave-address-book/AaveV3MegaEth.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402} from './AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402.sol';

/**
 * @dev Test for AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260402_AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3/AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402.t.sol -vv
 */
contract AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402_Test is
  ProtocolV3TestBase
{
  AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('megaeth'), 12348425);
    proposal = new AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402',
      AaveV3MegaEth.POOL,
      address(proposal)
    );
  }
}
