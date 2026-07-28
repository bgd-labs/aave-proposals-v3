import {checkbox, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubSpokeToAssetsAddition} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {percentPrompt} from '../../../prompts/percentPrompt';
import {groupThousands, percentToBps} from '../units';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub, selectSpoke} from '../hubSpokeSelect';
import {
  accessorIdentifier,
  assetIdentifier,
  checksumAddress,
  testAddressRef,
  wrapAddress,
} from '../testHelpers';

/// Merge every entry targeting the same (hub, spoke) into a single registration
/// carrying all its assets, so onboarding N assets on one spoke emits one item with
/// an N-asset array instead of N items.
function aggregateByHubSpoke(cfg: V4HubSpokeToAssetsAddition[]): V4HubSpokeToAssetsAddition[] {
  const merged = new Map<string, V4HubSpokeToAssetsAddition>();
  for (const c of cfg) {
    const key = `${c.hubLib}|${c.spoke}`;
    const existing = merged.get(key);
    if (existing) existing.assets = [...existing.assets, ...c.assets];
    else merged.set(key, {...c, assets: [...c.assets]});
  }
  return [...merged.values()];
}

export const hubSpokeToAssetsAddition: FeatureModule<V4HubSpokeToAssetsAddition[]> = {
  value: FEATURE.V4_HUB_SPOKE_TO_ASSETS_ADDITION,
  description: 'Hub: register a Spoke for multiple assets',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4HubSpokeToAssetsAddition[] = [];
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const spoke = await selectSpoke(m, {raw: true});
      const assets = await checkbox({
        message: 'Select assets to register on the spoke',
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
        required: true,
      });
      const assetConfigs = [] as V4HubSpokeToAssetsAddition['assets'];
      for (const asset of assets) {
        console.log(`Config for ${asset} on ${spoke.key}`);
        const addCap = (await numberPrompt({message: `${asset} addCap (whole units)`})) || '0';
        const drawCap = (await numberPrompt({message: `${asset} drawCap (whole units)`})) || '0';
        const riskPremiumThreshold =
          (await percentPrompt({message: `${asset} riskPremiumThreshold (%)`})) || '0';
        let active = true;
        let halted = false;
        const customize = await confirm({
          message: `${asset}: customize active/halted flags?`,
          default: false,
        });
        if (customize) {
          active = await confirm({message: `${asset} active?`, default: true});
          halted = await confirm({message: `${asset} halted?`, default: false});
        }
        assetConfigs.push({
          underlying: assetLibAccessor(m, asset),
          addCap,
          drawCap,
          riskPremiumThreshold,
          active,
          halted,
        });
      }
      response.push({
        hubLib: hub.expr,
        hub: hub.key,
        spoke: spoke.expr,
        assets: assetConfigs,
      });
      more = await confirm({message: 'Register another spoke?', default: false});
    }
    return response;
  },
  build({market, cfg: rawCfg}) {
    const cfg = aggregateByHubSpoke(rawCfg);
    const entries = cfg.map((c) => {
      const inner = c.assets
        .map(
          (a, jx) => `subAssets[${jx}] = IConfigEngine.SpokeAssetConfig({
            underlying: ${checksumAddress(a.underlying)},
            config: IHub.SpokeConfig({
              addCap: ${groupThousands(a.addCap)},
              drawCap: ${groupThousands(a.drawCap)},
              riskPremiumThreshold: ${percentToBps(a.riskPremiumThreshold)},
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
          hub: ${wrapAddress(c.hubLib)},
          spoke: ${wrapAddress(c.spoke)},
          assets: subAssets
        });
      }`;
    });
    const inputAsserts = cfg.flatMap((c, ix) => [
      `assertEq(items[${ix}].spoke, ${testAddressRef(c.spoke)}, 'spoke');`,
      `assertEq(items[${ix}].assets.length, ${c.assets.length}, 'assets length');`,
      ...c.assets.flatMap((a, jx) => [
        `assertEq(items[${ix}].assets[${jx}].underlying, ${testAddressRef(a.underlying)}, 'underlying');`,
        `assertEq(uint256(items[${ix}].assets[${jx}].config.addCap), ${groupThousands(a.addCap)}, 'addCap');`,
        `assertEq(uint256(items[${ix}].assets[${jx}].config.drawCap), ${groupThousands(a.drawCap)}, 'drawCap');`,
        `assertEq(uint256(items[${ix}].assets[${jx}].config.riskPremiumThreshold), ${percentToBps(a.riskPremiumThreshold)}, 'riskPremiumThreshold');`,
        `assertEq(items[${ix}].assets[${jx}].config.active, ${a.active}, 'active');`,
        `assertEq(items[${ix}].assets[${jx}].config.halted, ${a.halted}, 'halted');`,
      ]),
    ]);
    const inputTest = `function test_hubSpokeToAssetsAdditionsInput() public view {
        IConfigEngine.SpokeToAssetsAddition[] memory items = proposal.hubSpokeToAssetsAdditions();
        assertEq(items.length, ${cfg.length}, 'length');
        ${inputAsserts.join('\n        ')}
      }`;
    const testFns: string[] = [];
    for (const c of cfg) {
      const hubKey = accessorIdentifier(c.hubLib);
      const spokeKey = accessorIdentifier(c.spoke);
      for (const a of c.assets) {
        const assetKey = assetIdentifier(a.underlying);
        testFns.push(
          `function test_hubSpokeToAssetsAddition_${hubKey}_${spokeKey}_${assetKey}() public {
            GovV3Helpers.executePayload(vm, address(proposal));
            IHub hub = IHub(${wrapAddress(c.hubLib)});
            uint256 assetId = hub.getAssetId(${testAddressRef(a.underlying)});
            assertTrue(hub.isSpokeListed(assetId, ${testAddressRef(c.spoke)}), 'spoke not listed');
            IHub.SpokeConfig memory cfg = hub.getSpokeConfig(assetId, ${testAddressRef(c.spoke)});
            assertEq(uint256(cfg.addCap), uint256(${groupThousands(a.addCap)}), 'addCap mismatch');
            assertEq(uint256(cfg.drawCap), uint256(${groupThousands(a.drawCap)}), 'drawCap mismatch');
            assertEq(uint256(cfg.riskPremiumThreshold), uint256(${percentToBps(a.riskPremiumThreshold)}), 'riskPremiumThreshold mismatch');
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
      test: {fn: [inputTest, ...testFns]},
    };
    return response;
  },
};
