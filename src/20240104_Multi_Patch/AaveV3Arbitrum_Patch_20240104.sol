// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {PoolAddresses} from './PoolLibrary.sol';
import {AaveV3GenericPatch_20240104} from './AaveV3GenericPatch_20240104.sol';

/**
 * @title Patch
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/pre-cautionary-measures-on-three-aave-v3-assets/16037
 */
contract AaveV3Arbitrum_Patch_20240104 is AaveV3GenericPatch_20240104 {
  constructor()
    AaveV3GenericPatch_20240104(
      PoolAddresses.ARBITRUM_POOL_IMPL_ADDRESS,
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER
    )
  {}
}
