// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3PayloadGnosis} from 'aave-helpers/v3-config-engine/AaveV3PayloadGnosis.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';

/**
 * @title Update GNO Risk Parameters on Aave V3 Gnosis Pool
 * @author  Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe35faf498e25ff6a0620b8395c4653b05fe98cb0ccaacb62da140e53097f9ac0
 * - Discussion: https://governance.aave.com/t/arfc-update-gno-risk-parameters-on-aave-v3-gnosis-pool/15613
 */
contract AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213 is AaveV3PayloadGnosis {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3GnosisAssets.GNO_UNDERLYING,
      params: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT,
        baseStableRateOffset: EngineFlags.KEEP_CURRENT,
        stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
        optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }

  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.GNO_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 1_100
    });

    return capsUpdate;
  }

  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3GnosisAssets.GNO_UNDERLYING,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      reserveFactor: 20_00
    });

    return borrowUpdates;
  }
}
