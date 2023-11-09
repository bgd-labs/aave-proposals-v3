// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title GHO - Increase Borrow Rate
 * @author @Marczeller - ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9789e054e29f63da5713368be2dd0b4006f4564ef5e48c9d5e994ec20e932e35
 * - Discussion: https://governance.aave.com/t/arfc-gho-increase-borrow-rate/15271
 */
contract AaveV3Ethereum_GHOIncreaseBorrowRate_20231108 {

 address public constant INTEREST_RATE_STRATEGY = 0xE7C0AE65f7D52E121654eEa0A57b4af0894F6D27;

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
  }
}
