// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205} from './AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205.sol';

/**
 * @dev Test for AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205
 * command: make test-contract filter=AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205
 */
contract AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205_Test is
  ProtocolV2TestBase
{
  AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 50773537);
    proposal = new AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205',
      AaveV2Polygon.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](6);

    assetsChanged[0] = AaveV2PolygonAssets.SUSHI_UNDERLYING;
    assetsChanged[1] = AaveV2PolygonAssets.DPI_UNDERLYING;
    assetsChanged[2] = AaveV2PolygonAssets.BAL_UNDERLYING;
    assetsChanged[3] = AaveV2PolygonAssets.CRV_UNDERLYING;
    assetsChanged[4] = AaveV2PolygonAssets.GHST_UNDERLYING;
    assetsChanged[5] = AaveV2PolygonAssets.LINK_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory SUSHI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2PolygonAssets.SUSHI_UNDERLYING
      );
      SUSHI_UNDERLYING_CONFIG.liquidationThreshold = 5;
      SUSHI_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(SUSHI_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory DPI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2PolygonAssets.DPI_UNDERLYING
      );
      DPI_UNDERLYING_CONFIG.liquidationThreshold = 5;
      DPI_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(DPI_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory BAL_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2PolygonAssets.BAL_UNDERLYING
      );
      BAL_UNDERLYING_CONFIG.liquidationThreshold = 5;
      BAL_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(BAL_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2PolygonAssets.CRV_UNDERLYING
      );
      CRV_UNDERLYING_CONFIG.liquidationThreshold = 5;
      CRV_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory GHST_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2PolygonAssets.GHST_UNDERLYING
      );
      GHST_UNDERLYING_CONFIG.liquidationThreshold = 5;
      GHST_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(GHST_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory LINK_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2PolygonAssets.LINK_UNDERLYING
      );
      LINK_UNDERLYING_CONFIG.liquidationThreshold = 5;
      LINK_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(LINK_UNDERLYING_CONFIG, allConfigsAfter);
    }
  }
}
