// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Prime Instance - wstETH Borrow Rate + rsETH Supply Cap Update
 * @author @TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aave.eth/proposal/0xfc21203137ea8753ab8903fe4edd568bcaa7ea084586a7acb2c3b361d3dae9c8
 * - Discussion: https://governance.aave.com/t/arfc-prime-instance-wsteth-borrow-rate-rseth-supply-cap-update/20644
 */
contract AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122 is
  AaveV3PayloadEthereumLido
{
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 75,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumLidoAssets.rsETH_UNDERLYING,
      supplyCap: 65_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
