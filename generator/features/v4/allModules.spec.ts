import {expect, describe, it} from 'vitest';
import {generateFiles} from '../../generator';
import {FEATURE, MarketConfigs, Options} from '../../types';
import {hubAssetListing} from './hub/hubAssetListing';
import {hubAssetConfigUpdate} from './hub/hubAssetConfigUpdate';
import {hubSpokeToAssetsAddition} from './hub/hubSpokeToAssetsAddition';
import {hubSpokeConfigUpdate} from './hub/hubSpokeConfigUpdate';
import {hubAssetHalt} from './hub/hubAssetHalt';
import {hubAssetDeactivation} from './hub/hubAssetDeactivation';
import {hubAssetCapsReset} from './hub/hubAssetCapsReset';
import {hubSpokeDeactivation} from './hub/hubSpokeDeactivation';
import {hubSpokeCapsReset} from './hub/hubSpokeCapsReset';
import {spokeReserveListing} from './spoke/spokeReserveListing';
import {spokeReserveConfigUpdate} from './spoke/spokeReserveConfigUpdate';
import {spokeLiquidationConfigUpdate} from './spoke/spokeLiquidationConfigUpdate';
import {spokeDynamicReserveConfigAddition} from './spoke/spokeDynamicReserveConfigAddition';
import {spokeDynamicReserveConfigUpdate} from './spoke/spokeDynamicReserveConfigUpdate';
import {spokePositionManagerUpdate} from './spoke/spokePositionManagerUpdate';
import {accessManagerRoleMembership} from './access/accessManagerRoleMembership';
import {accessManagerRoleUpdate} from './access/accessManagerRoleUpdate';
import {accessManagerTargetFunctionRoleUpdate} from './access/accessManagerTargetFunctionRoleUpdate';
import {accessManagerTargetAdminDelayUpdate} from './access/accessManagerTargetAdminDelayUpdate';
import {positionManagerSpokeRegistration} from './positionManager/positionManagerSpokeRegistration';
import {positionManagerRoleRenouncement} from './positionManager/positionManagerRoleRenouncement';
import {
  literal,
  keepCurrent,
  keepCurrentAddress,
  keepCurrentUint16,
  keepCurrentUint32,
  keepCurrentUint64,
  enabled,
  disabled,
} from './sentinels';
import {
  V4HubAssetListing,
  V4HubAssetConfigUpdate,
  V4HubSpokeToAssetsAddition,
  V4HubSpokeConfigUpdate,
  V4HubAssetHalt,
  V4HubAssetDeactivation,
  V4HubAssetCapsReset,
  V4HubSpokeDeactivation,
  V4HubSpokeCapsReset,
  V4SpokeReserveListing,
  V4SpokeReserveConfigUpdate,
  V4SpokeLiquidationConfigUpdate,
  V4SpokeDynamicReserveConfigAddition,
  V4SpokeDynamicReserveConfigUpdate,
  V4SpokePositionManagerUpdate,
  V4RoleMembership,
  V4RoleUpdate,
  V4TargetFunctionRoleUpdate,
  V4TargetAdminDelayUpdate,
  V4PMSpokeRegistration,
  V4PMRoleRenouncement,
} from '../types';

const HUB = 'AaveV4EthereumHubs.CORE_HUB';
const SPOKE = 'AaveV4EthereumSpokes.MAIN_SPOKE';
const ASSET = 'AaveV4EthereumAssets.WETH_UNDERLYING';
const PM = '0x1111111111111111111111111111111111111111';
const ADDR = '0x2222222222222222222222222222222222222222';

const OPTS: Options = {
  markets: ['AaveV4Ethereum'],
  title: 'V4 every action',
  shortName: 'V4Every',
  date: '20260521',
  author: 'test',
  discussion: 'test',
  snapshot: 'test',
};

const hubAssetListingCfg: V4HubAssetListing[] = [
  {
    hubLib: HUB,
    hub: HUB,
    underlying: ASSET,
    feeReceiver: ADDR,
    liquidityFee: '100',
    irStrategy: ADDR,
    irData: {
      optimalUsageRatio: literal('8000'),
      baseDrawnRate: literal('0'),
      rateGrowthBeforeOptimal: literal('400'),
      rateGrowthAfterOptimal: literal('6000'),
    },
    tokenization: {
      addCap: '1000',
      proxyAdminOwner: 'GovernanceV3Ethereum.EXECUTOR_LVL_1',
      name: 'TS',
      symbol: 'TS',
    },
  },
];

const hubAssetConfigUpdateCfg: V4HubAssetConfigUpdate[] = [
  {
    hubLib: HUB,
    hub: HUB,
    underlying: ASSET,
    liquidityFee: literal('200'),
    feeReceiver: keepCurrentAddress(),
    irStrategy: keepCurrentAddress(),
    irData: {
      optimalUsageRatio: keepCurrentUint16(),
      baseDrawnRate: keepCurrentUint32(),
      rateGrowthBeforeOptimal: keepCurrentUint32(),
      rateGrowthAfterOptimal: keepCurrentUint32(),
    },
    reinvestmentController: keepCurrentAddress(),
  },
];

const hubSpokeToAssetsAdditionCfg: V4HubSpokeToAssetsAddition[] = [
  {
    hubLib: HUB,
    hub: HUB,
    spoke: SPOKE,
    assets: [
      {
        underlying: ASSET,
        addCap: '1000',
        drawCap: '500',
        riskPremiumThreshold: '100',
        active: true,
        halted: false,
      },
    ],
  },
];

const hubSpokeConfigUpdateCfg: V4HubSpokeConfigUpdate[] = [
  {
    hubLib: HUB,
    hub: HUB,
    underlying: ASSET,
    spoke: SPOKE,
    addCap: literal('1_000_000'),
    drawCap: literal('500_000'),
    riskPremiumThreshold: keepCurrent(),
    active: enabled(),
    halted: disabled(),
  },
];

const trivial = (kind: 'asset' | 'spoke') =>
  kind === 'asset'
    ? [{hubLib: HUB, hub: HUB, underlying: ASSET}]
    : [{hubLib: HUB, hub: HUB, spoke: SPOKE}];

const hubAssetHaltCfg = trivial('asset') as V4HubAssetHalt[];
const hubAssetDeactivationCfg = trivial('asset') as V4HubAssetDeactivation[];
const hubAssetCapsResetCfg = trivial('asset') as V4HubAssetCapsReset[];
const hubSpokeDeactivationCfg = trivial('spoke') as V4HubSpokeDeactivation[];
const hubSpokeCapsResetCfg = trivial('spoke') as V4HubSpokeCapsReset[];

const spokeReserveListingCfg: V4SpokeReserveListing[] = [
  {
    spokeLib: SPOKE,
    spoke: SPOKE,
    hub: HUB,
    underlying: ASSET,
    priceSource: ADDR,
    config: {
      collateralRisk: '0',
      paused: false,
      frozen: false,
      borrowable: true,
      receiveSharesEnabled: true,
    },
    dynamicConfig: {
      collateralFactor: '8000',
      maxLiquidationBonus: '500',
      liquidationFee: '100',
    },
  },
];

const spokeReserveConfigUpdateCfg: V4SpokeReserveConfigUpdate[] = [
  {
    spokeLib: SPOKE,
    spoke: SPOKE,
    hub: HUB,
    underlying: ASSET,
    priceSource: keepCurrentAddress(),
    collateralRisk: keepCurrent(),
    paused: keepCurrent(),
    frozen: disabled(),
    borrowable: enabled(),
    receiveSharesEnabled: keepCurrent(),
  },
];

const spokeLiquidationConfigUpdateCfg: V4SpokeLiquidationConfigUpdate[] = [
  {
    spokeLib: SPOKE,
    spoke: SPOKE,
    targetHealthFactor: literal('1_500_000_000_000_000_000'),
    healthFactorForMaxBonus: keepCurrent(),
    liquidationBonusFactor: literal('500'),
  },
];

const spokeDynamicReserveConfigAdditionCfg: V4SpokeDynamicReserveConfigAddition[] = [
  {
    spokeLib: SPOKE,
    spoke: SPOKE,
    hub: HUB,
    underlying: ASSET,
    dynamicConfig: {collateralFactor: '7500', maxLiquidationBonus: '500', liquidationFee: '100'},
  },
];

const spokeDynamicReserveConfigUpdateCfg: V4SpokeDynamicReserveConfigUpdate[] = [
  {
    spokeLib: SPOKE,
    spoke: SPOKE,
    hub: HUB,
    underlying: ASSET,
    dynamicConfigKey: '1',
    collateralFactor: literal('7700'),
    maxLiquidationBonus: keepCurrent(),
    liquidationFee: keepCurrent(),
  },
];

const spokePositionManagerUpdateCfg: V4SpokePositionManagerUpdate[] = [
  {spokeLib: SPOKE, spoke: SPOKE, positionManager: PM, active: true},
];

const roleMembershipCfg: V4RoleMembership[] = [
  {roleId: '1', account: ADDR, granted: true, executionDelay: '0'},
];

const roleUpdateCfg: V4RoleUpdate[] = [
  {
    roleId: '1',
    admin: keepCurrentUint64(),
    guardian: literal('2'),
    grantDelay: keepCurrentUint32(),
    label: 'admin',
    labelUpdate: false,
  },
];

const targetFunctionRoleUpdateCfg: V4TargetFunctionRoleUpdate[] = [
  {target: ADDR, selectors: ['0x12345678'], roleId: '1'},
];

const targetAdminDelayUpdateCfg: V4TargetAdminDelayUpdate[] = [{target: ADDR, newDelay: '3600'}];

const pmSpokeRegistrationCfg: V4PMSpokeRegistration[] = [
  {positionManager: PM, spoke: SPOKE, registered: true},
];

const pmRoleRenouncementCfg: V4PMRoleRenouncement[] = [
  {positionManager: PM, spoke: SPOKE, user: ADDR},
];

describe('feature: v4 all-modules smoke test', () => {
  it('builds a payload exercising every override', async () => {
    const ctx = {
      options: OPTS,
      market: 'AaveV4Ethereum' as const,
      cache: {blockNumber: 42},
      configs: {},
    };
    const artifacts = [
      hubAssetListing.build({...ctx, cfg: hubAssetListingCfg}),
      hubAssetConfigUpdate.build({...ctx, cfg: hubAssetConfigUpdateCfg}),
      hubSpokeToAssetsAddition.build({...ctx, cfg: hubSpokeToAssetsAdditionCfg}),
      hubSpokeConfigUpdate.build({...ctx, cfg: hubSpokeConfigUpdateCfg}),
      hubAssetHalt.build({...ctx, cfg: hubAssetHaltCfg}),
      hubAssetDeactivation.build({...ctx, cfg: hubAssetDeactivationCfg}),
      hubAssetCapsReset.build({...ctx, cfg: hubAssetCapsResetCfg}),
      hubSpokeDeactivation.build({...ctx, cfg: hubSpokeDeactivationCfg}),
      hubSpokeCapsReset.build({...ctx, cfg: hubSpokeCapsResetCfg}),
      spokeReserveListing.build({...ctx, cfg: spokeReserveListingCfg}),
      spokeReserveConfigUpdate.build({...ctx, cfg: spokeReserveConfigUpdateCfg}),
      spokeLiquidationConfigUpdate.build({...ctx, cfg: spokeLiquidationConfigUpdateCfg}),
      spokeDynamicReserveConfigAddition.build({...ctx, cfg: spokeDynamicReserveConfigAdditionCfg}),
      spokeDynamicReserveConfigUpdate.build({...ctx, cfg: spokeDynamicReserveConfigUpdateCfg}),
      spokePositionManagerUpdate.build({...ctx, cfg: spokePositionManagerUpdateCfg}),
      accessManagerRoleMembership.build({...ctx, cfg: roleMembershipCfg}),
      accessManagerRoleUpdate.build({...ctx, cfg: roleUpdateCfg}),
      accessManagerTargetFunctionRoleUpdate.build({...ctx, cfg: targetFunctionRoleUpdateCfg}),
      accessManagerTargetAdminDelayUpdate.build({...ctx, cfg: targetAdminDelayUpdateCfg}),
      positionManagerSpokeRegistration.build({...ctx, cfg: pmSpokeRegistrationCfg}),
      positionManagerRoleRenouncement.build({...ctx, cfg: pmRoleRenouncementCfg}),
    ];
    const marketConfigs: MarketConfigs = {
      ['AaveV4Ethereum']: {
        artifacts,
        configs: {
          [FEATURE.V4_HUB_ASSET_LISTING]: hubAssetListingCfg,
          [FEATURE.V4_HUB_ASSET_CONFIG_UPDATE]: hubAssetConfigUpdateCfg,
          [FEATURE.V4_HUB_SPOKE_TO_ASSETS_ADDITION]: hubSpokeToAssetsAdditionCfg,
          [FEATURE.V4_HUB_SPOKE_CONFIG_UPDATE]: hubSpokeConfigUpdateCfg,
          [FEATURE.V4_HUB_ASSET_HALT]: hubAssetHaltCfg,
          [FEATURE.V4_HUB_ASSET_DEACTIVATION]: hubAssetDeactivationCfg,
          [FEATURE.V4_HUB_ASSET_CAPS_RESET]: hubAssetCapsResetCfg,
          [FEATURE.V4_HUB_SPOKE_DEACTIVATION]: hubSpokeDeactivationCfg,
          [FEATURE.V4_HUB_SPOKE_CAPS_RESET]: hubSpokeCapsResetCfg,
          [FEATURE.V4_SPOKE_RESERVE_LISTING]: spokeReserveListingCfg,
          [FEATURE.V4_SPOKE_RESERVE_CONFIG_UPDATE]: spokeReserveConfigUpdateCfg,
          [FEATURE.V4_SPOKE_LIQUIDATION_CONFIG_UPDATE]: spokeLiquidationConfigUpdateCfg,
          [FEATURE.V4_SPOKE_DYNAMIC_RESERVE_CONFIG_ADDITION]: spokeDynamicReserveConfigAdditionCfg,
          [FEATURE.V4_SPOKE_DYNAMIC_RESERVE_CONFIG_UPDATE]: spokeDynamicReserveConfigUpdateCfg,
          [FEATURE.V4_SPOKE_POSITION_MANAGER_UPDATE]: spokePositionManagerUpdateCfg,
          [FEATURE.V4_AM_ROLE_MEMBERSHIP]: roleMembershipCfg,
          [FEATURE.V4_AM_ROLE_UPDATE]: roleUpdateCfg,
          [FEATURE.V4_AM_TARGET_FUNCTION_ROLE_UPDATE]: targetFunctionRoleUpdateCfg,
          [FEATURE.V4_AM_TARGET_ADMIN_DELAY_UPDATE]: targetAdminDelayUpdateCfg,
          [FEATURE.V4_PM_SPOKE_REGISTRATION]: pmSpokeRegistrationCfg,
          [FEATURE.V4_PM_ROLE_RENOUNCEMENT]: pmRoleRenouncementCfg,
        },
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(OPTS, marketConfigs);
    expect(files).toMatchSnapshot();
  });
});
