// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106} from './AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @dev Test for AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106
 * command: make test-contract filter=AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106
 */
contract AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106_Test is ProtocolV3TestBase {
  AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49616556);
    proposal = new AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106',
      AaveV3Polygon.POOL,
      address(proposal)
    );

    ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.CRV_UNDERLYING
    );
    CRV_UNDERLYING_CONFIG.liquidationThreshold = 50_00;
    _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);
  }
}
