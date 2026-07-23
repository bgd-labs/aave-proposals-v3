import {select, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeDynamicReserveConfigAddition} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub, selectSpoke} from '../hubSpokeSelect';
import {accessorIdentifier, shortKey, checksumAddress} from '../testHelpers';

export const spokeDynamicReserveConfigAddition: FeatureModule<
  V4SpokeDynamicReserveConfigAddition[]
> = {
  value: FEATURE.V4_SPOKE_DYNAMIC_RESERVE_CONFIG_ADDITION,
  description: 'Spoke: add a dynamic reserve config',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokeDynamicReserveConfigAddition[] = [];
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const spoke = await selectSpoke(m);
      const asset = await select({
        message: 'Select asset',
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
      });
      response.push({
        spokeLib: spoke.expr,
        spoke: spoke.expr,
        hub: hub.expr,
        underlying: assetLibAccessor(m, asset),
        dynamicConfig: {
          collateralFactor:
            (await numberPrompt({message: 'collateralFactor (bps, uint16)'})) || '0',
          maxLiquidationBonus:
            (await numberPrompt({message: 'maxLiquidationBonus (bps, uint32)'})) || '0',
          liquidationFee: (await numberPrompt({message: 'liquidationFee (bps, uint16)'})) || '0',
        },
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.DynamicReserveConfigAddition({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: address(${c.spoke}),
        hub: address(${c.hub}),
        underlying: ${checksumAddress(c.underlying)},
        dynamicConfig: ISpoke.DynamicReserveConfig({
          collateralFactor: ${c.dynamicConfig.collateralFactor},
          maxLiquidationBonus: ${c.dynamicConfig.maxLiquidationBonus},
          liquidationFee: ${c.dynamicConfig.liquidationFee}
        })
      });`,
    );
    const testFns = cfg.map((c) => {
      const spokeKey = accessorIdentifier(c.spoke);
      const assetKey = shortKey(c.underlying);
      return `function test_spokeDynamicReserveConfigAddition_${spokeKey}_${assetKey}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke spoke = ISpoke(address(${c.spoke}));
        IHub hub = IHub(address(${c.hub}));
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        uint256 reserveId = spoke.getReserveId(address(hub), assetId);
        ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
        ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(reserveId, reserve.dynamicConfigKey);
        assertEq(uint256(dyn.collateralFactor), uint256(${c.dynamicConfig.collateralFactor}), 'collateralFactor mismatch');
        assertEq(uint256(dyn.maxLiquidationBonus), uint256(${c.dynamicConfig.maxLiquidationBonus}), 'maxLiquidationBonus mismatch');
        assertEq(uint256(dyn.liquidationFee), uint256(${c.dynamicConfig.liquidationFee}), 'liquidationFee mismatch');
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          spokeDynamicReserveConfigAdditions: {
            returnType: 'IConfigEngine.DynamicReserveConfigAddition',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
