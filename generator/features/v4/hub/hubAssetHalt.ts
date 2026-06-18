import {select, checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetHalt} from '../../types';
import {hubKeys, assetKeys, hubLibAccessor, assetLibAccessor} from '../marketBook';
import {shortKey, checksumAddress} from '../testHelpers';

export const hubAssetHalt: FeatureModule<V4HubAssetHalt[]> = {
  value: FEATURE.V4_HUB_ASSET_HALT,
  description: 'Hub: halt assets',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const hub = await select({
      message: 'Select hub',
      choices: hubKeys(m).map((k) => ({name: k, value: k})),
    });
    const assets = await checkbox({
      message: 'Select assets to halt',
      choices: assetKeys(m).map((k) => ({name: k, value: k})),
      required: true,
    });
    return assets.map((asset) => ({
      hubLib: hubLibAccessor(m, hub),
      hub: hub,
      underlying: assetLibAccessor(m, asset),
    }));
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.AssetHalt({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: address(${c.hubLib}),
        underlying: ${checksumAddress(c.underlying)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = shortKey(c.hubLib);
      const assetKey = shortKey(c.underlying);
      return `function test_hubAssetHalt_${hubKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub hub = IHub(address(${c.hubLib}));
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        uint256 spokeCount = hub.getSpokeCount(assetId);
        for (uint256 i; i < spokeCount; i++) {
          address spoke = hub.getSpokeAddress(assetId, i);
          assertTrue(hub.getSpokeConfig(assetId, spoke).halted, 'spoke not halted');
        }
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          hubAssetHalts: {
            returnType: 'IConfigEngine.AssetHalt',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
