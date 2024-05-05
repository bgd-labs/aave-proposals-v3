// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415} from './AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415.sol';

/**
 * @dev Test for AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415
 * command: make test-contract filter=AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415
 */
contract AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415_Test is ProtocolV3TestBase {
  AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 33455007);
    proposal = new AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415',
      AaveV3Gnosis.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3GnosisAssets.GNO_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory config = _findReserveConfig(
      allConfigsAfter,
      AaveV3GnosisAssets.GNO_UNDERLYING
    );
    assertEq(config.ltv, 45_00);
    assertEq(config.liquidationThreshold, 50_00);
    assertEq(config.debtCeiling, 2_000_000_00);
  }
}
