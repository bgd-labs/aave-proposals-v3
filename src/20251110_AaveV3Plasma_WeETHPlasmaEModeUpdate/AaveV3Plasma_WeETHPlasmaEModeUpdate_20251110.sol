// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PlasmaEModes} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title WeETH Plasma e-mode update
 * @author Choas Labs (implemented by ACI)
 * - snapshot: Direct to AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-weeth-e-mode-risk-parameter-adjustment-on-aave-v3-plasma-instance/23381
 */
contract AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110 is AaveV3PayloadPlasma {
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3PlasmaEModes.weETH__USDT0,
      ltv: 77_50,
      liqThreshold: 80_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    return eModeUpdates;
  }
}
