// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Increase GHO Borrow Rate 100 bps to 6.35% on Aave V3
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: No snapshot for direct to AIP
 * - Discussion: https://governance.aave.com/t/arfc-increase-gho-borrow-rate-100-bps-to-6-35-on-aave-v3/15744
 */
contract AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205 {
  address public constant INTEREST_RATE_STRATEGY = 0x00524e8E4C5FD2b8D8aa1226fA16b39Cad69B8A0;

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
