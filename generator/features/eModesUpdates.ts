import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {addressInput, eModesSelect, percentInput, stringInput} from '../prompts';
import {EModeCategoryUpdate} from './types';

async function subCli(pool: PoolIdentifier) {
  console.log(`Fetching information for EModes on ${pool}`);
  const eModeCategories = await eModesSelect({
    message: 'Select the eModes you want to amend',
    pool,
  });
  const answers: EmodeUpdates = [];
  for (const eModeCategory of eModeCategories) {
    console.log(`collecting info for ${eModeCategory}`);
    answers.push({
      eModeCategory,
      ltv: await percentInput({
        message: 'ltv',
      }),
      liqThreshold: await percentInput({
        message: 'liqThreshold',
      }),
      liqBonus: await percentInput({
        message: 'liqBonus',
      }),
      priceSource: await addressInput({
        message: 'Price Source',
      }),
      label: await stringInput({message: 'label'}),
    });
  }
  return answers;
}

type EmodeUpdates = EModeCategoryUpdate[];

export const eModeUpdates: FeatureModule<EmodeUpdates> = {
  value: FEATURE.EMODES_UPDATES,
  description: 'eModeCategoriesUpdates (altering/adding eModes)',
  async cli(opt, pool) {
    const response: EmodeUpdates = await subCli(pool);
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function eModeCategoriesUpdates() public pure override returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory) {
          IAaveV3ConfigEngine.EModeCategoryUpdate[] memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `eModeUpdates[${ix}] = IAaveV3ConfigEngine.EModeCategoryUpdate({
               eModeCategory: ${cfg.eModeCategory},
               ltv: ${cfg.ltv},
               liqThreshold: ${cfg.liqThreshold},
               liqBonus: ${cfg.liqBonus},
               priceSource: ${cfg.priceSource},
               label: ${cfg.label}
             });`
            )
            .join('\n')}

          return eModeUpdates;
        }`,
        ],
      },
    };
    return response;
  },
};
