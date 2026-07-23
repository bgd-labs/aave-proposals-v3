import {select, checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeReserveConfigUpdate} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub, selectSpokes} from '../hubSpokeSelect';
import {
  keepCurrent,
  keepCurrentAddress,
  literal,
  renderSentinel,
  renderBoolAsUint,
  enabled,
  disabled,
} from '../sentinels';
import {Sentinel} from '../../types';
import {
  accessorIdentifier,
  assertSentinelField,
  assetIdentifier,
  checksumAddress,
} from '../testHelpers';

async function sentinelNumberPrompt(message: string): Promise<Sentinel> {
  const value = await numberPrompt({message: `${message} (empty = keep current)`});
  if (!value || value.length === 0) return keepCurrent();
  return literal(value.replace(/\B(?=(\d{3})+(?!\d))/g, '_'));
}

async function sentinelBoolPrompt(message: string): Promise<Sentinel> {
  const choice = await select({
    message,
    choices: [
      {name: 'keep current', value: 'keep'},
      {name: 'enable', value: 'enable'},
      {name: 'disable', value: 'disable'},
    ],
    default: 'keep',
  });
  if (choice === 'enable') return enabled();
  if (choice === 'disable') return disabled();
  return keepCurrent();
}

async function sentinelAddressPrompt(message: string): Promise<Sentinel> {
  const value = await addressPrompt({message: `${message} (empty = keep current)`});
  if (!value || value.length === 0) return keepCurrentAddress();
  return literal(value);
}

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
          priceSource: await sentinelAddressPrompt(`${spoke.key}/${asset} new priceSource`),
          collateralRisk: await sentinelNumberPrompt(
            `${spoke.key}/${asset} new collateralRisk (bps)`,
          ),
          paused: await sentinelBoolPrompt(`${spoke.key}/${asset} paused?`),
          frozen: await sentinelBoolPrompt(`${spoke.key}/${asset} frozen?`),
          borrowable: await sentinelBoolPrompt(`${spoke.key}/${asset} borrowable?`),
          receiveSharesEnabled: await sentinelBoolPrompt(
            `${spoke.key}/${asset} receiveSharesEnabled?`,
          ),
        });
      }
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.ReserveConfigUpdate({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: address(${c.spoke}),
        hub: address(${c.hub}),
        underlying: ${checksumAddress(c.underlying)},
        priceSource: ${renderSentinel(c.priceSource)},
        collateralRisk: ${renderSentinel(c.collateralRisk)},
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
        assertSentinelField('collateralRisk', c.collateralRisk, 'uint'),
        assertSentinelField('paused', c.paused, 'bool'),
        assertSentinelField('frozen', c.frozen, 'bool'),
        assertSentinelField('borrowable', c.borrowable, 'bool'),
        assertSentinelField('receiveSharesEnabled', c.receiveSharesEnabled, 'bool'),
      ];
      return `function test_spokeReserveConfigUpdate_${spokeKey}_${assetKey}() public {
        ISpoke spoke = ISpoke(address(${c.spoke}));
        IHub hub = IHub(address(${c.hub}));
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
