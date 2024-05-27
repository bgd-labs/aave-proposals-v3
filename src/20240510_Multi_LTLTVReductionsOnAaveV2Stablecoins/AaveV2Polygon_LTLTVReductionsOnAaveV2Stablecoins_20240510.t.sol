// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510} from './AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510.sol';

/**
 * @dev Test for AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20240510_Multi_LTLTVReductionsOnAaveV2Stablecoins/AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510.t.sol -vv
 */
contract AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510_Test is ProtocolV2TestBase {
  AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 56811637);
    proposal = new AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510',
      AaveV2Polygon.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);

    assetsChanged[0] = AaveV2PolygonAssets.USDC_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory USDC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2PolygonAssets.USDC_UNDERLYING
    );
    USDC_UNDERLYING_CONFIG.ltv = 75_00;
    USDC_UNDERLYING_CONFIG.liquidationThreshold = 84_50;
    _validateReserveConfig(USDC_UNDERLYING_CONFIG, allConfigsAfter);
  }
}
