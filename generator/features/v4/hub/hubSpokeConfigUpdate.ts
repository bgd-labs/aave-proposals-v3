import {checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubSpokeConfigUpdate} from '../../types';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub, selectSpokes} from '../hubSpokeSelect';
import {renderSentinel, renderBoolAsUint} from '../sentinels';
import {renderBpsSentinel} from '../units';
import {sentinelWhole, sentinelPercent, sentinelBool} from '../sentinelPrompts';
import {
  accessorIdentifier,
  assertBpsSentinelField,
  assertSentinelField,
  shortKey,
  checksumAddress,
  wrapAddress,
} from '../testHelpers';

export const hubSpokeConfigUpdate: FeatureModule<V4HubSpokeConfigUpdate[]> = {
  value: FEATURE.V4_HUB_SPOKE_CONFIG_UPDATE,
  description: 'Hub: update Spoke config (caps, riskPremiumThreshold, active, halted)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4HubSpokeConfigUpdate[] = [];
    const hub = await selectHub(m);
    const spokes = await selectSpokes(m, {message: 'Select spokes to update', raw: true});
    for (const spoke of spokes) {
      const assets = await checkbox({
        message: `Select assets for ${spoke.key}`,
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
        required: true,
      });
      for (const asset of assets) {
        response.push({
          hubLib: hub.expr,
          hub: hub.key,
          underlying: assetLibAccessor(m, asset),
          spoke: spoke.expr,
          addCap: await sentinelWhole(`${spoke.key}/${asset} new addCap (whole units)`),
          drawCap: await sentinelWhole(`${spoke.key}/${asset} new drawCap (whole units)`),
          riskPremiumThreshold: await sentinelPercent(
            `${spoke.key}/${asset} new riskPremiumThreshold (%)`,
          ),
          active: await sentinelBool(`${spoke.key}/${asset} active?`),
          halted: await sentinelBool(`${spoke.key}/${asset} halted?`),
        });
      }
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.SpokeConfigUpdate({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: ${wrapAddress(c.hubLib)},
        underlying: ${checksumAddress(c.underlying)},
        spoke: ${wrapAddress(c.spoke)},
        addCap: ${renderSentinel(c.addCap)},
        drawCap: ${renderSentinel(c.drawCap)},
        riskPremiumThreshold: ${renderBpsSentinel(c.riskPremiumThreshold)},
        active: ${renderBoolAsUint(c.active)},
        halted: ${renderBoolAsUint(c.halted)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = accessorIdentifier(c.hubLib);
      const spokeKey = accessorIdentifier(c.spoke);
      const assetKey = shortKey(c.underlying);
      const asserts = [
        assertSentinelField('addCap', c.addCap, 'uint'),
        assertSentinelField('drawCap', c.drawCap, 'uint'),
        assertBpsSentinelField('riskPremiumThreshold', c.riskPremiumThreshold),
        assertSentinelField('active', c.active, 'bool'),
        assertSentinelField('halted', c.halted, 'bool'),
      ];
      return `function test_hubSpokeConfigUpdate_${hubKey}_${spokeKey}_${assetKey}() public {
        IHub hub = IHub(${wrapAddress(c.hubLib)});
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        IHub.SpokeConfig memory before = hub.getSpokeConfig(assetId, ${wrapAddress(c.spoke)});
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, ${wrapAddress(c.spoke)});
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
