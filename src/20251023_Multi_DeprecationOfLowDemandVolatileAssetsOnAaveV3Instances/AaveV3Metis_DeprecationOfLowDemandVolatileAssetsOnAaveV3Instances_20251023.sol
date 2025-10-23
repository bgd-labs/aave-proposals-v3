// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3PayloadMetis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMetis.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Deprecation of Low Demand Volatile Assets on Aave V3 Instances
 * @author Aave-chan Initiative
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-deprecation-of-low-demand-volatile-assets-on-aave-v3-instances/23261
 */
contract AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023 is
  AaveV3PayloadMetis
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
      asset: AaveV3MetisAssets.Metis_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
