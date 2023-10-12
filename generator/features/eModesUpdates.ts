import {CodeArtifact, FeatureModule, PoolIdentifier} from '../types';
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
  value: 'eModeCategoriesUpdates (altering/adding eModes)',
  async cli(opt, pool) {
    const response: EmodeUpdates = await subCli(pool);
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function eModeCategoriesUpdates() public pure override returns (IEngine.EModeCategoryUpdate[] memory) {
          IEngine.EModeCategoryUpdate[] memory eModeUpdates = new IEngine.EModeCategoryUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `eModeUpdates[${ix}] = IEngine.EModeCategoryUpdate({
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
