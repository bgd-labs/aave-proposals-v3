// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';

/**
 * @title Claim old Aave rewards and enable sentinel on celo, zksync
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3Celo_ClaimOldAaveRewardsAndEnableSentinelOnCeloZksync_20250928 is
  IProposalGenericExecutor
{
  address public constant PRICE_ORACLE_SENTINEL = 0x06C5c197EdFDF2Ed0A3757880242B2264EF7c3C2;

  function execute() external {
    AaveV3Celo.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(PRICE_ORACLE_SENTINEL);
  }
}
