import {select, checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubSpokeConfigUpdate} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {
  getV4Book,
  hubKeys,
  rawSpokeKeys,
  assetKeys,
  hubLibAccessor,
  assetLibAccessor,
} from '../marketBook';
import {
  keepCurrent,
  keepCurrentAddress,
  literal,
  renderSentinel,
  renderBoolAsUint,
  enabled,
  disabled,
} from '../sentinels';
import {Sentinel} from '../../types';
import {assertSentinelField, shortKey, checksumAddress} from '../testHelpers';

async function sentinelNumberPrompt(message: string): Promise<Sentinel> {
  const value = await numberPrompt({message: `${message} (empty = keep current)`});
  if (!value || value.length === 0) return keepCurrent();
  return literal(value.replace(/\B(?=(\d{3})+(?!\d))/g, '_'));
}

async function sentinelBoolPrompt(message: string): Promise<Sentinel> {
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

export const hubSpokeConfigUpdate: FeatureModule<V4HubSpokeConfigUpdate[]> = {
  value: FEATURE.V4_HUB_SPOKE_CONFIG_UPDATE,
  description: 'Hub: update Spoke config (caps, riskPremiumThreshold, active, halted)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4HubSpokeConfigUpdate[] = [];
    const hub = await select({
      message: 'Select hub',
      choices: hubKeys(m).map((k) => ({name: k, value: k})),
    });
    const spokes = await checkbox({
      message: 'Select spokes to update',
      choices: rawSpokeKeys(m).map((s) => ({name: s.key, value: s})),
      required: true,
    });
    for (const spoke of spokes) {
      const assets = await checkbox({
        message: `Select assets for ${spoke.key}`,
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
        required: true,
      });
      for (const asset of assets) {
        response.push({
          hubLib: hubLibAccessor(m, hub),
          hub: hub,
          underlying: assetLibAccessor(m, asset),
          spoke: spoke.accessor,
          addCap: await sentinelNumberPrompt(`${spoke.key}/${asset} new addCap`),
          drawCap: await sentinelNumberPrompt(`${spoke.key}/${asset} new drawCap`),
          riskPremiumThreshold: await sentinelNumberPrompt(
            `${spoke.key}/${asset} new riskPremiumThreshold (bps)`,
          ),
          active: await sentinelBoolPrompt(`${spoke.key}/${asset} active?`),
          halted: await sentinelBoolPrompt(`${spoke.key}/${asset} halted?`),
        });
      }
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.SpokeConfigUpdate({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: address(${c.hubLib}),
        underlying: ${checksumAddress(c.underlying)},
        spoke: address(${c.spoke}),
        addCap: ${renderSentinel(c.addCap)},
        drawCap: ${renderSentinel(c.drawCap)},
        riskPremiumThreshold: ${renderSentinel(c.riskPremiumThreshold)},
        active: ${renderBoolAsUint(c.active)},
        halted: ${renderBoolAsUint(c.halted)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = shortKey(c.hubLib);
      const spokeKey = shortKey(c.spoke);
      const assetKey = shortKey(c.underlying);
      const asserts = [
        assertSentinelField('addCap', c.addCap, 'uint'),
        assertSentinelField('drawCap', c.drawCap, 'uint'),
        assertSentinelField('riskPremiumThreshold', c.riskPremiumThreshold, 'uint'),
        assertSentinelField('active', c.active, 'bool'),
        assertSentinelField('halted', c.halted, 'bool'),
      ];
      return `function test_hubSpokeConfigUpdate_${hubKey}_${spokeKey}_${assetKey}() public {
        IHub hub = IHub(address(${c.hubLib}));
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        IHub.SpokeConfig memory before = hub.getSpokeConfig(assetId, address(${c.spoke}));
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, address(${c.spoke}));
        ${asserts.join('\n        ')}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          hubSpokeConfigUpdates: {
            returnType: 'IConfigEngine.SpokeConfigUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
