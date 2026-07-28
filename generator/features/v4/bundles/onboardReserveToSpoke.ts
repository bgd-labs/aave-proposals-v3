import {checkbox, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {percentPrompt} from '../../../prompts/percentPrompt';
import {numberPrompt} from '../../../prompts/numberPrompt';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {positionManagerKeys, positionManagerLibAccessor} from '../marketBook';
import {selectHub, selectSpoke} from '../hubSpokeSelect';
import {selectAsset} from '../assetSelect';
import {
  readSpokeReserves,
  isReserveListedOnSpoke,
  readHubAssets,
  isAssetListedOnHub,
} from '../onchain';
import {spokeReserveListing} from '../spoke/spokeReserveListing';
import {hubAssetListing} from '../hub/hubAssetListing';
import {promptHubAssetListing} from '../hub/hubAssetListingPrompt';
import {spokeReserveConfigUpdate} from '../spoke/spokeReserveConfigUpdate';
import {spokeLiquidationConfigUpdate} from '../spoke/spokeLiquidationConfigUpdate';
import {spokePositionManagerUpdate} from '../spoke/spokePositionManagerUpdate';
import {hubSpokeToAssetsAddition} from '../hub/hubSpokeToAssetsAddition';
import {accessManagerTargetFunctionRoleUpdate} from '../access/accessManagerTargetFunctionRoleUpdate';
import {spokeWiring, hubConfiguratorWiring} from '../accessWiring';
import {
  V4SpokeReserveListing,
  V4SpokeReserveConfigUpdate,
  V4SpokeLiquidationConfigUpdate,
  V4SpokePositionManagerUpdate,
  V4HubSpokeToAssetsAddition,
  V4HubAssetListing,
  V4TargetFunctionRoleUpdate,
} from '../../types';
import {keepCurrent, keepCurrentAddress, literal, enabled, disabled} from '../sentinels';
import {mergeArtifact} from '../bundleHelpers';

type BundleCfg = {
  targetFunctionRoles: V4TargetFunctionRoleUpdate[];
  hubAssetListings: V4HubAssetListing[];
  listings: V4SpokeReserveListing[];
  updates: V4SpokeReserveConfigUpdate[];
  liquidationUpdates: V4SpokeLiquidationConfigUpdate[];
  hubSpokeAdditions: V4HubSpokeToAssetsAddition[];
  pmUpdates: V4SpokePositionManagerUpdate[];
};

async function liquidationPrompt(spokeExpr: string): Promise<V4SpokeLiquidationConfigUpdate> {
  const t =
    (await input({
      message: 'targetHealthFactor (health factor, e.g. 1.05)',
      validate: (x) => x === '' || !isNaN(Number(x)) || 'Enter a decimal number',
    })) || '1';
  const h =
    (await input({
      message: 'healthFactorForMaxBonus (health factor)',
      validate: (x) => x === '' || !isNaN(Number(x)) || 'Enter a decimal number',
    })) || '1';
  const b = (await percentPrompt({message: 'liquidationBonusFactor (%)'})) || '0';
  return {
    spokeLib: spokeExpr,
    spoke: spokeExpr,
    targetHealthFactor: literal(t),
    healthFactorForMaxBonus: literal(h),
    liquidationBonusFactor: literal(b),
  };
}

async function spokeReserveConfig(): Promise<V4SpokeReserveListing['config']> {
  const config = {
    collateralRisk: (await percentPrompt({message: 'collateralRisk (%)'})) || '0',
    paused: false,
    frozen: false,
    borrowable: true,
    receiveSharesEnabled: true,
  };
  const customize = await confirm({
    message: 'Customize reserve flags (paused/frozen/borrowable/receiveShares)?',
    default: false,
  });
  if (customize) {
    config.paused = await confirm({message: 'paused?', default: false});
    config.frozen = await confirm({message: 'frozen?', default: false});
    config.borrowable = await confirm({message: 'borrowable?', default: true});
    config.receiveSharesEnabled = await confirm({message: 'receiveSharesEnabled?', default: true});
  }
  return config;
}

async function spokeAssetConfig(
  label: string,
): Promise<V4HubSpokeToAssetsAddition['assets'][number]['config'] & {underlying?: never}> {
  const addCap = (await numberPrompt({message: `${label} addCap (whole units)`})) || '0';
  const drawCap = (await numberPrompt({message: `${label} drawCap (whole units)`})) || '0';
  const riskPremiumThreshold =
    (await percentPrompt({message: `${label} riskPremiumThreshold (%)`})) || '0';
  let active = true;
  let halted = false;
  if (await confirm({message: `${label}: customize active/halted flags?`, default: false})) {
    active = await confirm({message: `${label} active?`, default: true});
    halted = await confirm({message: `${label} halted?`, default: false});
  }
  return {addCap, drawCap, riskPremiumThreshold, active, halted};
}

async function selectPositionManagers(
  m: MarketIdentifierV4,
  spokeExpr: string,
): Promise<V4SpokePositionManagerUpdate[]> {
  const pms = await checkbox({
    message: 'Enable PositionManagers on this spoke (none = skip)',
    choices: positionManagerKeys(m).map((k) => ({name: k, value: k})),
  });
  return pms.map((pm) => ({
    spokeLib: spokeExpr,
    spoke: spokeExpr,
    positionManager: positionManagerLibAccessor(m, pm) as `0x${string}`,
    active: true,
  }));
}

export const onboardReserveToSpoke: FeatureModule<BundleCfg> = {
  value: FEATURE.V4_USECASE_ONBOARD_RESERVE_TO_SPOKE,
  description:
    'Bundle: onboard a reserve to a Spoke (fresh-spoke wiring, hub registration, listing, liquidation, position managers)',
  async cli({market, cache}) {
    const m = market as MarketIdentifierV4;
    const cfg: BundleCfg = {
      targetFunctionRoles: [],
      hubAssetListings: [],
      listings: [],
      updates: [],
      liquidationUpdates: [],
      hubSpokeAdditions: [],
      pmUpdates: [],
    };
    const wiredSpokes = new Set<string>();
    const wiredHubs = new Set<string>();
    let more = true;
    while (more) {
      const hub = await selectHub(m);
      const spoke = await selectSpoke(m);
      const asset = await selectAsset(m);
      const underlying = asset.underlying;

      if (hub.isNew && !wiredHubs.has(hub.expr)) {
        wiredHubs.add(hub.expr);
        if (
          await confirm({
            message: `Wire HubConfigurator role on fresh hub ${hub.key}?`,
            default: true,
          })
        ) {
          cfg.targetFunctionRoles.push(hubConfiguratorWiring(hub.expr));
        }
      }
      if (spoke.isNew && !wiredSpokes.has(spoke.expr)) {
        wiredSpokes.add(spoke.expr);
        if (
          await confirm({
            message: `Wire SpokeConfigurator & user-position-updater roles on fresh spoke ${spoke.key}?`,
            default: true,
          })
        ) {
          cfg.targetFunctionRoles.push(...spokeWiring(m, spoke.expr));
        }
      }

      const existing = spoke.isNew
        ? undefined
        : isReserveListedOnSpoke(
            await readSpokeReserves(m, spoke.address, cache.blockNumber),
            underlying,
          );

      if (existing) {
        console.log(
          `${asset.label} is already listed on ${spoke.key} (reserveId=${existing.reserveId}). Falling back to config update.`,
        );
        if (await confirm({message: 'Apply a reserve config update?', default: true})) {
          cfg.updates.push({
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
        const onHub = hub.isNew
          ? undefined
          : isAssetListedOnHub(await readHubAssets(m, hub.address, cache.blockNumber), underlying);
        if (!onHub) {
          console.log(
            `${asset.label} is not registered on hub ${hub.key}. Collecting hub asset listing parameters first.`,
          );
          cfg.hubAssetListings.push(
            await promptHubAssetListing(m, {
              hubLib: hub.expr,
              hub: hub.key,
              underlying: asset.expr,
            }),
          );
        }
        if (
          await confirm({
            message: `Register ${asset.label} on hub ${hub.key} for spoke ${spoke.key}?`,
            default: true,
          })
        ) {
          cfg.hubSpokeAdditions.push({
            hubLib: hub.expr,
            hub: hub.key,
            spoke: spoke.expr,
            assets: [{underlying: asset.expr, ...(await spokeAssetConfig(asset.label))}],
          });
        }
        const priceSource = await addressPrompt({message: 'Price source', required: true});
        cfg.listings.push({
          spokeLib: spoke.expr,
          spoke: spoke.expr,
          hub: hub.expr,
          underlying: asset.expr,
          priceSource: priceSource as `0x${string}`,
          config: await spokeReserveConfig(),
          dynamicConfig: {
            collateralFactor: (await percentPrompt({message: 'collateralFactor (%)'})) || '0',
            maxLiquidationBonus:
              (await percentPrompt({message: 'maxLiquidationBonus (%, full value e.g. 104)'})) ||
              '0',
            liquidationFee: (await percentPrompt({message: 'liquidationFee (%)'})) || '0',
          },
        });
        if (
          await confirm({
            message:
              'Configure liquidation thresholds for this spoke now? (recommended on first listing)',
            default: true,
          })
        ) {
          cfg.liquidationUpdates.push(await liquidationPrompt(spoke.expr));
        }
      }

      cfg.pmUpdates.push(...(await selectPositionManagers(m, spoke.expr)));

      more = await confirm({message: 'Onboard another reserve?', default: false});
    }
    return cfg;
  },
  build({options, market, cache, cfg, configs}) {
    const artifact: CodeArtifact = {code: {}};
    const delegate = (mod: {build: Function}, sub: unknown[]) => {
      if (sub.length > 0)
        mergeArtifact(artifact, mod.build({options, market, cache, cfg: sub, configs}));
    };
    delegate(accessManagerTargetFunctionRoleUpdate, cfg.targetFunctionRoles ?? []);
    delegate(hubAssetListing, cfg.hubAssetListings ?? []);
    delegate(spokeReserveListing, cfg.listings ?? []);
    delegate(spokeReserveConfigUpdate, cfg.updates ?? []);
    delegate(spokeLiquidationConfigUpdate, cfg.liquidationUpdates ?? []);
    delegate(hubSpokeToAssetsAddition, cfg.hubSpokeAdditions ?? []);
    delegate(spokePositionManagerUpdate, cfg.pmUpdates ?? []);
    return artifact;
  },
};
