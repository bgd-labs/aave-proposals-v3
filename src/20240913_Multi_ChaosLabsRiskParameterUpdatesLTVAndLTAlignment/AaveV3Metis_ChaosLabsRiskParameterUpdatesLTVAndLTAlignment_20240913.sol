// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3PayloadMetis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMetis.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title  Chaos Labs Risk Parameter Updates - LTV and LT Alignment
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x153c14691fb5056bc30f53be19f04647c24d206149d2bc5a6752d7548f72ca0b
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-ltv-and-lt-alignment/18997
 */
contract AaveV3Metis_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913 is AaveV3PayloadMetis {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](3);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MetisAssets.mUSDC_UNDERLYING,
      ltv: 75_00,
      liqThreshold: 83_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MetisAssets.mUSDT_UNDERLYING,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[2] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MetisAssets.WETH_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 83_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
