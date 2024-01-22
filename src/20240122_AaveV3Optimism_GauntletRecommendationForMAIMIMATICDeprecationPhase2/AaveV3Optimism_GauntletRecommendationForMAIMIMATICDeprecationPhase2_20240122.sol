// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Gauntlet recommendation for MAI / MIMATIC deprecation phase 2
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x67a6941140c0c0662cfbf99254100f58930afb6763b8040c4bdbd0dfbb2a952b
 * - Discussion: https://governance.aave.com/t/arfc-gauntlet-recommendation-for-mai-mimatic-deprecation-phase-2/15957
 */
contract AaveV3Optimism_GauntletRecommendationForMAIMIMATICDeprecationPhase2_20240122 is
  AaveV3PayloadOptimism
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
      asset: AaveV3OptimismAssets.MAI_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 1_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
