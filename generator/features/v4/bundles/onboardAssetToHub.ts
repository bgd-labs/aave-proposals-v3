import {select, checkbox, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {
  hubKeys,
  spokeKeys,
  assetKeys,
  hubLibAccessor,
  spokeLibAccessor,
  assetLibAccessor,
  getV4Book,
} from '../marketBook';
import {readHubAssets, isAssetListedOnHub} from '../onchain';
import {promptFeeReceiver} from '../feeReceiver';
import {hubAssetListing} from '../hub/hubAssetListing';
import {hubSpokeToAssetsAddition} from '../hub/hubSpokeToAssetsAddition';
import {V4HubAssetListing, V4HubSpokeToAssetsAddition} from '../../types';
import {literal} from '../sentinels';
import {mergeArtifact} from '../bundleHelpers';

type BundleCfg = {
  listings: V4HubAssetListing[];
  spokeAdditions: V4HubSpokeToAssetsAddition[];
};

export const onboardAssetToHub: FeatureModule<BundleCfg> = {
  value: FEATURE.V4_USECASE_ONBOARD_ASSET_TO_HUB,
  description:
    'Bundle: onboard an asset to a Hub (skips listing if already present; optionally registers spokes)',
  async cli({market, cache}) {
    const m = market as MarketIdentifierV4;
    const book = getV4Book(m);
    const listings: V4HubAssetListing[] = [];
    const spokeAdditions: V4HubSpokeToAssetsAddition[] = [];
    let more = true;
    while (more) {
      const hub = await select({
        message: 'Select hub',
        choices: hubKeys(m).map((k) => ({name: k, value: k})),
      });
      const asset = await select({
        message: 'Select asset',
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
      });
      const underlying = book.ASSETS[asset].UNDERLYING as `0x${string}`;

      const hubAssets = await readHubAssets(m, hub, cache.blockNumber);
      const existing = isAssetListedOnHub(hubAssets, underlying);

      if (existing) {
        console.log(
          `${asset} already listed on ${hub} (assetId=${existing.assetId}). Skipping listing.`,
        );
      } else {
        const feeReceiver = await promptFeeReceiver(m);
        const liquidityFee = (await numberPrompt({message: 'liquidityFee (bps)'})) || '0';
        const irStrategy = await addressPrompt({message: 'IR strategy address', required: true});
        const optimalUsageRatio =
          (await numberPrompt({message: 'optimalUsageRatio (bps, uint16)'})) || '0';
        const baseDrawnRate = (await numberPrompt({message: 'baseDrawnRate (bps, uint32)'})) || '0';
        const rateGrowthBeforeOptimal =
          (await numberPrompt({message: 'rateGrowthBeforeOptimal (bps, uint32)'})) || '0';
        const rateGrowthAfterOptimal =
          (await numberPrompt({message: 'rateGrowthAfterOptimal (bps, uint32)'})) || '0';
        const withTokenization = await confirm({
          message: 'Deploy a TokenizationSpoke for this asset?',
          default: false,
        });
        let tokenization: V4HubAssetListing['tokenization'];
        if (withTokenization) {
          tokenization = {
            addCap: (await numberPrompt({message: 'TokenizationSpoke addCap'})) || '0',
            name: await input({message: 'TokenizationSpoke name'}),
            symbol: await input({message: 'TokenizationSpoke symbol'}),
          };
        }
        listings.push({
          hubLib: hubLibAccessor(m, hub),
          hub,
          underlying: assetLibAccessor(m, asset),
          feeReceiver: feeReceiver as `0x${string}`,
          liquidityFee,
          irStrategy: irStrategy as `0x${string}`,
          irData: {
            optimalUsageRatio: literal(optimalUsageRatio),
            baseDrawnRate: literal(baseDrawnRate),
            rateGrowthBeforeOptimal: literal(rateGrowthBeforeOptimal),
            rateGrowthAfterOptimal: literal(rateGrowthAfterOptimal),
          },
          tokenization,
        });
      }

      const targetSpokes = await checkbox({
        message: `Register ${asset} on which spokes? (none = skip)`,
        choices: spokeKeys(m).map((k) => ({name: k, value: k})),
      });
      for (const spoke of targetSpokes) {
        console.log(`Spoke config for ${asset} on ${spoke}`);
        spokeAdditions.push({
          hubLib: hubLibAccessor(m, hub),
          hub,
          spoke: spokeLibAccessor(m, spoke),
          assets: [
            {
              underlying: assetLibAccessor(m, asset),
              addCap: (await numberPrompt({message: 'addCap'})) || '0',
              drawCap: (await numberPrompt({message: 'drawCap'})) || '0',
              riskPremiumThreshold:
                (await numberPrompt({message: 'riskPremiumThreshold (bps)'})) || '0',
              active: await confirm({message: 'active?', default: true}),
              halted: await confirm({message: 'halted?', default: false}),
            },
          ],
        });
      }
      more = await confirm({message: 'Onboard another asset?', default: false});
    }
    return {listings, spokeAdditions};
  },
  build({options, market, cache, cfg, configs}) {
    const artifact: CodeArtifact = {code: {}};
    if (cfg.listings.length > 0) {
      mergeArtifact(
        artifact,
        hubAssetListing.build({options, market, cache, cfg: cfg.listings, configs}),
      );
    }
    if (cfg.spokeAdditions.length > 0) {
      mergeArtifact(
        artifact,
        hubSpokeToAssetsAddition.build({
          options,
          market,
          cache,
          cfg: cfg.spokeAdditions,
          configs,
        }),
      );
    }
    return artifact;
  },
};
