import {select, checkbox} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeReserveConfigUpdate} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {
  hubKeys,
  spokeKeys,
  assetKeys,
  hubLibAccessor,
  spokeLibAccessor,
  assetLibAccessor,
} from '../marketBook';
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
import {isLiteral, literalValue, shortKey, checksumAddress} from '../testHelpers';

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
    const hub = await select({
      message: 'Select hub',
      choices: hubKeys(m).map((k) => ({name: k, value: k})),
    });
    const spokes = await checkbox({
      message: 'Select spokes to update',
      choices: spokeKeys(m).map((k) => ({name: k, value: k})),
      required: true,
    });
    for (const spoke of spokes) {
      const assets = await checkbox({
        message: `Select reserves on ${spoke}`,
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
        required: true,
      });
      for (const asset of assets) {
        response.push({
          spokeLib: spokeLibAccessor(m, spoke),
          spoke: spokeLibAccessor(m, spoke),
          hub: hubLibAccessor(m, hub),
          underlying: assetLibAccessor(m, asset),
          priceSource: await sentinelAddressPrompt(`${spoke}/${asset} new priceSource`),
          collateralRisk: await sentinelNumberPrompt(`${spoke}/${asset} new collateralRisk (bps)`),
          paused: await sentinelBoolPrompt(`${spoke}/${asset} paused?`),
          frozen: await sentinelBoolPrompt(`${spoke}/${asset} frozen?`),
          borrowable: await sentinelBoolPrompt(`${spoke}/${asset} borrowable?`),
          receiveSharesEnabled: await sentinelBoolPrompt(`${spoke}/${asset} receiveSharesEnabled?`),
        });
      }
    }
    return response;
  },
  build({cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IAaveV4ConfigEngine.ReserveConfigUpdate({
        spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
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
      const spokeKey = shortKey(c.spoke);
      const assetKey = shortKey(c.underlying);
      const asserts: string[] = [];
      if (isLiteral(c.collateralRisk)) {
        asserts.push(
          `assertEq(uint256(cfg.collateralRisk), uint256(${literalValue(c.collateralRisk)}), 'collateralRisk mismatch');`,
        );
      }
      const boolField = (name: 'paused' | 'frozen' | 'borrowable' | 'receiveSharesEnabled') => {
        const s = c[name];
        if (s.kind === 'keepCurrent' && s.sentinel === 'ENABLED') {
          asserts.push(`assertTrue(cfg.${name}, '${name} should be true');`);
        } else if (s.kind === 'keepCurrent' && s.sentinel === 'DISABLED') {
          asserts.push(`assertFalse(cfg.${name}, '${name} should be false');`);
        }
      };
      boolField('paused');
      boolField('frozen');
      boolField('borrowable');
      boolField('receiveSharesEnabled');
      return `function test_spokeReserveConfigUpdate_${spokeKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke spoke = ISpoke(address(${c.spoke}));
        IHub hub = IHub(address(${c.hub}));
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        uint256 reserveId = spoke.getReserveId(address(hub), assetId);
        ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
        ${asserts.join('\n        ')}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          spokeReserveConfigUpdates: {
            returnType: 'IAaveV4ConfigEngine.ReserveConfigUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
