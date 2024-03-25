// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title v3 Periphery maintenance
 * @author BGD Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274
 */
contract AaveV3Scroll_V3PeripheryMaintenance_20240314 is IProposalGenericExecutor {
  address public constant PRICE_ORACLE_SENTINEL = 0xfD0Ba55775C1e53f50736FA5528d8aa45FBcA391;

  function execute() external {
    AaveV3Scroll.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(PRICE_ORACLE_SENTINEL);
  }
}
