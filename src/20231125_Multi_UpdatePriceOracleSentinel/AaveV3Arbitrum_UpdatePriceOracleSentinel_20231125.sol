// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title Update PriceOracleSentinel
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/8
 */
contract AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125 is IProposalGenericExecutor {
  address public constant NEW_PRICE_ORACLE_SENTINEL = 0x7A9ff54A6eE4a21223036890bB8c4ea2D62c686b;

  function execute() external {
    AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(NEW_PRICE_ORACLE_SENTINEL);
  }
}
