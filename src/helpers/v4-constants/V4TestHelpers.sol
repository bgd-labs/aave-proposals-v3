// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ISpoke} from 'aave-address-book/AaveV4.sol';
import {AaveV4EthereumSpokes, AaveV4EthereumGetters} from 'aave-address-book/AaveV4Ethereum.sol';

/**
 * @title V4TestHelpers
 * @author Aave Labs
 * @notice Reusable filters/utilities for Aave V4 Ethereum payload tests.
 */
library V4TestHelpers {
  /**
   * @notice User spokes minus Kelp_E.
   * @dev Kelp_E reserves currently have collateralFactor=0, so the e2e
   * supply/borrow/liquidation flows have no usable collateral on that spoke.
   * Excluded until Kelp's reserves are configured. Re-include once fixed.
   */
  function getE2eSpokes() internal pure returns (ISpoke[] memory) {
    ISpoke[] memory all = AaveV4EthereumGetters.getAllSpokes();
    ISpoke[] memory filtered = new ISpoke[](all.length - 1);
    uint256 j;
    for (uint256 i; i < all.length; i++) {
      if (address(all[i]) == address(AaveV4EthereumSpokes.KELP_ESPOKE)) continue;
      filtered[j++] = all[i];
    }
    return filtered;
  }
}
