import {CodeArtifact, FeatureModule, PoolIdentifier} from '../types';
import {isV2Pool} from '../common';
import {assetsSelect, percentInput} from '../prompts';
import {RateStrategyParams, RateStrategyUpdate} from './types';

export async function fetchRateStrategyParams(
  pool: PoolIdentifier,
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
    ...(isV2Pool(pool)
      ? {}
      : {
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
            message: 'stableRateExcessOffset',
            toRay: true,
            disableKeepCurrent,
          }),
        }),
  };
}

export const rateUpdates: FeatureModule<RateStrategyUpdate[]> = {
  value: 'RateStrategiesUpdates',
  async cli(opt, pool) {
    console.log(`Fetching information for RatesUpdate on ${pool}`);
    const assets = await assetsSelect({
      message: 'Select the assets you want to amend',
      pool,
    });
    const response: RateStrategyUpdate[] = [];
    for (const asset of assets) {
      console.log(`Fetching info for ${asset}`);
      response.push({asset, params: await fetchRateStrategyParams(pool)});
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
          returns (IEngine.RateStrategyUpdate[] memory)
        {
          IEngine.RateStrategyUpdate[] memory rateStrategies = new IEngine.RateStrategyUpdate[](${
            cfg.length
          });
          ${
            isV2Pool(pool)
              ? cfg
                  .map(
                    (cfg, ix) => `rateStrategies[${ix}] = IEngine.RateStrategyUpdate({
                asset: ${cfg.asset},
                params: Rates.RateStrategyParams({
                  optimalUtilizationRate: ${cfg.params.optimalUtilizationRate},
                  baseVariableBorrowRate: ${cfg.params.baseVariableBorrowRate},
                  variableRateSlope1: ${cfg.params.variableRateSlope1},
                  variableRateSlope2: ${cfg.params.variableRateSlope2},
                  stableRateSlope1: ${cfg.params.stableRateSlope1},
                  stableRateSlope2: ${cfg.params.stableRateSlope2}
                })
              });`
                  )
                  .join('\n')
              : cfg
                  .map(
                    (cfg, ix) => `rateStrategies[${ix}] = IEngine.RateStrategyUpdate({
                  asset: ${pool}Assets.${cfg.asset}_UNDERLYING,
                  params: Rates.RateStrategyParams({
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
                  .join('\n')
          }


          return rateStrategies;
        }`,
        ],
      },
    };
    return response;
  },
};
