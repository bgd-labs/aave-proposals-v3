// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3PayloadScroll} from 'aave-helpers/v3-config-engine/AaveV3PayloadScroll.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Generalized LT/LTV Reductions on Aave V3 Step 2
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4067d91ef5864925136d10ec9419f032a70f7e6489740386e348488426656274
 * - Discussion: https://governance.aave.com/t/arfc-generalized-lt-ltv-reductions-on-aave-v3-step-2-04-23-2024/17455
 */
contract AaveV3Scroll_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425 is AaveV3PayloadScroll {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3ScrollAssets.USDC_UNDERLYING,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
