// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

/**
 * @title Update PriceOracleSentinel
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/8
 */
contract AaveV3Metis_UpdatePriceOracleSentinel_20231125 is IProposalGenericExecutor {
  address public constant NEW_PRICE_ORACLE_SENTINEL = 0x2B5EA1604BAbb7B730120950Cb13951f3525828A;

  function execute() external {
    AaveV3Metis.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(NEW_PRICE_ORACLE_SENTINEL);
  }
}
