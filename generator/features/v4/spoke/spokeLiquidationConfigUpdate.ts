import {select, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeLiquidationConfigUpdate} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {spokeKeys, spokeLibAccessor} from '../marketBook';
import {keepCurrent, literal, renderSentinel} from '../sentinels';
import {Sentinel} from '../../types';
import {assertSentinelField, shortKey} from '../testHelpers';

async function sentinelNumber(message: string): Promise<Sentinel> {
  const v = await numberPrompt({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrent();
  return literal(v.replace(/\B(?=(\d{3})+(?!\d))/g, '_'));
}

export const spokeLiquidationConfigUpdate: FeatureModule<V4SpokeLiquidationConfigUpdate[]> = {
  value: FEATURE.V4_SPOKE_LIQUIDATION_CONFIG_UPDATE,
  description: 'Spoke: update liquidation config (targetHF, hfForMaxBonus, bonusFactor)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokeLiquidationConfigUpdate[] = [];
    let more = true;
    while (more) {
      const spoke = await select({
        message: 'Select spoke',
        choices: spokeKeys(m).map((k) => ({name: k, value: k})),
      });
      response.push({
        spokeLib: spokeLibAccessor(m, spoke),
        spoke: spokeLibAccessor(m, spoke),
        targetHealthFactor: await sentinelNumber('targetHealthFactor (WAD)'),
        healthFactorForMaxBonus: await sentinelNumber('healthFactorForMaxBonus (WAD)'),
        liquidationBonusFactor: await sentinelNumber('liquidationBonusFactor (bps)'),
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.LiquidationConfigUpdate({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: address(${c.spoke}),
        targetHealthFactor: ${renderSentinel(c.targetHealthFactor)},
        healthFactorForMaxBonus: ${renderSentinel(c.healthFactorForMaxBonus)},
        liquidationBonusFactor: ${renderSentinel(c.liquidationBonusFactor)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const spokeKey = shortKey(c.spoke);
      const asserts = [
        assertSentinelField('targetHealthFactor', c.targetHealthFactor, 'uint'),
        assertSentinelField('healthFactorForMaxBonus', c.healthFactorForMaxBonus, 'uint'),
        assertSentinelField('liquidationBonusFactor', c.liquidationBonusFactor, 'uint'),
      ];
      return `function test_spokeLiquidationConfigUpdate_${spokeKey}() public {
        ISpoke.LiquidationConfig memory before = ISpoke(address(${c.spoke})).getLiquidationConfig();
        GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke.LiquidationConfig memory cfg = ISpoke(address(${c.spoke})).getLiquidationConfig();
        ${asserts.join('\n        ')}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          spokeLiquidationConfigUpdates: {
            returnType: 'IConfigEngine.LiquidationConfigUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
