// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103} from './AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103.sol';

/**
 * @dev Test for AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103
 * command: make test-contract filter=AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103
 */
contract AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103_Test is ProtocolV2TestBase {
  AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103 internal proposal;

  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49711925);
    proposal = AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103(0x3aE999AEf88072aC7fB702af1C362f47647962FC);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103',
      AaveV2Polygon.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](7);
    assetsChanged[0] = AaveV2PolygonAssets.DAI_UNDERLYING;
    assetsChanged[1] = AaveV2PolygonAssets.USDC_UNDERLYING;
    assetsChanged[2] = AaveV2PolygonAssets.USDT_UNDERLYING;
    assetsChanged[3] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    assetsChanged[4] = AaveV2PolygonAssets.WETH_UNDERLYING;
    assetsChanged[5] = AaveV2PolygonAssets.WMATIC_UNDERLYING;
    assetsChanged[6] = AaveV2PolygonAssets.BAL_UNDERLYING;

    Changes[] memory assetChanges = new Changes[](7);
    assetChanges[0] = Changes({
      asset: AaveV2PolygonAssets.DAI_UNDERLYING,
      reserveFactor: 46_00
    });
    assetChanges[1] = Changes({
      asset: AaveV2PolygonAssets.USDC_UNDERLYING,
      reserveFactor: 48_00
    });
    assetChanges[2] = Changes({
      asset: AaveV2PolygonAssets.USDT_UNDERLYING,
      reserveFactor: 47_00
    });
    assetChanges[3] = Changes({
      asset: AaveV2PolygonAssets.WBTC_UNDERLYING,
      reserveFactor: 80_00
    });
    assetChanges[4] = Changes({
      asset: AaveV2PolygonAssets.WETH_UNDERLYING,
      reserveFactor: 70_00
    });
    assetChanges[5] = Changes({
      asset: AaveV2PolygonAssets.WMATIC_UNDERLYING,
      reserveFactor: 66_00
    });
    assetChanges[6] = Changes({
      asset: AaveV2PolygonAssets.BAL_UNDERLYING,
      reserveFactor: 57_00
    });

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetChanges.length; i++) {
      ReserveConfig memory cfg = _findReserveConfig(allConfigsAfter, assetChanges[i].asset);
      assertEq(cfg.reserveFactor, assetChanges[i].reserveFactor);
    }

  }
}
