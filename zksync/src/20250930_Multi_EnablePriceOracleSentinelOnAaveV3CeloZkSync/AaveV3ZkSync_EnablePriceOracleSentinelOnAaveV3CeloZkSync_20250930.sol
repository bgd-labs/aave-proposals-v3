// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

/**
 * @title Enable Price Oracle Sentinel on Aave V3 Celo, ZkSync
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930 is
  IProposalGenericExecutor
{
  address public constant PRICE_ORACLE_SENTINEL = 0xbB57EAAEFE94Fb6850941E360cf0939189f73cE5;

  function execute() external {
    AaveV3ZkSync.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(PRICE_ORACLE_SENTINEL);
  }
}
