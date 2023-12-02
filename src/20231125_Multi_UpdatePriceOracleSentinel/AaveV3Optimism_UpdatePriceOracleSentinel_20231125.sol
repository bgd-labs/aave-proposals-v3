// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Update PriceOracleSentinel
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/8
 */
contract AaveV3Optimism_UpdatePriceOracleSentinel_20231125 is IProposalGenericExecutor {
  address public constant NEW_PRICE_ORACLE_SENTINEL = 0xE229d5DE4BD5beEAf12d427B5B57BFe66abD2c3b;

  function execute() external {
    AaveV3Optimism.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(NEW_PRICE_ORACLE_SENTINEL);
  }
}
