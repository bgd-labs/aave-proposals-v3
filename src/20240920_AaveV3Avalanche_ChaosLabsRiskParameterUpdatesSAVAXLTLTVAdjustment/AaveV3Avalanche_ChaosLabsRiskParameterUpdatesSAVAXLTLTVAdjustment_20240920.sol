// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3AvalancheAssets, AaveV3AvalancheEModes} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Chaos Labs Risk Parameter Updates - sAVAX LT/LTV Adjustment
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x79d53b646cbada43fca9468df9c9ecbbaab42f9f4f17691cbdf216b21f6c21bb
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-savax-lt-ltv-adjustment/18995
 */
contract AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920 is
  AaveV3PayloadAvalanche
{
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.sAVAX_UNDERLYING,
      ltv: 50_00,
      liqThreshold: 55_00,
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
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3AvalancheEModes.AVAX_CORRELATED,
      ltv: 93_00,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      priceSource: EngineFlags.KEEP_CURRENT_ADDRESS,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    return eModeUpdates;
  }
}
