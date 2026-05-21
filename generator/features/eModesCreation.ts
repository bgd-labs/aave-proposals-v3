import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {EModeCategoryCreation, EModeCategoryPartial} from './types';
import {confirm} from '@inquirer/prompts';
import {stringPrompt} from '../prompts/stringPrompt';
import {percentPrompt, translateJsPercentToSol} from '../prompts/percentPrompt';
import {
  assetsSelectPrompt,
  getNewListingSymbols,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {pascalCase} from '../common';

export async function fetchEmodeCategoryData<T extends boolean>(
  required?: T,
): Promise<EModeCategoryPartial> {
  return {
    ltv: await percentPrompt({
      message: 'ltv',
      required,
    }),
    liqThreshold: await percentPrompt({
      message: 'liqThreshold',
      required,
    }),
    liqBonus: await percentPrompt({
      message: 'liqBonus',
      required,
    }),
    label: await stringPrompt({
      message: 'label',
      required,
    }),
  };
}

async function fetchEmodeCategoryCreation(
  market: MarketIdentifier,
  additionalAssets: string[],
): Promise<EModeCategoryCreation> {
  const eModeData = await fetchEmodeCategoryData(true);
  const collateralAssets = await assetsSelectPrompt({
    message: 'Select the assets you want to add as collateral',
    market,
    additionalAssets,
  });
  const borrowableAssets = await assetsSelectPrompt({
    message: 'Select the assets you want to add as borrowable',
    market,
    additionalAssets,
  });
  return {
    ...eModeData,
    collateralAssets,
    borrowableAssets,
  };
}

async function subCli(market: MarketIdentifier, additionalAssets: string[]) {
  const answers: EmodeCreations = [];
  let more: boolean = true;
  console.log(`Fetching information for Emode creation on ${market}`);

  while (more) {
    answers.push(await fetchEmodeCategoryCreation(market, additionalAssets));
    more = await confirm({message: 'Do you want to add another emode category?', default: false});
  }

  return answers;
}

type EmodeCreations = EModeCategoryCreation[];

export const eModeCreations: FeatureModule<EmodeCreations> = {
  value: FEATURE.EMODES_CREATION,
  description: 'eModeCategoriesCreation (adding eModes)',
  async cli({market, configs}) {
    const response: EmodeCreations = await subCli(market, getNewListingSymbols(configs));
    return response;
  },
  build({market, cfg, configs}) {
    const newListings = new Set(getNewListingSymbols(configs));
    const response: CodeArtifact = {
      code: {
        fn: [
          `function eModeCategoryCreations() public pure override returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory) {
          IAaveV3ConfigEngine.EModeCategoryCreation[] memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `
              address[] memory collateralAssets_${pascalCase(cfg.label)} = new address[](${cfg.collateralAssets.length});
              address[] memory borrowableAssets_${pascalCase(cfg.label)} = new address[](${cfg.borrowableAssets.length});

              ${cfg.collateralAssets
                .map(
                  (asset, i) =>
                    `collateralAssets_${pascalCase(cfg.label)}[${i}] = ${translateAssetToAssetLibUnderlying(asset, market, newListings)};`,
                )
                .join('\n')}
              ${cfg.borrowableAssets
                .map(
                  (asset, i) =>
                    `borrowableAssets_${pascalCase(cfg.label)}[${i}] = ${translateAssetToAssetLibUnderlying(asset, market, newListings)};`,
                )
                .join('\n')}

              eModeCreations[${ix}] = IAaveV3ConfigEngine.EModeCategoryCreation({
                ltv: ${translateJsPercentToSol(cfg.ltv)},
                liqThreshold: ${translateJsPercentToSol(cfg.liqThreshold)},
                liqBonus: ${translateJsPercentToSol(cfg.liqBonus)},
                label: '${cfg.label}',
                collaterals: collateralAssets_${pascalCase(cfg.label)},
                borrowables: borrowableAssets_${pascalCase(cfg.label)}
              });`,
            )
            .join('\n')}

          return eModeCreations;
        }`,
        ],
      },
    };
    return response;
  },
};
