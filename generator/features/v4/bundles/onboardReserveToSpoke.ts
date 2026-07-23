import {select, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {positionManagerKeys, positionManagerLibAccessor} from '../marketBook';
import {selectHub, selectSpoke, SelectedHub} from '../hubSpokeSelect';
import {selectAsset} from '../assetSelect';
import {
  readSpokeReserves,
  isReserveListedOnSpoke,
  readHubAssets,
  isAssetListedOnHub,
} from '../onchain';
import {promptProxyAdminOwner} from '../proxyAdminOwner';
import {spokeReserveListing} from '../spoke/spokeReserveListing';
import {hubAssetListing} from '../hub/hubAssetListing';
import {spokeReserveConfigUpdate} from '../spoke/spokeReserveConfigUpdate';
import {spokeLiquidationConfigUpdate} from '../spoke/spokeLiquidationConfigUpdate';
import {spokePositionManagerUpdate} from '../spoke/spokePositionManagerUpdate';
import {hubSpokeToAssetsAddition} from '../hub/hubSpokeToAssetsAddition';
import {
  V4SpokeReserveListing,
  V4SpokeReserveConfigUpdate,
  V4SpokeLiquidationConfigUpdate,
  V4SpokePositionManagerUpdate,
  V4HubSpokeToAssetsAddition,
  V4HubAssetListing,
} from '../../types';
import {keepCurrent, keepCurrentAddress, literal, enabled, disabled} from '../sentinels';
import {mergeArtifact} from '../bundleHelpers';

type BundleCfg = {
  hubAssetListings: V4HubAssetListing[];
  listings: V4SpokeReserveListing[];
  updates: V4SpokeReserveConfigUpdate[];
  liquidationUpdates: V4SpokeLiquidationConfigUpdate[];
  hubSpokeAdditions: V4HubSpokeToAssetsAddition[];
  pmUpdates: V4SpokePositionManagerUpdate[];
};

async function liquidationPrompt(spokeAcc: string): Promise<V4SpokeLiquidationConfigUpdate> {
  const t = (await numberPrompt({message: 'targetHealthFactor (WAD)'})) || '0';
  const h = (await numberPrompt({message: 'healthFactorForMaxBonus (WAD)'})) || '0';
  const b = (await numberPrompt({message: 'liquidationBonusFactor (bps)'})) || '0';
  return {
    spokeLib: spokeAcc,
    spoke: spokeAcc,
    targetHealthFactor: literal(t.replace(/\B(?=(\d{3})+(?!\d))/g, '_')),
    healthFactorForMaxBonus: literal(h.replace(/\B(?=(\d{3})+(?!\d))/g, '_')),
    liquidationBonusFactor: literal(b.replace(/\B(?=(\d{3})+(?!\d))/g, '_')),
  };
}

async function hubAssetListingPrompt(
  m: MarketIdentifierV4,
  hub: SelectedHub,
  underlying: string,
): Promise<V4HubAssetListing> {
  const feeReceiver = await addressPrompt({
    message: 'Fee receiver (Spoke address)',
    required: true,
  });
  const liquidityFee = (await numberPrompt({message: 'liquidityFee (bps)'})) || '0';
  const irStrategy = await addressPrompt({message: 'IR strategy address', required: true});
  const optimalUsageRatio =
    (await numberPrompt({message: 'optimalUsageRatio (bps, uint16)'})) || '0';
  const baseDrawnRate = (await numberPrompt({message: 'baseDrawnRate (bps, uint32)'})) || '0';
  const rateGrowthBeforeOptimal =
    (await numberPrompt({message: 'rateGrowthBeforeOptimal (bps, uint32)'})) || '0';
  const rateGrowthAfterOptimal =
    (await numberPrompt({message: 'rateGrowthAfterOptimal (bps, uint32)'})) || '0';
  const withTokenization = await confirm({
    message: 'Deploy a TokenizationSpoke for this asset?',
    default: false,
  });
  let tokenization: V4HubAssetListing['tokenization'];
  if (withTokenization) {
    tokenization = {
      addCap: (await numberPrompt({message: 'TokenizationSpoke addCap'})) || '0',
      proxyAdminOwner: await promptProxyAdminOwner(m),
      name: await input({message: 'TokenizationSpoke name'}),
      symbol: await input({message: 'TokenizationSpoke symbol'}),
    };
  }
  return {
    hubLib: hub.expr,
    hub: hub.key,
    underlying,
    feeReceiver: feeReceiver as `0x${string}`,
    liquidityFee,
    irStrategy: irStrategy as `0x${string}`,
    irData: {
      optimalUsageRatio: literal(optimalUsageRatio),
      baseDrawnRate: literal(baseDrawnRate),
      rateGrowthBeforeOptimal: literal(rateGrowthBeforeOptimal),
      rateGrowthAfterOptimal: literal(rateGrowthAfterOptimal),
    },
    tokenization,
  };
}

export const onboardReserveToSpoke: FeatureModule<BundleCfg> = {
  value: FEATURE.V4_USECASE_ONBOARD_RESERVE_TO_SPOKE,
  description:
    'Bundle: onboard a reserve to a Spoke (full flow: hub registration, listing, liquidation, position manager)',
  async cli({market, cache}) {
    const m = market as MarketIdentifierV4;
    const hubAssetListings: V4HubAssetListing[] = [];
    const listings: V4SpokeReserveListing[] = [];
    const updates: V4SpokeReserveConfigUpdate[] = [];
    const liquidationUpdates: V4SpokeLiquidationConfigUpdate[] = [];
    const hubSpokeAdditions: V4HubSpokeToAssetsAddition[] = [];
    const pmUpdates: V4SpokePositionManagerUpdate[] = [];
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const spoke = await selectSpoke(m);
      const asset = await selectAsset(m);
      const underlying = asset.underlying;

      const reserves = await readSpokeReserves(m, spoke.address, cache.blockNumber);
      const existing = isReserveListedOnSpoke(reserves, underlying);

      if (existing) {
        console.log(
          `${asset.label} is already listed on ${spoke.key} (reserveId=${existing.reserveId}). Falling back to config update.`,
        );
        const wantsUpdate = await confirm({
          message: 'Apply a reserve config update?',
          default: true,
        });
        if (wantsUpdate) {
          updates.push({
            spokeLib: spoke.expr,
            spoke: spoke.expr,
            hub: hub.expr,
            underlying: asset.expr,
            priceSource: keepCurrentAddress(),
            collateralRisk: keepCurrent(),
            paused: existing.paused ? disabled() : keepCurrent(),
            frozen: existing.frozen ? disabled() : keepCurrent(),
            borrowable: existing.borrowable ? keepCurrent() : enabled(),
            receiveSharesEnabled: keepCurrent(),
          });
        }
      } else {
        const hubAssets = await readHubAssets(m, hub.address, cache.blockNumber);
        const onHub = isAssetListedOnHub(hubAssets, underlying);
        if (!onHub) {
          console.log(
            `${asset.label} is not registered on hub ${hub.key}. Collecting hub asset listing parameters first.`,
          );
          hubAssetListings.push(await hubAssetListingPrompt(m, hub, asset.expr));
        }
        const registerOnHub = await confirm({
          message: `Register ${asset.label} on hub ${hub.key} for spoke ${spoke.key}?`,
          default: true,
        });
        if (registerOnHub) {
          hubSpokeAdditions.push({
            hubLib: hub.expr,
            hub: hub.key,
            spoke: spoke.expr,
            assets: [
              {
                underlying: asset.expr,
                addCap:
                  (await numberPrompt({message: `${asset.label} addCap (uint40, whole units)`})) ||
                  '0',
                drawCap:
                  (await numberPrompt({message: `${asset.label} drawCap (uint40, whole units)`})) ||
                  '0',
                riskPremiumThreshold:
                  (await numberPrompt({message: `${asset.label} riskPremiumThreshold (bps)`})) ||
                  '0',
                active: await confirm({message: `${asset.label} active?`, default: true}),
                halted: await confirm({message: `${asset.label} halted?`, default: false}),
              },
            ],
          });
        }
        const priceSource = await addressPrompt({message: 'Price source', required: true});
        listings.push({
          spokeLib: spoke.expr,
          spoke: spoke.expr,
          hub: hub.expr,
          underlying: asset.expr,
          priceSource: priceSource as `0x${string}`,
          config: {
            collateralRisk: (await numberPrompt({message: 'collateralRisk (bps)'})) || '0',
            paused: await confirm({message: 'paused?', default: false}),
            frozen: await confirm({message: 'frozen?', default: false}),
            borrowable: await confirm({message: 'borrowable?', default: true}),
            receiveSharesEnabled: await confirm({message: 'receiveSharesEnabled?', default: true}),
          },
          dynamicConfig: {
            collateralFactor: (await numberPrompt({message: 'collateralFactor (bps)'})) || '0',
            maxLiquidationBonus:
              (await numberPrompt({message: 'maxLiquidationBonus (bps)'})) || '0',
            liquidationFee: (await numberPrompt({message: 'liquidationFee (bps)'})) || '0',
          },
        });
        const wantsLiquidation = await confirm({
          message:
            'Configure liquidation thresholds for this spoke now? (recommended on first listing)',
          default: true,
        });
        if (wantsLiquidation) {
          liquidationUpdates.push(await liquidationPrompt(spoke.expr));
        }
      }

      const wantsPm = await confirm({
        message: 'Enable a PositionManager on this spoke?',
        default: false,
      });
      if (wantsPm) {
        const pm = await select({
          message: 'Select PositionManager',
          choices: positionManagerKeys(m).map((k) => ({name: k, value: k})),
        });
        const active = await confirm({message: 'Active?', default: true});
        pmUpdates.push({
          spokeLib: spoke.expr,
          spoke: spoke.expr,
          positionManager: positionManagerLibAccessor(m, pm) as `0x${string}`,
          active,
        });
      }

      more = await confirm({message: 'Onboard another reserve?', default: false});
    }
    return {hubAssetListings, listings, updates, liquidationUpdates, hubSpokeAdditions, pmUpdates};
  },
  build({options, market, cache, cfg, configs}) {
    const artifact: CodeArtifact = {code: {}};
    const hubAssetListings = cfg.hubAssetListings ?? [];
    const listings = cfg.listings ?? [];
    const updates = cfg.updates ?? [];
    const liquidationUpdates = cfg.liquidationUpdates ?? [];
    const hubSpokeAdditions = cfg.hubSpokeAdditions ?? [];
    const pmUpdates = cfg.pmUpdates ?? [];
    if (hubAssetListings.length > 0) {
      mergeArtifact(
        artifact,
        hubAssetListing.build({options, market, cache, cfg: hubAssetListings, configs}),
      );
    }
    if (listings.length > 0) {
      mergeArtifact(
        artifact,
        spokeReserveListing.build({options, market, cache, cfg: listings, configs}),
      );
    }
    if (updates.length > 0) {
      mergeArtifact(
        artifact,
        spokeReserveConfigUpdate.build({options, market, cache, cfg: updates, configs}),
      );
    }
    if (liquidationUpdates.length > 0) {
      mergeArtifact(
        artifact,
        spokeLiquidationConfigUpdate.build({
          options,
          market,
          cache,
          cfg: liquidationUpdates,
          configs,
        }),
      );
    }
    if (hubSpokeAdditions.length > 0) {
      mergeArtifact(
        artifact,
        hubSpokeToAssetsAddition.build({
          options,
          market,
          cache,
          cfg: hubSpokeAdditions,
          configs,
        }),
      );
    }
    if (pmUpdates.length > 0) {
      mergeArtifact(
        artifact,
        spokePositionManagerUpdate.build({
          options,
          market,
          cache,
          cfg: pmUpdates,
          configs,
        }),
      );
    }
    return artifact;
  },
};
