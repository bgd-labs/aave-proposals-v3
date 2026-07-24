import {confirm, input} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4SpokeLiquidationConfigUpdate} from '../../types';
import {percentPrompt} from '../../../prompts/percentPrompt';
import {selectSpoke} from '../hubSpokeSelect';
import {keepCurrent, literal} from '../sentinels';
import {Sentinel} from '../../types';
import {renderBpsSentinel, renderWadSentinel} from '../units';
import {accessorIdentifier, testAddressRef, wrapAddress} from '../testHelpers';

async function sentinelWad(message: string): Promise<Sentinel> {
  const v = await input({
    message: `${message} (empty = keep current)`,
    validate: (x) => x === '' || !isNaN(Number(x)) || 'Enter a decimal number',
  });
  return v ? literal(v) : keepCurrent();
}

async function sentinelPercent(message: string): Promise<Sentinel> {
  const v = await percentPrompt({message: `${message} (empty = keep current)`});
  return v ? literal(v) : keepCurrent();
}

/// Assert a Sentinel-driven liquidation field: literal -> expected value, keepCurrent -> unchanged.
function assertField(field: string, s: Sentinel, rendered: string, cfgVar = 'cfg'): string {
  if (s.kind === 'keepCurrent')
    return `assertEq(uint256(${cfgVar}.${field}), uint256(before.${field}), '${field} unchanged');`;
  return `assertEq(uint256(${cfgVar}.${field}), uint256(${rendered}), '${field} mismatch');`;
}

export const spokeLiquidationConfigUpdate: FeatureModule<V4SpokeLiquidationConfigUpdate[]> = {
  value: FEATURE.V4_SPOKE_LIQUIDATION_CONFIG_UPDATE,
  description: 'Spoke: update liquidation config (targetHF, hfForMaxBonus, bonusFactor)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4SpokeLiquidationConfigUpdate[] = [];
    let more = true;
    while (more) {
      const spoke = await selectSpoke(m);
      response.push({
        spokeLib: spoke.expr,
        spoke: spoke.expr,
        targetHealthFactor: await sentinelWad('targetHealthFactor (health factor, e.g. 1.05)'),
        healthFactorForMaxBonus: await sentinelWad('healthFactorForMaxBonus (health factor)'),
        liquidationBonusFactor: await sentinelPercent('liquidationBonusFactor (%)'),
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const rendered = (c: V4SpokeLiquidationConfigUpdate) => ({
      target: renderWadSentinel(c.targetHealthFactor),
      maxBonus: renderWadSentinel(c.healthFactorForMaxBonus),
      bonusFactor: renderBpsSentinel(c.liquidationBonusFactor),
    });
    const entries = cfg.map((c) => {
      const r = rendered(c);
      return `items[__INDEX__] = IConfigEngine.LiquidationConfigUpdate({
        spokeConfigurator: ${market}.SPOKE_CONFIGURATOR,
        spoke: ${wrapAddress(c.spoke)},
        targetHealthFactor: ${r.target},
        healthFactorForMaxBonus: ${r.maxBonus},
        liquidationBonusFactor: ${r.bonusFactor}
      });`;
    });
    const inputAsserts = cfg.flatMap((c, ix) => {
      const r = rendered(c);
      return [
        `assertEq(items[${ix}].spoke, ${testAddressRef(c.spoke)}, 'spoke');`,
        `assertEq(items[${ix}].targetHealthFactor, ${r.target}, 'targetHealthFactor');`,
        `assertEq(items[${ix}].healthFactorForMaxBonus, ${r.maxBonus}, 'healthFactorForMaxBonus');`,
        `assertEq(items[${ix}].liquidationBonusFactor, ${r.bonusFactor}, 'liquidationBonusFactor');`,
      ];
    });
    const inputTest = `function test_spokeLiquidationConfigUpdatesInput() public view {
        IConfigEngine.LiquidationConfigUpdate[] memory items = proposal.spokeLiquidationConfigUpdates();
        assertEq(items.length, ${cfg.length}, 'length');
        ${inputAsserts.join('\n        ')}
      }`;
    const testFns = cfg.map((c) => {
      const spokeKey = accessorIdentifier(c.spoke);
      const r = rendered(c);
      const asserts = [
        assertField('targetHealthFactor', c.targetHealthFactor, r.target),
        assertField('healthFactorForMaxBonus', c.healthFactorForMaxBonus, r.maxBonus),
        assertField('liquidationBonusFactor', c.liquidationBonusFactor, r.bonusFactor),
      ];
      const needsBefore = [
        c.targetHealthFactor,
        c.healthFactorForMaxBonus,
        c.liquidationBonusFactor,
      ].some((s) => s.kind === 'keepCurrent');
      const beforeDecl = needsBefore
        ? `ISpoke.LiquidationConfig memory before = ISpoke(${testAddressRef(c.spoke)}).getLiquidationConfig();\n        `
        : '';
      return `function test_spokeLiquidationConfigUpdate_${spokeKey}() public {
        ${beforeDecl}GovV3Helpers.executePayload(vm, address(proposal));
        ISpoke.LiquidationConfig memory cfg = ISpoke(${testAddressRef(c.spoke)}).getLiquidationConfig();
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
      test: {fn: [inputTest, ...testFns]},
    };
    return response;
  },
};
