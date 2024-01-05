// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {PoolAddresses} from './PoolLibrary.sol';
import {AaveV3GenericPatch_20240104} from './AaveV3GenericPatch_20240104.sol';

/**
 * @title Patch
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/pre-cautionary-measures-on-three-aave-v3-assets/16037
 */
contract AaveV3Base_Patch_20240104 is AaveV3GenericPatch_20240104 {
  constructor()
    AaveV3GenericPatch_20240104(
      PoolAddresses.BASE_POOL_IMPL_ADDRESS,
      AaveV3Base.POOL_ADDRESSES_PROVIDER
    )
  {}
}
