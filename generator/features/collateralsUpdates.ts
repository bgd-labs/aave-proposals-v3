import {CodeArtifact, ENGINE_FLAGS, FeatureModule, PoolIdentifier} from '../types';
import {assetsSelect, eModeSelect, numberInput, percentInput} from '../prompts';
import {CollateralUpdate, CollateralUpdatePartial} from './types';

export async function fetchCollateralUpdate(
  pool: PoolIdentifier,
  disableKeepCurrent?: boolean
): Promise<CollateralUpdatePartial> {
  return {
    ltv: await percentInput({
      message: 'Loan to value',
      disableKeepCurrent,
    }),
    liqThreshold: await percentInput({
      message: 'Liquidation Threshold',
      disableKeepCurrent,
    }),
    liqBonus: await percentInput({
      message: 'Liquidation bonus',
      disableKeepCurrent,
    }),
    debtCeiling: await numberInput({
      message: 'Debt ceiling',
      disableKeepCurrent,
    }),
    liqProtocolFee: await percentInput({
      message: 'Liquidation protocol fee',
      disableKeepCurrent,
    }),
    eModeCategory: await eModeSelect({
      message: 'e mode category',
      disableKeepCurrent,
      pool,
    }),
  };
}

type CollateralUpdates = CollateralUpdate[];

export const collateralsUpdates: FeatureModule<CollateralUpdates> = {
  value: 'CollateralsUpdates (ltv,lt,lb,debtCeiling,liqProtocolFee,eModeCategory)',
  async cli(opt, pool) {
    console.log(`Fetching information for Collateral Updates on ${pool}`);

    const response: CollateralUpdates = [];
    const assets = await assetsSelect({
      message: 'Select the assets you want to amend',
      pool,
    });
    for (const asset of assets) {
      console.log(`collecting info for ${asset}`);

      response.push({asset, ...(await fetchCollateralUpdate(pool))});
    }
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
            IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](${
              cfg.length
            });

          ${cfg
            .map(
              (cfg, ix) => `collateralUpdate[${ix}] = IEngine.CollateralUpdate({
               asset: ${cfg.asset},
               ltv: ${cfg.ltv},
               liqThreshold: ${cfg.liqThreshold},
               liqBonus: ${cfg.liqBonus},
               debtCeiling: ${cfg.debtCeiling},
               liqProtocolFee: ${cfg.liqProtocolFee},
               eModeCategory: ${
                 cfg.eModeCategory === ENGINE_FLAGS.KEEP_CURRENT
                   ? `EngineFlags.KEEP_CURRENT`
                   : cfg.eModeCategory
               }
             });`
            )
            .join('\n')}

          return collateralUpdate;
        }`,
        ],
      },
    };
    return response;
  },
};
