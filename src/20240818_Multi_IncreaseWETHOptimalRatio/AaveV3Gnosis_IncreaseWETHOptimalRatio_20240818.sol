// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3PayloadGnosis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadGnosis.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Increase WETH Optimal Ratio
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2930599cae3cec0a16bd0aef13524347e0c5e85cff7dd66ae9b2bed90fc5d1fe
 * - Discussion: https://governance.aave.com/t/arfc-increase-weth-optimal-ratio-to-90-on-all-aave-markets/18556
 */
contract AaveV3Gnosis_IncreaseWETHOptimalRatio_20240818 is AaveV3PayloadGnosis {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3GnosisAssets.WETH_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
