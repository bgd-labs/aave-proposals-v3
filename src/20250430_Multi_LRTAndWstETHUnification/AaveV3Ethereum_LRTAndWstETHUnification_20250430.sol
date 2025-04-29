// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title LRT and wstETH Unification
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739
 */
contract AaveV3Ethereum_LRTAndWstETHUnification_20250430 is AaveV3PayloadEthereum {
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 8,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'rsETH/wstETH'
    });

    return eModeUpdates;
  }

  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](3);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      eModeCategory: 8,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.rsETH_UNDERLYING,
      eModeCategory: 8,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.RSETH_LST_MAIN,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
}
