// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

import {AaveV2Polygon_ReserveFactorUpdatesJan312024_20240125} from './AaveV2Polygon_ReserveFactorUpdatesJan312024_20240125.sol';

/**
 * @dev Test for AaveV2Polygon_ReserveFactorUpdatesJan312024_20240125
 * command: make test-contract filter=AaveV2Polygon_ReserveFactorUpdatesJan312024_20240125
 */
contract AaveV2Polygon_ReserveFactorUpdatesJan312024_20240125_Test is ProtocolV2TestBase {
  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  AaveV2Polygon_ReserveFactorUpdatesJan312024_20240125 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 52968567);
    proposal = new AaveV2Polygon_ReserveFactorUpdatesJan312024_20240125();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Polygon_ReserveFactorUpdates_20240125',
      AaveV2Polygon.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](5);
    assetsChanged[0] = AaveV2PolygonAssets.DAI_UNDERLYING;
    assetsChanged[1] = AaveV2PolygonAssets.USDC_UNDERLYING;
    assetsChanged[2] = AaveV2PolygonAssets.USDT_UNDERLYING;
    assetsChanged[3] = AaveV2PolygonAssets.WETH_UNDERLYING;
    assetsChanged[4] = AaveV2PolygonAssets.WMATIC_UNDERLYING;

    Changes[] memory assetChanges = new Changes[](5);
    assetChanges[0] = Changes({
      asset: AaveV2PolygonAssets.DAI_UNDERLYING,
      reserveFactor: proposal.DAI_RF()
    });
    assetChanges[1] = Changes({
      asset: AaveV2PolygonAssets.USDC_UNDERLYING,
      reserveFactor: proposal.USDC_RF()
    });
    assetChanges[2] = Changes({
      asset: AaveV2PolygonAssets.USDT_UNDERLYING,
      reserveFactor: proposal.USDT_RF()
    });
    assetChanges[3] = Changes({
      asset: AaveV2PolygonAssets.WETH_UNDERLYING,
      reserveFactor: proposal.WETH_RF()
    });
    assetChanges[4] = Changes({
      asset: AaveV2PolygonAssets.WMATIC_UNDERLYING,
      reserveFactor: proposal.WMATIC_RF()
    });

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetChanges.length; i++) {
      ReserveConfig memory cfg = _findReserveConfig(allConfigsAfter, assetChanges[i].asset);
      assertEq(cfg.reserveFactor, assetChanges[i].reserveFactor);
    }
  }
}
