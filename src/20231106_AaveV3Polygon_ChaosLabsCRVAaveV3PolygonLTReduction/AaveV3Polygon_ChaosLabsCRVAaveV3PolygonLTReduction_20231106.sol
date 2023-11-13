// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title Chaos Labs CRV Aave V3 Polygon LT Reduction
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0x0851676384aa4adc836ac6d4f001d1ec7683d5142380a2499bc5ac8b56bb8593
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-crv-aave-v3-polygon-lt-reduction-10-28-2023/15259
 */
contract AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106 is AaveV3PayloadPolygon {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.CRV_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 50_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
