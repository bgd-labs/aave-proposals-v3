// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Chaos Labs Risk Parameter Updates - Increase MKR Debt Ceiling on V3 Ethereum
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0xb3163709f822b662241395c1fde5ecaa8b39d52b1bc81722136c6084a4b3959c
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-mkr-debt-ceiling-on-v3-ethereum-11-07-2023/15406
 */
contract AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseMKRDebtCeilingOnV3Ethereum_20231116 is
  AaveV3PayloadEthereum
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
      asset: AaveV3EthereumAssets.MKR_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: 8_500_000,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
