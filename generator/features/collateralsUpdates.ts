import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {numberInput, percentInput} from '../prompts';
import {CollateralUpdate, CollateralUpdatePartial} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';

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
  };
}

type CollateralUpdates = CollateralUpdate[];

export const collateralsUpdates: FeatureModule<CollateralUpdates> = {
  value: FEATURE.COLLATERALS_UPDATE,
  description: 'CollateralsUpdates (ltv,lt,lb,debtCeiling,liqProtocolFee,eModeCategory)',
  async cli(opt, pool) {
    console.log(`Fetching information for Collateral Updates on ${pool}`);

    const response: CollateralUpdates = [];
    const assets = await assetsSelectPrompt({
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
          `function collateralsUpdates() public pure override returns (IAaveV3ConfigEngine.CollateralUpdate[] memory) {
          IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `collateralUpdate[${ix}] = IAaveV3ConfigEngine.CollateralUpdate({
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, pool)},
               ltv: ${cfg.ltv},
               liqThreshold: ${cfg.liqThreshold},
               liqBonus: ${cfg.liqBonus},
               debtCeiling: ${cfg.debtCeiling},
               liqProtocolFee: ${cfg.liqProtocolFee}
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
