import {CodeArtifact, FEATURE, FeatureModule} from '../types';
import {percentInput} from '../prompts';
import {RateStrategyParams, RateStrategyUpdate} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';

export async function fetchRateStrategyParamsV2(
  disableKeepCurrent?: boolean
): Promise<RateStrategyParams> {
  return {
    optimalUtilizationRate: await percentInput({
      message: 'optimalUtilizationRate',
      toRay: true,
      disableKeepCurrent,
    }),
    baseVariableBorrowRate: await percentInput({
      message: 'baseVariableBorrowRate',
      toRay: true,
      disableKeepCurrent,
    }),
    variableRateSlope1: await percentInput({
      message: 'variableRateSlope1',
      toRay: true,
      disableKeepCurrent,
    }),
    variableRateSlope2: await percentInput({
      message: 'variableRateSlope2',
      toRay: true,
      disableKeepCurrent,
    }),
    stableRateSlope1: await percentInput({
      message: 'stableRateSlope1',
      toRay: true,
      disableKeepCurrent,
    }),
    stableRateSlope2: await percentInput({
      message: 'stableRateSlope2',
      toRay: true,
      disableKeepCurrent,
    }),
  };
}

export async function fetchRateStrategyParamsV3(disableKeepCurrent?: boolean) {
  const params = await fetchRateStrategyParamsV2(disableKeepCurrent);
  return {
    ...params,
    baseStableRateOffset: await percentInput({
      message: 'baseStableRateOffset',
      toRay: true,
      disableKeepCurrent,
    }),
    stableRateExcessOffset: await percentInput({
      message: 'stableRateExcessOffset',
      toRay: true,
      disableKeepCurrent,
    }),
    optimalStableToTotalDebtRatio: await percentInput({
      message: 'optimalStableToTotalDebtRatio',
      toRay: true,
      disableKeepCurrent,
    }),
  };
}

export const rateUpdatesV2: FeatureModule<RateStrategyUpdate[]> = {
  value: FEATURE.RATE_UPDATE_V2,
  description: 'RateStrategiesUpdates',
  async cli(opt, pool) {
    console.log(`Fetching information for RatesUpdate on ${pool}`);
    const assets = await assetsSelectPrompt({
      message: 'Select the assets you want to amend',
      pool,
    });
    const response: RateStrategyUpdate[] = [];
    for (const asset of assets) {
      console.log(`Fetching info for ${asset}`);
      response.push({asset, params: await fetchRateStrategyParamsV2()});
    }
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function rateStrategiesUpdates()
          public
          pure
          override
          returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
        {
          IAaveV2ConfigEngine.RateStrategyUpdate[] memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](${
            cfg.length
          });
          ${cfg
            .map(
              (cfg, ix) => `rateStrategies[${ix}] = IAaveV2ConfigEngine.RateStrategyUpdate({
                asset: ${translateAssetToAssetLibUnderlying(cfg.asset, pool)},
                params: IV2RateStrategyFactory.RateStrategyParams({
                  optimalUtilizationRate: ${cfg.params.optimalUtilizationRate},
                  baseVariableBorrowRate: ${cfg.params.baseVariableBorrowRate},
                  variableRateSlope1: ${cfg.params.variableRateSlope1},
                  variableRateSlope2: ${cfg.params.variableRateSlope2},
                  stableRateSlope1: ${cfg.params.stableRateSlope1},
                  stableRateSlope2: ${cfg.params.stableRateSlope2}
                })
              });`
            )
            .join('\n')}


          return rateStrategies;
        }`,
        ],
      },
    };
    return response;
  },
};

export const rateUpdatesV3: FeatureModule<RateStrategyUpdate[]> = {
  value: FEATURE.RATE_UPDATE_V3,
  description: 'RateStrategiesUpdates',
  async cli(opt, pool) {
    console.log(`Fetching information for RatesUpdate on ${pool}`);
    const assets = await assetsSelectPrompt({
      message: 'Select the assets you want to amend',
      pool,
    });
    const response: RateStrategyUpdate[] = [];
    for (const asset of assets) {
      console.log(`Fetching info for ${asset}`);
      response.push({asset, params: await fetchRateStrategyParamsV3()});
    }
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function rateStrategiesUpdates()
          public
          pure
          override
          returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
        {
          IAaveV3ConfigEngine.RateStrategyUpdate[] memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](${
            cfg.length
          });
          ${cfg
            .map(
              (cfg, ix) => `rateStrategies[${ix}] = IAaveV3ConfigEngine.RateStrategyUpdate({
                  asset: ${translateAssetToAssetLibUnderlying(cfg.asset, pool)},
                  params: IV3RateStrategyFactory.RateStrategyParams({
                    optimalUsageRatio: ${cfg.params.optimalUtilizationRate},
                    baseVariableBorrowRate: ${cfg.params.baseVariableBorrowRate},
                    variableRateSlope1: ${cfg.params.variableRateSlope1},
                    variableRateSlope2: ${cfg.params.variableRateSlope2},
                    stableRateSlope1: ${cfg.params.stableRateSlope1},
                    stableRateSlope2: ${cfg.params.stableRateSlope2},
                    baseStableRateOffset: ${cfg.params.baseStableRateOffset!},
                    stableRateExcessOffset: ${cfg.params.stableRateExcessOffset!},
                    optimalStableToTotalDebtRatio: ${cfg.params.optimalStableToTotalDebtRatio!}
                  })
                });`
            )
            .join('\n')}


          return rateStrategies;
        }`,
        ],
      },
    };
    return response;
  },
};
