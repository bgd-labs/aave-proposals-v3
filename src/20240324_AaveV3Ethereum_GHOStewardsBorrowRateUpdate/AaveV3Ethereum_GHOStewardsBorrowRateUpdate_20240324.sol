// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title GHO Borrow Rate Update
 * @author karpatkey_TokenLogic & ACI & ChaosLabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc26346b891974968c6fa1745b2cfa869d2d0e5875e9fc2bd661167ae19314c6b
 * - Discussion: https://governance.aave.com/t/arfc-gho-stewards-borrow-rate-update/16956
 */
contract AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324 is IProposalGenericExecutor {
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
