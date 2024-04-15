// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415} from './AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415.sol';

/**
 * @dev Test for AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415
 * command: make test-contract filter=AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415
 */
contract AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415_Test is ProtocolV3TestBase {
  AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 118786899);
    proposal = new AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415',
      AaveV3Optimism.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3OptimismAssets.OP_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory config = _findReserveConfig(
      allConfigsAfter,
      AaveV3OptimismAssets.OP_UNDERLYING
    );
    assertEq(config.ltv, 50_00);
    assertEq(config.liquidationThreshold, 60_00);
  }
}
