// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Configuration maintenance
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/86
 */
contract AaveV2Ethereum_ConfigurationMaintenance_20250519 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2EthereumAssets.renFIL_UNDERLYING,
      0x311C866D55456e465e314A3E9830276B438A73f0
    );
  }
}
