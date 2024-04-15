// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Generalized LT/LTV Reduction on Aave
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4067d91ef5864925136d10ec9419f032a70f7e6489740386e348488426656274
 * - Discussion: https://governance.aave.com/t/generalized-lt-ltv-reduction-on-aave/16766
 */
contract AaveV3Base_GeneralizedLTLTVReductionOnAave_20240324 is AaveV3PayloadBase {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](2);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3BaseAssets.USDbC_UNDERLYING,
      ltv: 76_00,
      liqThreshold: 79_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3BaseAssets.USDC_UNDERLYING,
      ltv: 76_00,
      liqThreshold: 79_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
