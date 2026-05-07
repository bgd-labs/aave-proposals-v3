// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IPriceCapAdapter} from 'src/interfaces/IPriceCapAdapter.sol';

/**
 * @title CAPO SnapshotRatio Update Across Aave V3
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854
 */
contract AaveV3Plasma_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 is IProposalGenericExecutor {
  uint104 public constant sUSDe_SNAPSHOT_RATIO = 1227017473582880624;
  uint48 public constant sUSDe_SNAPSHOT_TIMESTAMP = 1776095930;

  uint104 public constant weETH_SNAPSHOT_RATIO = 1092447295285287694;
  uint48 public constant weETH_SNAPSHOT_TIMESTAMP = 1776095953;

  function execute() external {
    _updateSnapshotRatio(
      AaveV3PlasmaAssets.sUSDe_ORACLE,
      sUSDe_SNAPSHOT_RATIO,
      sUSDe_SNAPSHOT_TIMESTAMP
    );

    _updateSnapshotRatio(
      AaveV3PlasmaAssets.weETH_ORACLE,
      weETH_SNAPSHOT_RATIO,
      weETH_SNAPSHOT_TIMESTAMP
    );
  }

  function _updateSnapshotRatio(
    address priceCapAdapter,
    uint104 newSnapshotRatio,
    uint48 newSnapshotTimestamp
  ) internal {
    uint256 maxYearlyRatioGrowthPercent = IPriceCapAdapter(priceCapAdapter)
      .getMaxYearlyGrowthRatePercent();
    IPriceCapAdapter.PriceCapUpdateParams memory params = IPriceCapAdapter.PriceCapUpdateParams({
      snapshotRatio: newSnapshotRatio,
      snapshotTimestamp: newSnapshotTimestamp,
      maxYearlyRatioGrowthPercent: uint16(maxYearlyRatioGrowthPercent) // existing value should safely fit
    });
    IPriceCapAdapter(priceCapAdapter).setCapParameters(params);
  }
}
