import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubSpokeCapsReset} from '../../types';
import {selectHub, selectSpokes} from '../hubSpokeSelect';
import {accessorIdentifier} from '../testHelpers';

export const hubSpokeCapsReset: FeatureModule<V4HubSpokeCapsReset[]> = {
  value: FEATURE.V4_HUB_SPOKE_CAPS_RESET,
  description: 'Hub: reset spoke caps',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const hub = await selectHub(m);
    const spokes = await selectSpokes(m, {message: 'Select spokes to reset caps', raw: true});
    return spokes.map((s) => ({
      hubLib: hub.expr,
      hub: hub.key,
      spoke: s.expr,
    }));
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.SpokeCapsReset({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: address(${c.hubLib}),
        spoke: address(${c.spoke})
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = accessorIdentifier(c.hubLib);
      const spokeKey = accessorIdentifier(c.spoke);
      return `function test_hubSpokeCapsReset_${hubKey}_${spokeKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub hub = IHub(address(${c.hubLib}));
        uint256 assetCount = hub.getAssetCount();
        for (uint256 i; i < assetCount; i++) {
          if (hub.isSpokeListed(i, address(${c.spoke}))) {
            IHub.SpokeConfig memory cfg = hub.getSpokeConfig(i, address(${c.spoke}));
            assertEq(uint256(cfg.addCap), 0, 'addCap not reset');
            assertEq(uint256(cfg.drawCap), 0, 'drawCap not reset');
          }
        }
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          hubSpokeCapsResets: {
            returnType: 'IConfigEngine.SpokeCapsReset',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
