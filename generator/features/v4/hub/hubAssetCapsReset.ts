import {checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetCapsReset} from '../../types';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub} from '../hubSpokeSelect';
import {accessorIdentifier, shortKey, checksumAddress} from '../testHelpers';

export const hubAssetCapsReset: FeatureModule<V4HubAssetCapsReset[]> = {
  value: FEATURE.V4_HUB_ASSET_CAPS_RESET,
  description: 'Hub: reset asset caps',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const hub = await selectHub(m);
    const assets = await checkbox({
      message: 'Select assets to reset caps',
      choices: assetKeys(m).map((k) => ({name: k, value: k})),
      required: true,
    });
    return assets.map((asset) => ({
      hubLib: hub.expr,
      hub: hub.key,
      underlying: assetLibAccessor(m, asset),
    }));
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.AssetCapsReset({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: address(${c.hubLib}),
        underlying: ${checksumAddress(c.underlying)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = accessorIdentifier(c.hubLib);
      const assetKey = shortKey(c.underlying);
      return `function test_hubAssetCapsReset_${hubKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub hub = IHub(address(${c.hubLib}));
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        uint256 spokeCount = hub.getSpokeCount(assetId);
        for (uint256 i; i < spokeCount; i++) {
          address spoke = hub.getSpokeAddress(assetId, i);
          IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, spoke);
          assertEq(uint256(cfg.addCap), 0, 'addCap not reset');
          assertEq(uint256(cfg.drawCap), 0, 'drawCap not reset');
        }
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          hubAssetCapsResets: {
            returnType: 'IConfigEngine.AssetCapsReset',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
