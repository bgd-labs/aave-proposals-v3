import {select, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeDynamicReserveConfigUpdate} from '../../types';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub, selectSpoke} from '../hubSpokeSelect';
import {renderBpsSentinel} from '../units';
import {sentinelPercent} from '../sentinelPrompts';
import {
  accessorIdentifier,
  assertBpsSentinelField,
  shortKey,
  checksumAddress,
  wrapAddress,
} from '../testHelpers';

export const spokeDynamicReserveConfigUpdate: FeatureModule<V4SpokeDynamicReserveConfigUpdate[]> = {
  value: FEATURE.V4_SPOKE_DYNAMIC_RESERVE_CONFIG_UPDATE,
  description: 'Spoke: update a dynamic reserve config',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokeDynamicReserveConfigUpdate[] = [];
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const spoke = await selectSpoke(m);
      const asset = await select({
        message: 'Select asset',
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
      });
      const dynamicConfigKey = await input({message: 'Dynamic config key (uint32)'});
      response.push({
        spokeLib: spoke.expr,
        spoke: spoke.expr,
        hub: hub.expr,
        underlying: assetLibAccessor(m, asset),
        dynamicConfigKey,
        collateralFactor: await sentinelPercent('collateralFactor (%)'),
        maxLiquidationBonus: await sentinelPercent('maxLiquidationBonus (%, full value e.g. 104)'),
        liquidationFee: await sentinelPercent('liquidationFee (%)'),
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.DynamicReserveConfigUpdate({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: ${wrapAddress(c.spoke)},
        hub: ${wrapAddress(c.hub)},
        underlying: ${checksumAddress(c.underlying)},
        dynamicConfigKey: ${c.dynamicConfigKey},
        collateralFactor: ${renderBpsSentinel(c.collateralFactor)},
        maxLiquidationBonus: ${renderBpsSentinel(c.maxLiquidationBonus)},
        liquidationFee: ${renderBpsSentinel(c.liquidationFee)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const spokeKey = accessorIdentifier(c.spoke);
      const assetKey = shortKey(c.underlying);
      const asserts = [
        assertBpsSentinelField('collateralFactor', c.collateralFactor, 'dyn', 'beforeDyn'),
        assertBpsSentinelField('maxLiquidationBonus', c.maxLiquidationBonus, 'dyn', 'beforeDyn'),
        assertBpsSentinelField('liquidationFee', c.liquidationFee, 'dyn', 'beforeDyn'),
      ];
      return `function test_spokeDynamicReserveConfigUpdate_${spokeKey}_${assetKey}_${c.dynamicConfigKey}() public {
        ISpoke spoke = ISpoke(${wrapAddress(c.spoke)});
        IHub hub = IHub(${wrapAddress(c.hub)});
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
