import {select, checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubSpokeDeactivation} from '../../types';
import {hubKeys, rawSpokeKeys, hubLibAccessor} from '../marketBook';
import {shortKey} from '../testHelpers';

export const hubSpokeDeactivation: FeatureModule<V4HubSpokeDeactivation[]> = {
  value: FEATURE.V4_HUB_SPOKE_DEACTIVATION,
  description: 'Hub: deactivate spokes',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const hub = await select({
      message: 'Select hub',
      choices: hubKeys(m).map((k) => ({name: k, value: k})),
    });
    const spokes = await checkbox({
      message: 'Select spokes to deactivate',
      choices: rawSpokeKeys(m).map((s) => ({name: s.key, value: s})),
      required: true,
    });
    return spokes.map((s) => ({
      hubLib: hubLibAccessor(m, hub),
      hub: hub,
      spoke: s.accessor,
    }));
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.SpokeDeactivation({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: address(${c.hubLib}),
        spoke: address(${c.spoke})
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = shortKey(c.hubLib);
      const spokeKey = shortKey(c.spoke);
      return `function test_hubSpokeDeactivation_${hubKey}_${spokeKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub hub = IHub(address(${c.hubLib}));
        uint256 assetCount = hub.getAssetCount();
        for (uint256 i; i < assetCount; i++) {
          if (hub.isSpokeListed(i, address(${c.spoke}))) {
            assertFalse(hub.getSpokeConfig(i, address(${c.spoke})).active, 'spoke still active');
          }
        }
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          hubSpokeDeactivations: {
            returnType: 'IConfigEngine.SpokeDeactivation',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
