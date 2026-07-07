import {confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {FreezeUpdate} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';

function freezeUpdateOverrides(market: MarketIdentifier, cfgs: FreezeUpdate[]): string[] {
  return [
    `function _expectedFreezeChanges() internal pure override returns (ReserveFreezeUpdate[] memory) {
      ReserveFreezeUpdate[] memory freezeUpdates;
      freezeUpdates = new ReserveFreezeUpdate[](${cfgs.length});

      ${cfgs
        .map(
          (cfg, ix) => `freezeUpdates[${ix}] = ReserveFreezeUpdate({
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, market)},
               frozen: ${cfg.shouldBeFrozen}
             });`,
        )
        .join('\n')}
      return freezeUpdates;
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
