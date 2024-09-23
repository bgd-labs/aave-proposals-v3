// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSyncAssets} from 'aave-address-book/AaveV3ZkSync.sol';
import {AaveV3PayloadZkSync} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadZkSync.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title CapsUpdateGuardian
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95
 * - Discussion: https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937/24
 */
contract AaveV3ZkSync_CapsUpdateGuardian_20240923 is AaveV3PayloadZkSync {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](5);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3ZkSyncAssets.USDC_UNDERLYING,
      supplyCap: 1_000_000,
      borrowCap: 900_000
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3ZkSyncAssets.USDT_UNDERLYING,
      supplyCap: 3_000_000,
      borrowCap: 2_700_000
    });
    capsUpdate[2] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3ZkSyncAssets.WETH_UNDERLYING,
      supplyCap: 1_000,
      borrowCap: 900
    });
    capsUpdate[3] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3ZkSyncAssets.wstETH_UNDERLYING,
      supplyCap: 300,
      borrowCap: 30
    });
    capsUpdate[4] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3ZkSyncAssets.ZK_UNDERLYING,
      supplyCap: 18_000_000,
      borrowCap: 10_000_000
    });

    return capsUpdate;
  }
}
