// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IPriceCapAdapter} from 'src/interfaces/IPriceCapAdapter.sol';

/**
 * @title CAPO SnapshotRatio Update Across Aave V3
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-capo-snapshotratio-update-across-aave-v3/24854
 */
contract AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 is IProposalGenericExecutor {
  uint104 public constant wstETH_SNAPSHOT_RATIO = 1231706743820320505;
  uint48 public constant wstETH_SNAPSHOT_TIMESTAMP = 1776087290;

  uint104 public constant sDAI_SNAPSHOT_RATIO = 1234933736953001411;
  uint48 public constant sDAI_SNAPSHOT_TIMESTAMP = 1776087275;

  function execute() external {
    _updateCapParameters(
      AaveV3GnosisAssets.wstETH_ORACLE,
      wstETH_SNAPSHOT_RATIO,
      wstETH_SNAPSHOT_TIMESTAMP
    );

    _updateCapParameters(
      AaveV3GnosisAssets.sDAI_ORACLE,
      sDAI_SNAPSHOT_RATIO,
      sDAI_SNAPSHOT_TIMESTAMP
    );
  }

  function _updateCapParameters(
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
