import {confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {FreezeUpdate} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';

function freezeUpdateOverrides(market: MarketIdentifier, cfgs: FreezeUpdate[]): string[] {
  return [
    `function _expectedFreezeChanges() internal pure override returns (address[] memory assets, bool[] memory frozen) {
      assets = new address[](${cfgs.length});
      frozen = new bool[](${cfgs.length});

      ${cfgs
        .map(
          (cfg, ix) => `assets[${ix}] = ${translateAssetToAssetLibUnderlying(cfg.asset, market)};
      frozen[${ix}] = ${cfg.shouldBeFrozen};`,
        )
        .join('\n')}
    }`,
  ];
}

export const freezeUpdates: FeatureModule<FreezeUpdate[]> = {
  value: FEATURE.FREEZE,
  description: 'Freeze/Unfreeze a reserve',
  async cli({market}) {
    const response: FreezeUpdate[] = [];
    const assets = await assetsSelectPrompt({
      message: 'Select the assets you want to change',
      market,
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
  build({market, cfg}) {
    const response: CodeArtifact = {
      code: {
        execute: cfg.map(
          (cfg) =>
            `${market}.POOL_CONFIGURATOR.setReserveFreeze(${translateAssetToAssetLibUnderlying(
              cfg.asset,
              market,
            )}, ${cfg.shouldBeFrozen});`,
        ),
      },
      test: {
        fn: freezeUpdateOverrides(market, cfg),
        updatedAssets: cfg.map((cfg) => translateAssetToAssetLibUnderlying(cfg.asset, market)),
      },
    };
    return response;
  },
};
