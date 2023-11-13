import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {eModesSelect, percentInput} from '../prompts';
import {EModeCategoryUpdate} from './types';
import {confirm} from '@inquirer/prompts';
import {addressPrompt, translateJsAddressToSol} from '../prompts/addressPrompt';
import {stringOrKeepCurrent, stringPrompt} from '../prompts/stringPrompt';
import {zeroAddress} from 'viem';
import {getEModes} from '../common';

async function fetchEmodeCategoryUpdate<T extends boolean>(
  eModeCategory: string | number,
  disableKeepCurrent?: T
): Promise<EModeCategoryUpdate> {
  return {
    eModeCategory,
    ltv: await percentInput({
      message: 'ltv',
      disableKeepCurrent,
    }),
    liqThreshold: await percentInput({
      message: 'liqThreshold',
      disableKeepCurrent,
    }),
    liqBonus: await percentInput({
      message: 'liqBonus',
      disableKeepCurrent,
    }),
    priceSource: await addressPrompt({
      message: 'Price Source',
      required: disableKeepCurrent,
      defaultValue: disableKeepCurrent ? zeroAddress : '',
    }),
    label: await stringPrompt({
      message: 'label',
      required: disableKeepCurrent,
    }),
  };
}

async function subCli(pool: PoolIdentifier) {
  const answers: EmodeUpdates = [];

  const shouldAddNewCategory = await confirm({
    message: 'Do you wish to add a new emode category?',
    default: false,
  });
  if (shouldAddNewCategory) {
    let more: boolean = true;
    const eModes = getEModes(pool as any);
    let highestEmode = Object.values(eModes).length > 0 ? Math.max(...Object.values(eModes)) : 0;

    while (more) {
      answers.push(await fetchEmodeCategoryUpdate(++highestEmode, true));
      more = await confirm({message: 'Do you want to add another emode category?', default: false});
    }
  }

  const shouldAmendCategory = await confirm({
    message: 'Do you wish to amend existing emode category?',
    default: false,
  });
  if (shouldAmendCategory) {
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
               priceSource: ${translateJsAddressToSol(cfg.priceSource)},
               label: ${stringOrKeepCurrent(cfg.label)}
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
