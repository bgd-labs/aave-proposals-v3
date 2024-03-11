// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title GHO Borrow Rate Increase 2024-02-29
 * @author ACI
 * - Discussion: https://governance.aave.com/t/arfc-increase-gho-borrow-rate-29-02-2024/16787
 */
contract AaveV3Ethereum_GHOBorrowRateIncrease20240229_20240229 {
  address public constant INTEREST_RATE_STRATEGY = 0x3a4D5316ec79622686a19f69CE546997cC8e8514;

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
