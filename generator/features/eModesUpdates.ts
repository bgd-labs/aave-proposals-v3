import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {eModesSelect} from '../prompts';
import {EModeCategoryUpdate} from './types';
import {stringOrKeepCurrent} from '../prompts/stringPrompt';
import {translateJsPercentToSol} from '../prompts/percentPrompt';
import {fetchEmodeCategoryData} from './eModesCreation';

async function fetchEmodeCategoryUpdate<T extends boolean>(
  eModeCategory: string | number,
  required?: T,
): Promise<EModeCategoryUpdate> {
  const eModeData = await fetchEmodeCategoryData(required);
  return {
    eModeCategory,
    ...eModeData,
  };
}

async function subCli(pool: PoolIdentifier) {
  const answers: EmodeUpdates = [];
  const eModeCategories = await eModesSelect({
    message: 'Select the eModes you want to amend',
    pool,
  });

  if (eModeCategories) {
    for (const eModeCategory of eModeCategories) {
      console.log(`collecting info for ${eModeCategory}`);
      answers.push(await fetchEmodeCategoryUpdate(eModeCategory));
    }
  }

  return answers;
}

type EmodeUpdates = EModeCategoryUpdate[];

export const eModeUpdates: FeatureModule<EmodeUpdates> = {
  value: FEATURE.EMODES_UPDATES,
  description: 'eModeCategoriesUpdates (altering eModes)',
  async cli({pool}) {
    const response: EmodeUpdates = await subCli(pool);
    return response;
  },
  build({pool, cfg}) {
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
               ltv: ${translateJsPercentToSol(cfg.ltv)},
               liqThreshold: ${translateJsPercentToSol(cfg.liqThreshold)},
               liqBonus: ${translateJsPercentToSol(cfg.liqBonus)},
               label: ${stringOrKeepCurrent(cfg.label)}
             });`,
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
