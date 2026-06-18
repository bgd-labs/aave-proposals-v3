import {select, checkbox, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {
  hubKeys,
  spokeKeys,
  assetKeys,
  hubLibAccessor,
  spokeLibAccessor,
  assetLibAccessor,
  getV4Book,
} from '../marketBook';
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
      const hub = await select({
        message: 'Select hub',
        choices: hubKeys(m).map((k) => ({name: k, value: k})),
      });
      const hubAssets = await readHubAssets(m, hub, cache.blockNumber);

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
          hub,
          hubAsset.assetId,
          cache.blockNumber,
        );
        const lowerRegistered = new Set(registeredSpokeAddrs.map((a) => a.toLowerCase()));
        const candidateSpokes = spokeKeys(m).filter((k) =>
          lowerRegistered.has((book.SPOKES[k] as string).toLowerCase()),
        );
        if (candidateSpokes.length === 0) {
          console.log(`No spokes registered on ${hub} for ${asset}; skipping.`);
          continue;
        }
        const spokes = await checkbox({
          message: `Select spokes for ${asset}`,
          choices: candidateSpokes.map((k) => ({name: k, value: k})),
          required: true,
        });
        for (const spoke of spokes) {
          updates.push({
            hubLib: hubLibAccessor(m, hub),
            hub,
            underlying: assetLibAccessor(m, asset),
            spoke: spokeLibAccessor(m, spoke),
            addCap: await sentinelNumber(`${spoke}/${asset} addCap`),
            drawCap: await sentinelNumber(`${spoke}/${asset} drawCap`),
            riskPremiumThreshold: await sentinelNumber(
              `${spoke}/${asset} riskPremiumThreshold (bps)`,
            ),
            active: await sentinelBool(`${spoke}/${asset} active?`),
            halted: await sentinelBool(`${spoke}/${asset} halted?`),
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
