// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Increase GHO Borrow Rate
 * @author @Marczeller - Aave-Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-increase-gho-borrow-rate-to-5-22-on-aave-v3/15632
 */
contract AaveV3Ethereum_IncreaseGHOBorrowRate_20231121 {
  address public constant INTEREST_RATE_STRATEGY = 0xE6e780D77b883E9a5eC84f7baA6BF4DB43177Fa7;

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
