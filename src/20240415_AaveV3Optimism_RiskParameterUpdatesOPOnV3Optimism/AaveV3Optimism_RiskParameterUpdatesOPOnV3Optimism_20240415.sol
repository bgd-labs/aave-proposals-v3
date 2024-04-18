// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Risk Parameter Updates - OP on V3 Optimism
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xbaaf99c1e738da5755166fc6b1429265243507fdb9638a31ca177dd81a8b7313
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-op-on-v3-optimism/17326
 */
contract AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415 is AaveV3PayloadOptimism {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.OP_UNDERLYING,
      ltv: 50_00,
      liqThreshold: 60_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
