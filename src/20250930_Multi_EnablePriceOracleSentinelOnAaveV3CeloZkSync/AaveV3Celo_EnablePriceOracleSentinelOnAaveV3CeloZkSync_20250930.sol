// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';

/**
 * @title Enable Price Oracle Sentinel on Aave V3 Celo, ZkSync
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3Celo_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930 is
  IProposalGenericExecutor
{
  address public constant PRICE_ORACLE_SENTINEL = 0x06C5c197EdFDF2Ed0A3757880242B2264EF7c3C2;

  function execute() external {
    AaveV3Celo.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(PRICE_ORACLE_SENTINEL);
  }
}
