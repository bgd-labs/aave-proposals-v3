// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BaseAssets, AaveV3BaseEModes} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title LRT and wstETH Unification
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739
 */
contract AaveV3Base_LRTAndWstETHUnification_20250430 is AaveV3PayloadBase {
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](5);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3BaseEModes.RSETH_WSTETH,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: EngineFlags.KEEP_CURRENT_STRING
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 6,
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      label: 'rsETH/USDC'
    });
    eModeUpdates[2] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 7,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_25,
      label: 'weETH/WETH'
    });
    eModeUpdates[3] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 8,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'wstETH/WETH'
    });
    eModeUpdates[4] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 9,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 2_00,
      label: 'cbETH/WETH'
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](8);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.USDC_UNDERLYING,
      eModeCategory: 6,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.wrsETH_UNDERLYING,
      eModeCategory: 6,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.WETH_UNDERLYING,
      eModeCategory: 7,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.weETH_UNDERLYING,
      eModeCategory: 7,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    assetEModeUpdates[4] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.WETH_UNDERLYING,
      eModeCategory: 8,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[5] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.wstETH_UNDERLYING,
      eModeCategory: 8,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    assetEModeUpdates[6] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.WETH_UNDERLYING,
      eModeCategory: 9,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[7] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.cbETH_UNDERLYING,
      eModeCategory: 9,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    return assetEModeUpdates;
  }
}
