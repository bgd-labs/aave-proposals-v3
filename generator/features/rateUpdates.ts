import {CodeArtifact, FEATURE, FeatureModule} from '../types';
import {RateStrategyParams, RateStrategyUpdate} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {percentPrompt, translateJsPercentToSol} from '../prompts/percentPrompt';

export async function fetchRateStrategyParamsV2(required?: boolean): Promise<RateStrategyParams> {
  return {
    optimalUtilizationRate: await percentPrompt({
      message: 'optimalUtilizationRate',
      required,
    }),
    baseVariableBorrowRate: await percentPrompt({
      message: 'baseVariableBorrowRate',
      required,
    }),
    variableRateSlope1: await percentPrompt({
      message: 'variableRateSlope1',
      required,
    }),
    variableRateSlope2: await percentPrompt({
      message: 'variableRateSlope2',
      required,
    }),
    stableRateSlope1: await percentPrompt({
      message: 'stableRateSlope1',
      required,
    }),
    stableRateSlope2: await percentPrompt({
      message: 'stableRateSlope2',
      required,
    }),
  };
}

export async function fetchRateStrategyParamsV3(required?: boolean) {
  const params = await fetchRateStrategyParamsV2(required);
  return {
    ...params,
    baseStableRateOffset: await percentPrompt({
      message: 'baseStableRateOffset',
      required,
    }),
    stableRateExcessOffset: await percentPrompt({
      message: 'stableRateExcessOffset',
      required,
    }),
    optimalStableToTotalDebtRatio: await percentPrompt({
      message: 'optimalStableToTotalDebtRatio',
      required,
    }),
  };
}

export const rateUpdatesV2: FeatureModule<RateStrategyUpdate[]> = {
  value: FEATURE.RATE_UPDATE_V2,
  description: 'RateStrategiesUpdates',
  async cli({pool}) {
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
  build({pool, cfg}) {
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
                  optimalUtilizationRate: ${translateJsPercentToSol(
                    cfg.params.optimalUtilizationRate,
                    true
                  )},
                  baseVariableBorrowRate: ${translateJsPercentToSol(
                    cfg.params.baseVariableBorrowRate,
                    true
                  )},
                  variableRateSlope1: ${translateJsPercentToSol(
                    cfg.params.variableRateSlope1,
                    true
                  )},
                  variableRateSlope2: ${translateJsPercentToSol(
                    cfg.params.variableRateSlope2,
                    true
                  )},
                  stableRateSlope1: ${translateJsPercentToSol(cfg.params.stableRateSlope1, true)},
                  stableRateSlope2: ${translateJsPercentToSol(cfg.params.stableRateSlope2, true)}
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
  async cli({pool}) {
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
  build({pool, cfg}) {
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
                    optimalUsageRatio: ${translateJsPercentToSol(
                      cfg.params.optimalUtilizationRate,
                      true
                    )},
                    baseVariableBorrowRate: ${translateJsPercentToSol(
                      cfg.params.baseVariableBorrowRate,
                      true
                    )},
                    variableRateSlope1: ${translateJsPercentToSol(
                      cfg.params.variableRateSlope1,
                      true
                    )},
                    variableRateSlope2: ${translateJsPercentToSol(
                      cfg.params.variableRateSlope2,
                      true
                    )},
                    stableRateSlope1: ${translateJsPercentToSol(cfg.params.stableRateSlope1, true)},
                    stableRateSlope2: ${translateJsPercentToSol(cfg.params.stableRateSlope2, true)},
                    baseStableRateOffset: ${translateJsPercentToSol(
                      cfg.params.baseStableRateOffset!,
                      true
                    )},
                    stableRateExcessOffset: ${translateJsPercentToSol(
                      cfg.params.stableRateExcessOffset!,
                      true
                    )},
                    optimalStableToTotalDebtRatio: ${translateJsPercentToSol(
                      cfg.params.optimalStableToTotalDebtRatio!,
                      true
                    )}
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
