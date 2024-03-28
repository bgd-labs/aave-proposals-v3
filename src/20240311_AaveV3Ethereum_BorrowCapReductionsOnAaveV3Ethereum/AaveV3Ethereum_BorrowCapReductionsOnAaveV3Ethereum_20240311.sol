// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Borrow Cap Reductions on Aave V3 Ethereum
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9fb23244675bb07e1b5406fa4276aeeb712a80026721e2321ce41bd0e612de73
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-borrow-cap-reductions-on-aave-ethereum-03-11-24/16918
 */
contract AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311 is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](11);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.CRV_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 2_750_000
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.MKR_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 1_980
    });
    capsUpdate[2] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.SNX_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 150_000
    });
    capsUpdate[3] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.BAL_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 244_200
    });
    capsUpdate[4] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.UNI_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 330_000
    });
    capsUpdate[5] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.LDO_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 1_500_000
    });
    capsUpdate[6] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 475_200
    });
    capsUpdate[7] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.RPL_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 316_800
    });
    capsUpdate[8] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.STG_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 3_200_000
    });
    capsUpdate[9] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.KNC_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 350_000
    });
    capsUpdate[10] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.FXS_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 330_000
    });

    return capsUpdate;
  }
}
