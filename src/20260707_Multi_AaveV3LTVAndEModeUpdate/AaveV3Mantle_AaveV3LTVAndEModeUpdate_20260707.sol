// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MantleAssets} from 'aave-address-book/AaveV3Mantle.sol';
import {AaveV3PayloadMantle} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMantle.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Aave V3 LTV and E-Mode Update
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-aave-v3-ltv-and-e-mode-update/25067
 */
contract AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707 is AaveV3PayloadMantle {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](2);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MantleAssets.WETH_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MantleAssets.WMNT_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_WMNT__Stablecoins = new address[](1);
    address[] memory borrowableAssets_WMNT__Stablecoins = new address[](3);

    collateralAssets_WMNT__Stablecoins[0] = AaveV3MantleAssets.WMNT_UNDERLYING;
    borrowableAssets_WMNT__Stablecoins[0] = AaveV3MantleAssets.USDT0_UNDERLYING;
    borrowableAssets_WMNT__Stablecoins[1] = AaveV3MantleAssets.USDC_UNDERLYING;
    borrowableAssets_WMNT__Stablecoins[2] = AaveV3MantleAssets.GHO_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 40_00,
      liqThreshold: 45_00,
      liqBonus: 10_00,
      label: 'WMNT__Stablecoins',
      isolated: true,
      collaterals: collateralAssets_WMNT__Stablecoins,
      borrowables: borrowableAssets_WMNT__Stablecoins
    });

    return eModeCreations;
  }
}
