import {select, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeDynamicReserveConfigUpdate} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {
  hubKeys,
  spokeKeys,
  assetKeys,
  hubLibAccessor,
  spokeLibAccessor,
  assetLibAccessor,
} from '../marketBook';
import {keepCurrent, literal, renderSentinel} from '../sentinels';
import {Sentinel} from '../../types';
import {assertSentinelField, shortKey, checksumAddress} from '../testHelpers';

async function sentinelNumber(message: string): Promise<Sentinel> {
  const v = await numberPrompt({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrent();
  return literal(v.replace(/\B(?=(\d{3})+(?!\d))/g, '_'));
}

export const spokeDynamicReserveConfigUpdate: FeatureModule<V4SpokeDynamicReserveConfigUpdate[]> = {
  value: FEATURE.V4_SPOKE_DYNAMIC_RESERVE_CONFIG_UPDATE,
  description: 'Spoke: update a dynamic reserve config',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokeDynamicReserveConfigUpdate[] = [];
    let more = true;
    while (more) {
      const hub = await select({
        message: 'Select hub',
        choices: hubKeys(m).map((k) => ({name: k, value: k})),
      });
      const spoke = await select({
        message: 'Select spoke',
        choices: spokeKeys(m).map((k) => ({name: k, value: k})),
      });
      const asset = await select({
        message: 'Select asset',
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
      });
      const dynamicConfigKey = await input({message: 'Dynamic config key (uint32)'});
      response.push({
        spokeLib: spokeLibAccessor(m, spoke),
        spoke: spokeLibAccessor(m, spoke),
        hub: hubLibAccessor(m, hub),
        underlying: assetLibAccessor(m, asset),
        dynamicConfigKey,
        collateralFactor: await sentinelNumber('collateralFactor (bps)'),
        maxLiquidationBonus: await sentinelNumber('maxLiquidationBonus (bps)'),
        liquidationFee: await sentinelNumber('liquidationFee (bps)'),
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.DynamicReserveConfigUpdate({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: address(${c.spoke}),
        hub: address(${c.hub}),
        underlying: ${checksumAddress(c.underlying)},
        dynamicConfigKey: ${c.dynamicConfigKey},
        collateralFactor: ${renderSentinel(c.collateralFactor)},
        maxLiquidationBonus: ${renderSentinel(c.maxLiquidationBonus)},
        liquidationFee: ${renderSentinel(c.liquidationFee)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const spokeKey = shortKey(c.spoke);
      const assetKey = shortKey(c.underlying);
      const asserts = [
        assertSentinelField('collateralFactor', c.collateralFactor, 'uint', 'dyn', 'beforeDyn'),
        assertSentinelField(
          'maxLiquidationBonus',
          c.maxLiquidationBonus,
          'uint',
          'dyn',
          'beforeDyn',
        ),
        assertSentinelField('liquidationFee', c.liquidationFee, 'uint', 'dyn', 'beforeDyn'),
      ];
      return `function test_spokeDynamicReserveConfigUpdate_${spokeKey}_${assetKey}_${c.dynamicConfigKey}() public {
        ISpoke spoke = ISpoke(address(${c.spoke}));
        IHub hub = IHub(address(${c.hub}));
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        uint256 reserveId = spoke.getReserveId(address(hub), assetId);
        ISpoke.DynamicReserveConfig memory beforeDyn = spoke.getDynamicReserveConfig(reserveId, uint32(${c.dynamicConfigKey}));
        GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(reserveId, uint32(${c.dynamicConfigKey}));
        ${asserts.join('\n        ')}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          spokeDynamicReserveConfigUpdates: {
            returnType: 'IConfigEngine.DynamicReserveConfigUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
