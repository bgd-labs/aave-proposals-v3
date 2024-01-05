// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {PoolAddresses} from './PoolLibrary.sol';
import {AaveV3GenericPatch_20240104} from './AaveV3GenericPatch_20240104.sol';

/**
 * @title Patch
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/pre-cautionary-measures-on-three-aave-v3-assets/16037
 */
contract AaveV3Ethereum_Patch_20240104 is AaveV3GenericPatch_20240104 {
  constructor()
    AaveV3GenericPatch_20240104(
      PoolAddresses.ETHEREUM_POOL_IMPL_ADDRESS,
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER
    )
  {}
}
