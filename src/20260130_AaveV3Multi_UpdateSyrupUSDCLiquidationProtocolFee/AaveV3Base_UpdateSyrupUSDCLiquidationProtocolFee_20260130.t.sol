// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130} from './AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130.sol';

/**
 * @dev Test for AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260130_AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee/AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130.t.sol -vv
 */
contract AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130_Test is ProtocolV3TestBase {
  AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 41503591);
    proposal = new AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_syrupUSDC_LiquidationProtocolFee() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 liquidationProtocolFee = AaveV3Base
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getLiquidationProtocolFee(AaveV3BaseAssets.syrupUSDC_UNDERLYING);
    assertEq(liquidationProtocolFee, 1000);
  }
}
