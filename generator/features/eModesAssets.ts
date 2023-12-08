import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {eModeSelect} from '../prompts';
import {AssetEModeUpdate} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';

async function subCli(pool: PoolIdentifier) {
  console.log(`Fetching information for Emode assets on ${pool}`);
  const assets = await assetsSelectPrompt({
    message: 'Select the assets you want to amend eMode for',
    pool,
  });
  const answers: EmodeAssetUpdates = [];
  for (const asset of assets) {
    console.log(`collecting info for ${asset}`);
    answers.push({
      asset,
      eModeCategory: await eModeSelect({
        message: `Select the eMode you want to assign to ${asset}`,
        disableKeepCurrent: true,
        pool,
      }),
    });
  }
  return answers;
}

type EmodeAssetUpdates = AssetEModeUpdate[];

export const eModeAssets: FeatureModule<EmodeAssetUpdates> = {
  value: FEATURE.EMODES_ASSETS,
  description: 'assetsEModeUpdates (setting eMode for an asset)',
  async cli({pool}) {
    const response: EmodeAssetUpdates = await subCli(pool);
    return response;
  },
  build({pool, cfg}) {
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
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, pool)},
               eModeCategory: ${cfg.eModeCategory}
             });`
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
