import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {addressInput, eModesSelect, percentInput, stringInput} from '../prompts';
import {EModeCategoryUpdate} from './types';
import {confirm} from '@inquirer/prompts';

async function fetchEmodeCategoryUpdate(isNewCategory: boolean, eModeCategory?: string): Promise<EModeCategoryUpdate> {
  return {
    eModeCategory: eModeCategory ?? await stringInput({message: 'eModeCategory'}),
    ltv: await percentInput({
      message: 'ltv',
      disableKeepCurrent: isNewCategory ? true : false
    }),
    liqThreshold: await percentInput({
      message: 'liqThreshold',
      disableKeepCurrent: isNewCategory ? true : false
    }),
    liqBonus: await percentInput({
      message: 'liqBonus',
      disableKeepCurrent: isNewCategory ? true : false
    }),
    priceSource: await addressInput({
      message: 'Price Source',
      disableKeepCurrent: isNewCategory ? true : false
    }),
    label: await stringInput({
      message: 'label',
      disableKeepCurrent: isNewCategory ? true : false
    }),
  };
}

async function subCli(pool: PoolIdentifier) {
  const answers: EmodeUpdates = [];

  const shouldAddNewCategory = await confirm({message: 'Do you wish to add a new emode category?', default: false});
  if (shouldAddNewCategory) {
    let more: boolean = true;
    while (more) {
      answers.push(await fetchEmodeCategoryUpdate(true));
      more = await confirm({message: 'Do you want to add another emode category?', default: false});
    }
  }

  const shouldAmendCategory = await confirm({message: 'Do you wish to amend existing emode category?', default: false});
  if (shouldAmendCategory) {
    const eModeCategories = await eModesSelect({
      message: 'Select the eModes you want to amend',
      pool,
    });

    for (const eModeCategory of eModeCategories) {
      console.log(`collecting info for ${eModeCategory}`);
      answers.push(await fetchEmodeCategoryUpdate(false, eModeCategory));
    }
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
