import {confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {percentPrompt} from '../../../prompts/percentPrompt';
import {selectHub, selectSpokes} from '../hubSpokeSelect';
import {selectAsset} from '../assetSelect';
import {readHubAssets, isAssetListedOnHub} from '../onchain';
import {hubAssetListing} from '../hub/hubAssetListing';
import {promptHubAssetListing} from '../hub/hubAssetListingPrompt';
import {hubSpokeToAssetsAddition} from '../hub/hubSpokeToAssetsAddition';
import {accessManagerTargetFunctionRoleUpdate} from '../access/accessManagerTargetFunctionRoleUpdate';
import {spokeWiring, hubWiring} from '../accessWiring';
import {
  V4HubAssetListing,
  V4HubSpokeToAssetsAddition,
  V4TargetFunctionRoleUpdate,
} from '../../types';
import {mergeArtifact} from '../bundleHelpers';

type BundleCfg = {
  targetFunctionRoles: V4TargetFunctionRoleUpdate[];
  listings: V4HubAssetListing[];
  spokeAdditions: V4HubSpokeToAssetsAddition[];
};

export const onboardAssetToHub: FeatureModule<BundleCfg> = {
  value: FEATURE.V4_USECASE_ONBOARD_ASSET_TO_HUB,
  description:
    'Bundle: onboard an asset to a Hub (fresh-deploy wiring; skips listing if already present; optionally registers spokes)',
  async cli({market, cache}) {
    const m = market as MarketIdentifierV4;
    const cfg: BundleCfg = {targetFunctionRoles: [], listings: [], spokeAdditions: []};
    const wiredSpokes = new Set<string>();
    const wiredHubs = new Set<string>();
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const asset = await selectAsset(m);

      if (hub.isNew && !wiredHubs.has(hub.expr)) {
        wiredHubs.add(hub.expr);
        if (
          await confirm({
            message: `Wire configurator, fee-minter & deficit-eliminator roles on fresh hub ${hub.key}?`,
            default: true,
          })
        ) {
          cfg.targetFunctionRoles.push(...hubWiring(hub.expr));
        }
      }

      const existing = hub.isNew
        ? undefined
        : isAssetListedOnHub(
            await readHubAssets(m, hub.address, cache.blockNumber),
            asset.underlying,
          );
      if (existing) {
        console.log(
          `${asset.label} already listed on ${hub.key} (assetId=${existing.assetId}). Skipping listing.`,
        );
      } else {
        cfg.listings.push(
          await promptHubAssetListing(m, {hubLib: hub.expr, hub: hub.key, underlying: asset.expr}),
        );
      }

      const targetSpokes = await selectSpokes(m, {
        message: `Register ${asset.label} on which spokes? (none = skip)`,
      });
      for (const spoke of targetSpokes) {
        if (spoke.isNew && !wiredSpokes.has(spoke.expr)) {
          wiredSpokes.add(spoke.expr);
          if (
            await confirm({
              message: `Wire SpokeConfigurator & user-position-updater roles on fresh spoke ${spoke.key}?`,
              default: true,
            })
          ) {
            cfg.targetFunctionRoles.push(...spokeWiring(m, spoke.expr));
          }
        }
        console.log(`Spoke config for ${asset.label} on ${spoke.key}`);
        const addCap = (await numberPrompt({message: 'addCap (whole units)'})) || '0';
        const drawCap = (await numberPrompt({message: 'drawCap (whole units)'})) || '0';
        const riskPremiumThreshold =
          (await percentPrompt({message: 'riskPremiumThreshold (%)'})) || '0';
        let active = true;
        let halted = false;
        if (await confirm({message: 'Customize active/halted flags?', default: false})) {
          active = await confirm({message: 'active?', default: true});
          halted = await confirm({message: 'halted?', default: false});
        }
        cfg.spokeAdditions.push({
          hubLib: hub.expr,
          hub: hub.key,
          spoke: spoke.expr,
          assets: [{underlying: asset.expr, addCap, drawCap, riskPremiumThreshold, active, halted}],
        });
      }
      more = await confirm({message: 'Onboard another asset?', default: false});
    }
    return cfg;
  },
  build({options, market, cache, cfg, configs}) {
    const artifact: CodeArtifact = {code: {}};
    const delegate = (mod: {build: Function}, sub: unknown[]) => {
      if (sub.length > 0)
        mergeArtifact(artifact, mod.build({options, market, cache, cfg: sub, configs}));
    };
    delegate(accessManagerTargetFunctionRoleUpdate, cfg.targetFunctionRoles ?? []);
    delegate(hubAssetListing, cfg.listings ?? []);
    delegate(hubSpokeToAssetsAddition, cfg.spokeAdditions ?? []);
    return artifact;
  },
};
