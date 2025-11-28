// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title add sUSDe to PT USDe and PT sUSDe february expiry emode
 * @author Aave-chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Ethereum_AddSUSDeToPTUSDeAndPTSUSDeFebruaryExpiryEmode_20251128 is
  AaveV3PayloadEthereum
{
  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](4);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.sUSDe_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.PT_USDe_27NOV2025_PT_USDe_5FEB2026__USDC_USDT_USDe_USDtb,
      borrowable: EngineFlags.KEEP_CURRENT,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.sUSDe_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.PT_USDe_27NOV2025_PT_USDe_5FEB2026__USDe,
      borrowable: EngineFlags.KEEP_CURRENT,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.sUSDe_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes
        .PT_sUSDE_27NOV2025_PT_sUSDE_5FEB2026__USDC_USDT_USDe_USDtb,
      borrowable: EngineFlags.KEEP_CURRENT,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.sUSDe_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.PT_sUSDE_27NOV2025_PT_sUSDE_5FEB2026__USDe,
      borrowable: EngineFlags.KEEP_CURRENT,
      collateral: EngineFlags.ENABLED
    });

    return assetEModeUpdates;
  }
}
