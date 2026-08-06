import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubSpokeDeactivation} from '../../types';
import {selectHub, selectSpokes} from '../hubSpokeSelect';
import {accessorIdentifier} from '../testHelpers';

export const hubSpokeDeactivation: FeatureModule<V4HubSpokeDeactivation[]> = {
  value: FEATURE.V4_HUB_SPOKE_DEACTIVATION,
  description: 'Hub: deactivate spokes',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const hub = await selectHub(m);
    const spokes = await selectSpokes(m, {message: 'Select spokes to deactivate', raw: true});
    return spokes.map((s) => ({
      hubLib: hub.expr,
      hub: hub.key,
      spoke: s.expr,
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
      const hubKey = accessorIdentifier(c.hubLib);
      const spokeKey = accessorIdentifier(c.spoke);
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
