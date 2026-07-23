import {select, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {V4HubAssetConfigUpdate} from '../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {assetKeys, assetLibAccessor} from '../marketBook';
import {selectHub} from '../hubSpokeSelect';
import {
  keepCurrent,
  keepCurrentAddress,
  keepCurrentUint16,
  keepCurrentUint32,
  literal,
  renderSentinel,
} from '../sentinels';
import {Sentinel} from '../../types';
import {accessorIdentifier, assertSentinelField, shortKey, checksumAddress} from '../testHelpers';

async function sentinelNumber(message: string): Promise<Sentinel> {
  const v = await numberPrompt({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrent();
  return literal(v.replace(/\B(?=(\d{3})+(?!\d))/g, '_'));
}

async function sentinelAddress(message: string): Promise<Sentinel> {
  const v = await addressPrompt({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrentAddress();
  return literal(v);
}

async function sentinelUint16(message: string): Promise<Sentinel> {
  const v = await numberPrompt({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrentUint16();
  return literal(`uint16(${v})`);
}

async function sentinelUint32(message: string): Promise<Sentinel> {
  const v = await numberPrompt({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrentUint32();
  return literal(`uint32(${v})`);
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
        liquidityFee: await sentinelNumber('liquidityFee (bps)'),
        feeReceiver: await sentinelAddress('feeReceiver'),
        irStrategy: await sentinelAddress('irStrategy'),
        irData: {
          optimalUsageRatio: await sentinelUint16('optimalUsageRatio (bps)'),
          baseDrawnRate: await sentinelUint32('baseDrawnRate (bps)'),
          rateGrowthBeforeOptimal: await sentinelUint32('rateGrowthBeforeOptimal (bps)'),
          rateGrowthAfterOptimal: await sentinelUint32('rateGrowthAfterOptimal (bps)'),
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
        hub: address(${c.hubLib}),
        underlying: ${checksumAddress(c.underlying)},
        liquidityFee: ${renderSentinel(c.liquidityFee)},
        feeReceiver: ${renderSentinel(c.feeReceiver)},
        irStrategy: ${renderSentinel(c.irStrategy)},
        irData: IAssetInterestRateStrategy.InterestRateData({
          optimalUsageRatio: ${renderSentinel(c.irData.optimalUsageRatio)},
          baseDrawnRate: ${renderSentinel(c.irData.baseDrawnRate)},
          rateGrowthBeforeOptimal: ${renderSentinel(c.irData.rateGrowthBeforeOptimal)},
          rateGrowthAfterOptimal: ${renderSentinel(c.irData.rateGrowthAfterOptimal)}
        }),
        reinvestmentController: ${renderSentinel(c.reinvestmentController)}
      });`,
    );
    const testFns = cfg.map((c) => {
      const hubKey = accessorIdentifier(c.hubLib);
      const assetKey = shortKey(c.underlying);
      const asserts = [
        assertSentinelField('liquidityFee', c.liquidityFee, 'uint'),
        assertSentinelField('feeReceiver', c.feeReceiver, 'address'),
        assertSentinelField('irStrategy', c.irStrategy, 'address'),
        assertSentinelField('reinvestmentController', c.reinvestmentController, 'address'),
      ];
      return `function test_hubAssetConfigUpdate_${hubKey}_${assetKey}() public {
        IHub hub = IHub(address(${c.hubLib}));
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
