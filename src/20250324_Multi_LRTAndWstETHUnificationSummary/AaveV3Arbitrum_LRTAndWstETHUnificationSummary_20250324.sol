// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ArbitrumAssets, AaveV3ArbitrumEModes} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title LRT and wstETH Unification Summary
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-core-instance-add-ezeth-and-update-rseth-emode-parameters/21505
 */
contract AaveV3Arbitrum_LRTAndWstETHUnificationSummary_20250324 is AaveV3PayloadArbitrum {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3ArbitrumAssets.WETH_UNDERLYING,
      ltv: 75_00,
      liqThreshold: 77_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](2);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 5,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'weETH_WETH'
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 6,
      ltv: 94_50,
      liqThreshold: 96_00,
      liqBonus: 1_00,
      label: 'wstETH_WETH'
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](4);

    // weETH_WETH
    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ArbitrumAssets.weETH_UNDERLYING,
      eModeCategory: 5,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ArbitrumAssets.WETH_UNDERLYING,
      eModeCategory: 5,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    // wstETH_WETH
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      eModeCategory: 6,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ArbitrumAssets.WETH_UNDERLYING,
      eModeCategory: 6,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
}
