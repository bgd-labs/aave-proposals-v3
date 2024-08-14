// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Risk Parameter Updates - sAVAX on Aave V3 Avalanche
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x471ab55b0091043963c744f228befd842aeb354b0d04c76da3c9eb2b401934a4
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-savax-on-aave-v3-avalanche-07-16-2024/18277
 */
contract AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724 is
  AaveV3PayloadAvalanche
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
      asset: AaveV3AvalancheAssets.sAVAX_UNDERLYING,
      ltv: 40_00,
      liqThreshold: 45_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
