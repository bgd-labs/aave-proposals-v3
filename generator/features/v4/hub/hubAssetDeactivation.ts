import {select, checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetDeactivation} from '../../types';
import {hubKeys, assetKeys, hubLibAccessor, assetLibAccessor} from '../marketBook';
import {shortKey, solAddress} from '../testHelpers';

export const hubAssetDeactivation: FeatureModule<V4HubAssetDeactivation[]> = {
  value: FEATURE.V4_HUB_ASSET_DEACTIVATION,
  description: 'Hub: deactivate assets',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const hub = await select({
      message: 'Select hub',
      choices: hubKeys(m).map((k) => ({name: k, value: k})),
    });
    const assets = await checkbox({
      message: 'Select assets to deactivate',
      choices: assetKeys(m).map((k) => ({name: k, value: k})),
      required: true,
    });
    return assets.map((asset) => ({
      hubLib: hubLibAccessor(m, hub),
      hub: hub,
      underlying: assetLibAccessor(m, asset),
    }));
  },
  build({cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IAaveV4ConfigEngine.AssetDeactivation({
        hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
        hub: address(${c.hubLib}),
        underlying: ${solAddress(c.underlying)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = shortKey(c.hubLib);
      const assetKey = shortKey(c.underlying);
      return `function test_hubAssetDeactivation_${hubKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub hub = IHub(address(${c.hubLib}));
        uint256 assetId = hub.getAssetId(${solAddress(c.underlying)});
        uint256 spokeCount = hub.getSpokeCount(assetId);
        for (uint256 i; i < spokeCount; i++) {
          address spoke = hub.getSpokeAddress(assetId, i);
          assertFalse(hub.getSpokeConfig(assetId, spoke).active, 'spoke still active');
        }
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          hubAssetDeactivations: {
            returnType: 'IAaveV4ConfigEngine.AssetDeactivation',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
