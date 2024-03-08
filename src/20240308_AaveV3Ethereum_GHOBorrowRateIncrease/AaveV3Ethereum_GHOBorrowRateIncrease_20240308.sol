// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title GHOBorrowRateIncrease
 * @author Aave Chan Initiative
 * - Snapshot: No snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-increase-gho-borrow-rate-08-03-2024/16885
 */
contract AaveV3Ethereum_GHOBorrowRateIncrease_20240308 is IProposalGenericExecutor {
  address internal immutable INTEREST_RATE_STRATEGY;

  constructor(address interestRateStrategy) {
    INTEREST_RATE_STRATEGY = interestRateStrategy;
  }

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
