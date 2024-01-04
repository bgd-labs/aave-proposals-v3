// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Chaos Labs Risk Parameter Updates - WBTC.e on V2 and V3 Avalanche
 * @author Chaos Labs - Eyal Ovadya
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0e496f9cb98fb887e9c0e1b4669607a2b99a0675b23ad152c7aedbe28f8dc08d
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-wbtc-e-on-v2-and-v3-avalanche/15824
 */
contract AaveV3Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221 is
  AaveV3PayloadAvalanche
{
  function _postExecute() internal override {
    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveFreeze(
      AaveV3AvalancheAssets.WBTCe_UNDERLYING,
      true
    );
  }

  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.WBTCe_UNDERLYING,
      ltv: 0,
      liqThreshold: 70_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
