import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {eModesSelect} from '../prompts';
import {EModeCategoryUpdate} from './types';
import {stringOrKeepCurrent} from '../prompts/stringPrompt';
import {translateJsPercentToSol} from '../prompts/percentPrompt';
import {translateJsBoolToSol} from '../prompts/boolPrompt';
import {fetchEmodeCategoryData} from './eModesCreation';
import {eModeUpdateTests} from './eModesTestHelpers';

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

async function subCli(market: MarketIdentifier) {
  const answers: EmodeUpdates = [];
  const eModeCategories = await eModesSelect({
    message: 'Select the eModes you want to amend',
    market,
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
  async cli({market}) {
    const response: EmodeUpdates = await subCli(market);
    return response;
  },
  build({market, cfg}) {
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
               label: ${stringOrKeepCurrent(cfg.label)},
               isolated: ${translateJsBoolToSol(cfg.isolated)}
             });`,
            )
            .join('\n')}

          return eModeUpdates;
        }`,
        ],
      },
      test: {
        fn: eModeUpdateTests(market, cfg),
      },
    };
    return response;
  },
};
