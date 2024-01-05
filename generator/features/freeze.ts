import {confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule} from '../types';
import {FreezeUpdate} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';

export const freezeUpdates: FeatureModule<FreezeUpdate[]> = {
  value: FEATURE.FREEZE,
  description: 'Freeze/Unfreeze a reserve',
  async cli({pool}) {
    const response: FreezeUpdate[] = [];
    const assets = await assetsSelectPrompt({
      message: 'Select the assets you want to change',
      pool,
    });
    for (const asset of assets) {
      console.log(`collecting info for ${asset}`);
      response.push({
        asset,
        shouldBeFrozen: await confirm({message: 'Should the asset be frozen?'}),
      });
    }
    return response;
  },
  build({pool, cfg}) {
    const response: CodeArtifact = {
      code: {
        execute: cfg.map(
          (cfg) =>
            `${pool}.POOL_CONFIGURATOR.setReserveFreeze(${translateAssetToAssetLibUnderlying(
              cfg.asset,
              pool
            )}, false);`
        ),
      },
    };
    return response;
  },
};
