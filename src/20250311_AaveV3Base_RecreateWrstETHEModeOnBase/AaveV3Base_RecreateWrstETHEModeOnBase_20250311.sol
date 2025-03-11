// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets, AaveV3BaseEModes} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Recreate wrstETH eMode on Base
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/arfc-onboard-rseth-to-arbitrum-and-base-v3-instances/20741/9
 */
contract AaveV3Base_RecreateWrstETHEModeOnBase_20250311 is AaveV3PayloadBase {
  function _postExecute() internal override {
    AaveV3Base.POOL_CONFIGURATOR.setReserveFreeze(AaveV3BaseAssets.wrsETH_UNDERLYING, false);
    AaveV3Base.POOL_CONFIGURATOR.setReserveFreeze(AaveV3BaseAssets.LBTC_UNDERLYING, false);
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 5,
      ltv: 92_50,
      liqThreshold: 94_50,
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](4);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.wstETH_UNDERLYING,
      eModeCategory: AaveV3BaseEModes.LBTC_CBBTC,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.wrsETH_UNDERLYING,
      eModeCategory: AaveV3BaseEModes.LBTC_CBBTC,
      borrowable: EngineFlags.KEEP_CURRENT,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.wstETH_UNDERLYING,
      eModeCategory: 5,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.wrsETH_UNDERLYING,
      eModeCategory: 5,
      borrowable: EngineFlags.KEEP_CURRENT,
      collateral: EngineFlags.ENABLED
    });

    return assetEModeUpdates;
  }
}
