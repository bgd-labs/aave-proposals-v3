// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

/**
 * @title Claim old Aave rewards and enable sentinel on celo, zksync
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3ZkSync_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928 is
  IProposalGenericExecutor
{
  address public constant PRICE_ORACLE_SENTINEL = 0xbB57EAAEFE94Fb6850941E360cf0939189f73cE5;

  function execute() external {
    AaveV3ZkSync.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(PRICE_ORACLE_SENTINEL);
  }
}
