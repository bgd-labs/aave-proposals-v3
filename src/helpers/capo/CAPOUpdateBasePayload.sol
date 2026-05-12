// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IPriceCapAdapter} from 'src/interfaces/IPriceCapAdapter.sol';

abstract contract CAPOUpdateBasePayload is IProposalGenericExecutor {
  function _updateCapParameters(
    address priceCapAdapter,
    uint104 newSnapshotRatio,
    uint48 newSnapshotTimestamp
  ) internal {
    _updateCapParameters(
      priceCapAdapter,
      newSnapshotRatio,
      newSnapshotTimestamp,
      uint16(IPriceCapAdapter(priceCapAdapter).getMaxYearlyGrowthRatePercent()) // existing value should safely fit
    );
  }

  function _updateCapParameters(
    address priceCapAdapter,
    uint104 newSnapshotRatio,
    uint48 newSnapshotTimestamp,
    uint16 maxYearlyRatioGrowthPercent
  ) internal {
    IPriceCapAdapter(priceCapAdapter).setCapParameters(
      IPriceCapAdapter.PriceCapUpdateParams({
        snapshotRatio: newSnapshotRatio,
        snapshotTimestamp: newSnapshotTimestamp,
        maxYearlyRatioGrowthPercent: maxYearlyRatioGrowthPercent
      })
    );
  }
}
