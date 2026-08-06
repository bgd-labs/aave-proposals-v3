import {select, checkbox, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {spokeKeys, assetKeys, assetLibAccessor, getV4Book} from '../marketBook';
import {selectHub, selectSpokes} from '../hubSpokeSelect';
import {readHubAssets, readHubSpokeAddresses} from '../onchain';
import {hubSpokeConfigUpdate} from '../hub/hubSpokeConfigUpdate';
import {V4HubSpokeConfigUpdate} from '../../types';
import {keepCurrent, literal, enabled, disabled} from '../sentinels';
import {Sentinel} from '../../types';

async function sentinelNumber(message: string): Promise<Sentinel> {
  const v = await numberPrompt({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrent();
  return literal(v.replace(/\B(?=(\d{3})+(?!\d))/g, '_'));
}

async function sentinelBool(message: string): Promise<Sentinel> {
  const choice = await select({
    message,
    choices: [
      {name: 'keep current', value: 'keep'},
      {name: 'enable', value: 'enable'},
      {name: 'disable', value: 'disable'},
    ],
    default: 'keep',
  });
  if (choice === 'enable') return enabled();
  if (choice === 'disable') return disabled();
  return keepCurrent();
}

export const tuneSpokeRisk: FeatureModule<V4HubSpokeConfigUpdate[]> = {
  value: FEATURE.V4_USECASE_TUNE_SPOKE_RISK,
  description: 'Bundle: tune Spoke caps/risk per (hub, spoke, asset) with on-chain validation',
  async cli({market, cache}) {
    const m = market as MarketIdentifierV4;
    const book = getV4Book(m);
    const updates: V4HubSpokeConfigUpdate[] = [];
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const hubAssets = await readHubAssets(m, hub.address, cache.blockNumber);

      const candidateAssets = assetKeys(m).filter((k) =>
        hubAssets.some(
          (a) => a.underlying.toLowerCase() === (book.ASSETS[k].UNDERLYING as string).toLowerCase(),
        ),
      );
      const assets = await checkbox({
        message: 'Select assets to tune (only assets already listed on hub are shown)',
        choices: candidateAssets.map((k) => ({name: k, value: k})),
        required: true,
      });

      for (const asset of assets) {
        const underlying = book.ASSETS[asset].UNDERLYING as `0x${string}`;
        const hubAsset = hubAssets.find(
          (a) => a.underlying.toLowerCase() === underlying.toLowerCase(),
        )!;
        const registeredSpokeAddrs = await readHubSpokeAddresses(
          m,
          hub.address,
          hubAsset.assetId,
          cache.blockNumber,
        );
        const lowerRegistered = new Set(registeredSpokeAddrs.map((a) => a.toLowerCase()));
        const candidateSpokes = spokeKeys(m).filter((k) =>
          lowerRegistered.has((book.SPOKES[k] as string).toLowerCase()),
        );
        if (candidateSpokes.length === 0) {
          console.log(`No spokes registered on ${hub.key} for ${asset}; skipping.`);
          continue;
        }
        const spokes = await selectSpokes(m, {
          message: `Select spokes for ${asset}`,
          only: candidateSpokes,
        });
        for (const spoke of spokes) {
          updates.push({
            hubLib: hub.expr,
            hub: hub.key,
            underlying: assetLibAccessor(m, asset),
            spoke: spoke.expr,
            addCap: await sentinelNumber(`${spoke.key}/${asset} addCap`),
            drawCap: await sentinelNumber(`${spoke.key}/${asset} drawCap`),
            riskPremiumThreshold: await sentinelNumber(
              `${spoke.key}/${asset} riskPremiumThreshold (bps)`,
            ),
            active: await sentinelBool(`${spoke.key}/${asset} active?`),
            halted: await sentinelBool(`${spoke.key}/${asset} halted?`),
          });
        }
      }
      more = await confirm({message: 'Tune more spokes?', default: false});
    }
    return updates;
  },
  build({options, market, cache, cfg, configs}) {
    if (cfg.length === 0) return {code: {}};
    return hubSpokeConfigUpdate.build({options, market, cache, cfg, configs});
  },
};
