// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MegaEthAssets, AaveV3MegaEthEModes} from 'aave-address-book/AaveV3MegaEth.sol';
import {AaveV3PayloadMegaEth} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMegaEth.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Collateral Parameters Adjustment on MegaETH v3
 * @author Chaos Labs (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-collateral-parameters-adjustment-on-aave-v3-megaeth-instance/24334
 */
contract AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402 is AaveV3PayloadMegaEth {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](3);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MegaEthAssets.WETH_UNDERLYING,
      ltv: 78_00,
      liqThreshold: 81_00,
      liqBonus: 5_50,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MegaEthAssets.BTCb_UNDERLYING,
      ltv: 68_00,
      liqThreshold: 73_00,
      liqBonus: 6_50,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[2] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MegaEthAssets.wstETH_UNDERLYING,
      ltv: 75_00,
      liqThreshold: 79_00,
      liqBonus: 6_50,
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
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3MegaEthEModes.wstETH__USDT0_USDm,
      ltv: 78_50,
      liqThreshold: 81_00,
      liqBonus: 6_50,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    return eModeUpdates;
  }
}
