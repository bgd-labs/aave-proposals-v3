// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {AaveV3PayloadBNB} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBNB.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title  Chaos Labs Risk Parameter Updates - LTV and LT Alignment
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x153c14691fb5056bc30f53be19f04647c24d206149d2bc5a6752d7548f72ca0b
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-ltv-and-lt-alignment/18997
 */
contract AaveV3BNB_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913 is AaveV3PayloadBNB {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3BNBAssets.ETH_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 83_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
