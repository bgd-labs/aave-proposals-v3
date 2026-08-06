import {select, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetConfigUpdate} from '../../types';
import {percentPrompt} from '../../../prompts/percentPrompt';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub} from '../hubSpokeSelect';
import {keepCurrentUint16, keepCurrentUint32, literal, renderSentinel} from '../sentinels';
import {percentToBps, renderBpsSentinel} from '../units';
import {sentinelPercent, sentinelAddress} from '../sentinelPrompts';
import {Sentinel} from '../../types';
import {
  accessorIdentifier,
  assertBpsSentinelField,
  assertSentinelField,
  shortKey,
  checksumAddress,
  wrapAddress,
} from '../testHelpers';

/// Render a BPS-valued irData sentinel with its uint cast, keeping the type-specific
/// keep-current sentinel when unset.
function renderCastBps(s: Sentinel, cast: 'uint16' | 'uint32'): string {
  if (s.kind === 'literal') return `${cast}(${percentToBps(String(s.value))})`;
  return renderSentinel(s);
}

async function sentinelPercentUint16(message: string): Promise<Sentinel> {
  const v = await percentPrompt({message: `${message} (empty = keep current)`});
  return v ? literal(v) : keepCurrentUint16();
}

async function sentinelPercentUint32(message: string): Promise<Sentinel> {
  const v = await percentPrompt({message: `${message} (empty = keep current)`});
  return v ? literal(v) : keepCurrentUint32();
}

export const hubAssetConfigUpdate: FeatureModule<V4HubAssetConfigUpdate[]> = {
  value: FEATURE.V4_HUB_ASSET_CONFIG_UPDATE,
  description: 'Hub: update asset config (fee, IR strategy/data, reinvestment controller)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const response: V4HubAssetConfigUpdate[] = [];
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const asset = await select({
        message: 'Select asset',
        choices: assetKeys(m).map((k) => ({name: k, value: k})),
      });
      response.push({
        hubLib: hub.expr,
        hub: hub.key,
        underlying: assetLibAccessor(m, asset),
        liquidityFee: await sentinelPercent('liquidityFee (%)'),
        feeReceiver: await sentinelAddress('feeReceiver'),
        irStrategy: await sentinelAddress('irStrategy'),
        irData: {
          optimalUsageRatio: await sentinelPercentUint16('optimalUsageRatio (%)'),
          baseDrawnRate: await sentinelPercentUint32('baseDrawnRate (%)'),
          rateGrowthBeforeOptimal: await sentinelPercentUint32('rateGrowthBeforeOptimal (%)'),
          rateGrowthAfterOptimal: await sentinelPercentUint32('rateGrowthAfterOptimal (%)'),
        },
        reinvestmentController: await sentinelAddress('reinvestmentController'),
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const entries = cfg.map(
      (c) => `items[__INDEX__] = IConfigEngine.AssetConfigUpdate({
        hubConfigurator: ${market}.HUB_CONFIGURATOR,
        hub: ${wrapAddress(c.hubLib)},
        underlying: ${checksumAddress(c.underlying)},
        liquidityFee: ${renderBpsSentinel(c.liquidityFee)},
        feeReceiver: ${renderSentinel(c.feeReceiver)},
        irStrategy: ${renderSentinel(c.irStrategy)},
        irData: IAssetInterestRateStrategy.InterestRateData({
          optimalUsageRatio: ${renderCastBps(c.irData.optimalUsageRatio, 'uint16')},
          baseDrawnRate: ${renderCastBps(c.irData.baseDrawnRate, 'uint32')},
          rateGrowthBeforeOptimal: ${renderCastBps(c.irData.rateGrowthBeforeOptimal, 'uint32')},
          rateGrowthAfterOptimal: ${renderCastBps(c.irData.rateGrowthAfterOptimal, 'uint32')}
        }),
        reinvestmentController: ${renderSentinel(c.reinvestmentController)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = accessorIdentifier(c.hubLib);
      const assetKey = shortKey(c.underlying);
      const asserts = [
        assertBpsSentinelField('liquidityFee', c.liquidityFee),
        assertSentinelField('feeReceiver', c.feeReceiver, 'address'),
        assertSentinelField('irStrategy', c.irStrategy, 'address'),
        assertSentinelField('reinvestmentController', c.reinvestmentController, 'address'),
      ];
      return `function test_hubAssetConfigUpdate_${hubKey}_${assetKey}() public {
        IHub hub = IHub(${wrapAddress(c.hubLib)});
        uint256 assetId = hub.getAssetId(${checksumAddress(c.underlying)});
        IHub.AssetConfig memory before = hub.getAssetConfig(assetId);
        GovV3Helpers.executePayload(vm, address(proposal));
        IHub.AssetConfig memory cfg = hub.getAssetConfig(assetId);
        ${asserts.join('\n        ')}
      }`;
    });
    const response: CodeArtifact = {
      code: {
        v4Getters: {
          hubAssetConfigUpdates: {
            returnType: 'IConfigEngine.AssetConfigUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
