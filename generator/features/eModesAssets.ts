import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {eModeSelect} from '../prompts';
import {AssetEModeUpdate} from './types';
import {
  assetsSelectPrompt,
  getNewListingSymbols,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {boolPrompt, translateJsBoolToSol} from '../prompts/boolPrompt';

async function subCli(market: MarketIdentifier, additionalAssets: string[]) {
  console.log(`Fetching information for Emode assets on ${market}`);
  const assets = await assetsSelectPrompt({
    message: 'Select the assets you want to amend eMode for',
    market,
    additionalAssets,
  });
  const answers: EmodeAssetUpdates = [];
  for (const asset of assets) {
    console.log(`collecting info for ${asset}`);
    answers.push({
      asset,
      eModeCategory: await eModeSelect({
        message: `Select the eMode you want to assign to ${asset}`,
        disableKeepCurrent: true,
        market,
      }),
      collateral: await boolPrompt({
        message: `Should the asset ${asset} be enabled as collateral inside the EMode?`,
      }),
      borrowable: await boolPrompt({
        message: `Should the asset ${asset} be enabled as borrowable inside the EMode?`,
      }),
      ltvzero: await boolPrompt({
        message: `Should ltvzero be enabled for the asset ${asset} inside the EMode?`,
      }),
    });
  }
  return answers;
}

type EmodeAssetUpdates = AssetEModeUpdate[];

export const eModeAssets: FeatureModule<EmodeAssetUpdates> = {
  value: FEATURE.EMODES_ASSETS,
  description: 'assetsEModeUpdates (setting eMode for an asset)',
  async cli({market, configs}) {
    const response: EmodeAssetUpdates = await subCli(market, getNewListingSymbols(configs));
    return response;
  },
  build({market, cfg, configs}) {
    const newListings = new Set(getNewListingSymbols(configs));
    const response: CodeArtifact = {
      code: {
        fn: [
          `function assetsEModeUpdates() public pure override returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory) {
          IAaveV3ConfigEngine.AssetEModeUpdate[] memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `assetEModeUpdates[${ix}] = IAaveV3ConfigEngine.AssetEModeUpdate({
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, market, newListings)},
               eModeCategory: ${cfg.eModeCategory},
               borrowable: ${translateJsBoolToSol(cfg.borrowable)},
               collateral: ${translateJsBoolToSol(cfg.collateral)},
               ltvzero: ${translateJsBoolToSol(cfg.ltvzero)},
             });`,
            )
            .join('\n')}

          return assetEModeUpdates;
        }`,
        ],
      },
    };
    return response;
  },
};
