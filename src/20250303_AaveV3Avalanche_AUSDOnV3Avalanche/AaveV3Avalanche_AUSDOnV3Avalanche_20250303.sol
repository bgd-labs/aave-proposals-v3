// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title AUSD on V3 Avalanche
 * @author Aave-Chan Initiative
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameters-update-ausd-on-v3-avalanche/21201
 */
contract AaveV3Avalanche_AUSDOnV3Avalanche_20250303 is AaveV3PayloadAvalanche {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3AvalancheAssets.AUSD_UNDERLYING,
      ltv: 69_00,
      liqThreshold: 72_00,
      liqBonus: 6_00,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: 10_00
    });

    return collateralUpdate;
  }
}
