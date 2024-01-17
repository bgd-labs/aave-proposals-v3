// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221} from './AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221.sol';

/**
 * @dev Test for AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221
 * command: make test-contract filter=AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221
 */
contract AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221_Test is
  ProtocolV2TestBase
{
  AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 39322994);
    proposal = new AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221',
      AaveV2Avalanche.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV2AvalancheAssets.WBTCe_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory configAfter = _findReserveConfig(allConfigsAfter, assetsChanged[0]);

    assertEq(configAfter.ltv, 0);
    assertEq(configAfter.liquidationThreshold, 70_00);
    assertEq(configAfter.liquidationBonus, 105_00);
    assertEq(configAfter.isFrozen, true);
  }
}
