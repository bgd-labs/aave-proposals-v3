import {select, checkbox, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubSpokeToAssetsAddition} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {hubKeys, rawSpokeKeys, assetKeys, hubLibAccessor, assetLibAccessor} from '../marketBook';
import {shortKey, checksumAddress} from '../testHelpers';

export const hubSpokeToAssetsAddition: FeatureModule<V4HubSpokeToAssetsAddition[]> = {
  value: FEATURE.V4_HUB_SPOKE_TO_ASSETS_ADDITION,
  description: 'Hub: register a Spoke for multiple assets',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4HubSpokeToAssetsAddition[] = [];
    let more = true;
    while (more) {
      const hub = await select({
        message: 'Select hub',
        choices: hubKeys(m).map((k) => ({name: k, value: k})),
      });
      const spoke = await select({
        message: 'Select spoke',
        choices: rawSpokeKeys(m).map((s) => ({name: s.key, value: s})),
      });
      const assets = await checkbox({
        message: 'Select assets to register on the spoke',
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
        required: true,
      });
      const assetConfigs = [] as V4HubSpokeToAssetsAddition['assets'];
      for (const asset of assets) {
        console.log(`Config for ${asset} on ${spoke.key}`);
        assetConfigs.push({
          underlying: assetLibAccessor(m, asset),
          addCap: (await numberPrompt({message: `${asset} addCap (uint40, whole units)`})) || '0',
          drawCap: (await numberPrompt({message: `${asset} drawCap (uint40, whole units)`})) || '0',
          riskPremiumThreshold:
            (await numberPrompt({message: `${asset} riskPremiumThreshold (bps)`})) || '0',
          active: await confirm({message: `${asset} active?`, default: true}),
          halted: await confirm({message: `${asset} halted?`, default: false}),
        });
      }
      response.push({
        hubLib: hubLibAccessor(m, hub),
        hub,
        spoke: spoke.accessor,
        assets: assetConfigs,
      });
      more = await confirm({message: 'Register another spoke?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map((c) => {
      const inner = c.assets
        .map(
          (a, jx) => `subAssets[${jx}] = IConfigEngine.SpokeAssetConfig({
            underlying: ${checksumAddress(a.underlying)},
            config: IHub.SpokeConfig({
              addCap: ${a.addCap},
              drawCap: ${a.drawCap},
              riskPremiumThreshold: ${a.riskPremiumThreshold},
              active: ${a.active},
              halted: ${a.halted}
            })
          });`,
        )
        .join('\n');
      return `{
        IConfigEngine.SpokeAssetConfig[] memory subAssets = new IConfigEngine.SpokeAssetConfig[](${c.assets.length});
        ${inner}
        items[__INDEX__] = IConfigEngine.SpokeToAssetsAddition({
          hubConfigurator: ${market}.HUB_CONFIGURATOR,
          hub: address(${c.hubLib}),
          spoke: address(${c.spoke}),
          assets: subAssets
        });
      }`;
    });
    const testFns: string[] = [];
    for (const c of cfg) {
      const hubKey = shortKey(c.hubLib);
      const spokeKey = shortKey(c.spoke);
      for (const a of c.assets) {
        const assetKey = shortKey(a.underlying);
        testFns.push(
          `function test_hubSpokeToAssetsAddition_${hubKey}_${spokeKey}_${assetKey}() public {
            GovV3Helpers.executePayload(vm, address(proposal));
            IHub hub = IHub(address(${c.hubLib}));
            uint256 assetId = hub.getAssetId(${checksumAddress(a.underlying)});
            assertTrue(hub.isSpokeListed(assetId, address(${c.spoke})), 'spoke not listed');
            IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, address(${c.spoke}));
            assertEq(uint256(cfg.addCap), uint256(${a.addCap}), 'addCap mismatch');
            assertEq(uint256(cfg.drawCap), uint256(${a.drawCap}), 'drawCap mismatch');
            assertEq(uint256(cfg.riskPremiumThreshold), uint256(${a.riskPremiumThreshold}), 'riskPremiumThreshold mismatch');
            assertEq(cfg.active, ${a.active}, 'active mismatch');
            assertEq(cfg.halted, ${a.halted}, 'halted mismatch');
          }`,
        );
      }
    }
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          hubSpokeToAssetsAdditions: {
            returnType: 'IConfigEngine.SpokeToAssetsAddition',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
