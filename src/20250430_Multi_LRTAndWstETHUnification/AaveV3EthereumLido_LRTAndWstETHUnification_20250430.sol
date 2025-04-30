// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLidoAssets, AaveV3EthereumLidoEModes} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title LRT and wstETH Unification
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739
 */
contract AaveV3EthereumLido_LRTAndWstETHUnification_20250430 is AaveV3PayloadEthereumLido {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](2);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      ltv: 82_00,
      liqThreshold: 83_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumLidoAssets.WETH_UNDERLYING,
      ltv: 84_00,
      liqThreshold: 85_00,
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
      eModeCategory: 6,
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      label: 'rsETH/Stablecoins'
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 7,
      ltv: 95_00,
      liqThreshold: 96_50,
      liqBonus: 1_00,
      label: 'wstETH/WETH'
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](7);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumLidoAssets.USDC_UNDERLYING,
      eModeCategory: 6,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumLidoAssets.USDS_UNDERLYING,
      eModeCategory: 6,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumLidoAssets.GHO_UNDERLYING,
      eModeCategory: 6,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumLidoAssets.rsETH_UNDERLYING,
      eModeCategory: 6,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[4] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumLidoAssets.WETH_UNDERLYING,
      eModeCategory: AaveV3EthereumLidoEModes.ETH_CORRELATED,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[5] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumLidoAssets.WETH_UNDERLYING,
      eModeCategory: 7,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[6] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      eModeCategory: 7,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    return assetEModeUpdates;
  }
}
