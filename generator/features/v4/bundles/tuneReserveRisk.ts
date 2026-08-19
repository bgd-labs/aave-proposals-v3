import {select, checkbox, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {assetKeys, assetLibAccessor, getV4Book} from '../marketBook';
import {selectHub, selectSpoke} from '../hubSpokeSelect';
import {readSpokeReserves} from '../onchain';
import {spokeReserveConfigUpdate} from '../spoke/spokeReserveConfigUpdate';
import {spokeLiquidationConfigUpdate} from '../spoke/spokeLiquidationConfigUpdate';
import {spokeDynamicReserveConfigUpdate} from '../spoke/spokeDynamicReserveConfigUpdate';
import {
  V4SpokeReserveConfigUpdate,
  V4SpokeLiquidationConfigUpdate,
  V4SpokeDynamicReserveConfigUpdate,
} from '../../types';
import {keepCurrent, keepCurrentAddress, literal, enabled, disabled} from '../sentinels';
import {Sentinel} from '../../types';
import {mergeArtifact} from '../bundleHelpers';

type BundleCfg = {
  reserveUpdates: V4SpokeReserveConfigUpdate[];
  liquidationUpdates: V4SpokeLiquidationConfigUpdate[];
  dynamicUpdates: V4SpokeDynamicReserveConfigUpdate[];
};

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

async function sentinelBool(message: string): Promise<Sentinel> {
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

export const tuneReserveRisk: FeatureModule<BundleCfg> = {
  value: FEATURE.V4_USECASE_TUNE_RESERVE_RISK,
  description:
    'Bundle: tune reserve risk (config + liquidation + dynamic) with on-chain validation',
  async cli({market, cache}) {
    const m = market as MarketIdentifierV4;
    const book = getV4Book(m);
    const result: BundleCfg = {reserveUpdates: [], liquidationUpdates: [], dynamicUpdates: []};
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const spoke = await selectSpoke(m);
      const reserves = await readSpokeReserves(m, spoke.address, cache.blockNumber);
      const candidateAssets = assetKeys(m).filter((k) =>
        reserves.some(
          (r) => r.underlying.toLowerCase() === (book.ASSETS[k].UNDERLYING as string).toLowerCase(),
        ),
      );
      if (candidateAssets.length === 0) {
        console.log(`No listed reserves on ${spoke.key}; skipping.`);
        more = await confirm({message: 'Tune more?', default: false});
        continue;
      }
      const assets = await checkbox({
        message: `Select reserves on ${spoke.key} to tune`,
        choices: candidateAssets.map((k) => ({name: k, value: k})),
        required: true,
      });

      const wantReserveCfg = await confirm({message: 'Update reserve config?', default: true});
      const wantLiquidation = await confirm({
        message: 'Update spoke-wide liquidation config?',
        default: false,
      });
      const wantDynamic = await confirm({
        message: 'Update dynamic reserve config?',
        default: false,
      });

      for (const asset of assets) {
        if (wantReserveCfg) {
          result.reserveUpdates.push({
            spokeLib: spoke.expr,
            spoke: spoke.expr,
            hub: hub.expr,
            underlying: assetLibAccessor(m, asset),
            priceSource: await sentinelAddress(`${asset} priceSource`),
            collateralRisk: await sentinelNumber(`${asset} collateralRisk (bps)`),
            paused: await sentinelBool(`${asset} paused?`),
            frozen: await sentinelBool(`${asset} frozen?`),
            borrowable: await sentinelBool(`${asset} borrowable?`),
            receiveSharesEnabled: await sentinelBool(`${asset} receiveSharesEnabled?`),
          });
        }
        if (wantDynamic) {
          const dynamicConfigKey = await input({
            message: `${asset} dynamicConfigKey (uint32)`,
          });
          result.dynamicUpdates.push({
            spokeLib: spoke.expr,
            spoke: spoke.expr,
            hub: hub.expr,
            underlying: assetLibAccessor(m, asset),
            dynamicConfigKey,
            collateralFactor: await sentinelNumber(`${asset} collateralFactor (bps)`),
            maxLiquidationBonus: await sentinelNumber(`${asset} maxLiquidationBonus (bps)`),
            liquidationFee: await sentinelNumber(`${asset} liquidationFee (bps)`),
          });
        }
      }
      if (wantLiquidation) {
        result.liquidationUpdates.push({
          spokeLib: spoke.expr,
          spoke: spoke.expr,
          targetHealthFactor: await sentinelNumber('targetHealthFactor (WAD)'),
          healthFactorForMaxBonus: await sentinelNumber('healthFactorForMaxBonus (WAD)'),
          liquidationBonusFactor: await sentinelNumber('liquidationBonusFactor (bps)'),
        });
      }
      more = await confirm({message: 'Tune more?', default: false});
    }
    return result;
  },
  build({options, market, cache, cfg, configs}) {
    const artifact: CodeArtifact = {code: {}};
    if (cfg.reserveUpdates.length > 0) {
      mergeArtifact(
        artifact,
        spokeReserveConfigUpdate.build({
          options,
          market,
          cache,
          cfg: cfg.reserveUpdates,
          configs,
        }),
      );
    }
    if (cfg.liquidationUpdates.length > 0) {
      mergeArtifact(
        artifact,
        spokeLiquidationConfigUpdate.build({
          options,
          market,
          cache,
          cfg: cfg.liquidationUpdates,
          configs,
        }),
      );
    }
    if (cfg.dynamicUpdates.length > 0) {
      mergeArtifact(
        artifact,
        spokeDynamicReserveConfigUpdate.build({
          options,
          market,
          cache,
          cfg: cfg.dynamicUpdates,
          configs,
        }),
      );
    }
    return artifact;
  },
};
