// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

/**
 * @title Update PriceOracleSentinel
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/8
 */
contract AaveV3Base_UpdatePriceOracleSentinel_20231125 is IProposalGenericExecutor {
  address public constant NEW_PRICE_ORACLE_SENTINEL = 0x943AcD0c93d7a8Bee7dA5Fd0DC3d0028237074d6;

  function execute() external {
    AaveV3Base.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(NEW_PRICE_ORACLE_SENTINEL);
  }
}
