// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Risk Parameter Updates - Increase USDe Debt Ceiling on V3 Ethereum
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xea1012aaf1fe660148cfe6265cbadf23b19bb44af609caaa51ab8d7194259c28
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-usde-debt-ceiling-on-v3-ethereum-07-22-2024/18325
 */
contract AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801 is
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
      asset: AaveV3EthereumAssets.USDe_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: 50_000_000,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
