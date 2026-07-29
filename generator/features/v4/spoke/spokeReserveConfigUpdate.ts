import {checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeReserveConfigUpdate} from '../../types';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub, selectSpokes} from '../hubSpokeSelect';
import {renderSentinel, renderBoolAsUint} from '../sentinels';
import {renderBpsSentinel} from '../units';
import {sentinelPercent, sentinelBool, sentinelAddress} from '../sentinelPrompts';
import {
  accessorIdentifier,
  assertBpsSentinelField,
  assertSentinelField,
  assetIdentifier,
  checksumAddress,
  wrapAddress,
} from '../testHelpers';

export const spokeReserveConfigUpdate: FeatureModule<V4SpokeReserveConfigUpdate[]> = {
  value: FEATURE.V4_SPOKE_RESERVE_CONFIG_UPDATE,
  description: 'Spoke: update reserve config (priceSource, paused, frozen, borrowable, …)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokeReserveConfigUpdate[] = [];
    const hub = await selectHub(m);
    const spokes = await selectSpokes(m, {message: 'Select spokes to update'});
    for (const spoke of spokes) {
      const assets = await checkbox({
        message: `Select reserves on ${spoke.key}`,
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
        required: true,
      });
      for (const asset of assets) {
        response.push({
          spokeLib: spoke.expr,
          spoke: spoke.expr,
          hub: hub.expr,
          underlying: assetLibAccessor(m, asset),
          priceSource: await sentinelAddress(`${spoke.key}/${asset} new priceSource`),
          collateralRisk: await sentinelPercent(`${spoke.key}/${asset} new collateralRisk (%)`),
          paused: await sentinelBool(`${spoke.key}/${asset} paused?`),
          frozen: await sentinelBool(`${spoke.key}/${asset} frozen?`),
          borrowable: await sentinelBool(`${spoke.key}/${asset} borrowable?`),
          receiveSharesEnabled: await sentinelBool(`${spoke.key}/${asset} receiveSharesEnabled?`),
        });
      }
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.ReserveConfigUpdate({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: ${wrapAddress(c.spoke)},
        hub: ${wrapAddress(c.hub)},
        underlying: ${checksumAddress(c.underlying)},
        priceSource: ${renderSentinel(c.priceSource)},
        collateralRisk: ${renderBpsSentinel(c.collateralRisk)},
        paused: ${renderBoolAsUint(c.paused)},
        frozen: ${renderBoolAsUint(c.frozen)},
        borrowable: ${renderBoolAsUint(c.borrowable)},
        receiveSharesEnabled: ${renderBoolAsUint(c.receiveSharesEnabled)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const spokeKey = accessorIdentifier(c.spoke);
      const assetKey = assetIdentifier(c.underlying);
      const asserts = [
        assertBpsSentinelField('collateralRisk', c.collateralRisk),
        assertSentinelField('paused', c.paused, 'bool'),
        assertSentinelField('frozen', c.frozen, 'bool'),
        assertSentinelField('borrowable', c.borrowable, 'bool'),
        assertSentinelField('receiveSharesEnabled', c.receiveSharesEnabled, 'bool'),
      ];
      return `function test_spokeReserveConfigUpdate_${spokeKey}_${assetKey}() public {
        ISpoke spoke = ISpoke(${wrapAddress(c.spoke)});
        IHub hub = IHub(${wrapAddress(c.hub)});
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        uint256 reserveId = spoke.getReserveId(address(hub), assetId);
        ISpoke.ReserveConfig memory before = spoke.getReserveConfig(reserveId);
        GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
        ${asserts.join('\n        ')}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          spokeReserveConfigUpdates: {
            returnType: 'IConfigEngine.ReserveConfigUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
