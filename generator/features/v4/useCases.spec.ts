import {expect, describe, it} from 'vitest';
import {generateFiles} from '../../generator';
import {FEATURE, MarketConfigs, Options} from '../../types';
import {onboardAssetToHub} from './bundles/onboardAssetToHub';
import {onboardReserveToSpoke} from './bundles/onboardReserveToSpoke';
import {tuneSpokeRisk} from './bundles/tuneSpokeRisk';
import {tuneReserveRisk} from './bundles/tuneReserveRisk';
import {wirePositionManager} from './bundles/wirePositionManager';
import {manageRole} from './bundles/manageRole';
import {
  literal,
  keepCurrent,
  keepCurrentAddress,
  keepCurrentUint32,
  keepCurrentUint64,
  enabled,
} from './sentinels';

const HUB = 'AaveV4EthereumHubs.CORE_HUB';
const SPOKE = 'AaveV4EthereumSpokes.MAIN_SPOKE';
const ASSET = 'AaveV4EthereumAssets.WETH_UNDERLYING';
const RESERVE_ASSET = 'AaveV4EthereumAssets.USDC_UNDERLYING';
const PM = '0x1111111111111111111111111111111111111111';
const ADDR = '0x2222222222222222222222222222222222222222';

const OPTS: Options = {
  markets: ['AaveV4Ethereum'],
  title: 'V4 every use-case',
  shortName: 'V4EveryUseCase',
  date: '20260521',
  author: 'test',
  discussion: 'test',
  snapshot: 'test',
};

describe('feature: v4 use-cases smoke test', () => {
  it('builds a payload exercising every use-case bundle', async () => {
    const ctx = {
      options: OPTS,
      market: 'AaveV4Ethereum' as const,
      cache: {blockNumber: 42},
      configs: {},
    };

    const onboardAssetCfg = {
      listings: [
        {
          hubLib: HUB,
          hub: HUB,
          underlying: ASSET,
          feeReceiver: ADDR as `0x${string}`,
          liquidityFee: '100',
          irStrategy: ADDR as `0x${string}`,
          irData: {
            optimalUsageRatio: literal('8000'),
            baseDrawnRate: literal('0'),
            rateGrowthBeforeOptimal: literal('400'),
            rateGrowthAfterOptimal: literal('6000'),
          },
          tokenization: undefined,
        },
      ],
      spokeAdditions: [
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
      ],
    };

    const onboardReserveCfg = {
      hubAssetListings: [
        {
          hubLib: HUB,
          hub: HUB,
          underlying: RESERVE_ASSET,
          feeReceiver: ADDR as `0x${string}`,
          liquidityFee: '100',
          irStrategy: ADDR as `0x${string}`,
          irData: {
            optimalUsageRatio: literal('8000'),
            baseDrawnRate: literal('0'),
            rateGrowthBeforeOptimal: literal('400'),
            rateGrowthAfterOptimal: literal('6000'),
          },
          tokenization: undefined,
        },
      ],
      listings: [
        {
          spokeLib: SPOKE,
          spoke: SPOKE,
          hub: HUB,
          underlying: RESERVE_ASSET,
          priceSource: ADDR as `0x${string}`,
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
      ],
      updates: [],
      liquidationUpdates: [],
      hubSpokeAdditions: [
        {
          hubLib: HUB,
          hub: HUB,
          spoke: SPOKE,
          assets: [
            {
              underlying: RESERVE_ASSET,
              addCap: '1000',
              drawCap: '500',
              riskPremiumThreshold: '100',
              active: true,
              halted: false,
            },
          ],
        },
      ],
      pmUpdates: [],
    };

    const tuneSpokeCfg = [
      {
        hubLib: HUB,
        hub: HUB,
        underlying: ASSET,
        spoke: SPOKE,
        addCap: literal('1_000_000'),
        drawCap: keepCurrent(),
        riskPremiumThreshold: keepCurrent(),
        active: enabled(),
        halted: keepCurrent(),
      },
    ];

    const tuneReserveCfg = {
      reserveUpdates: [
        {
          spokeLib: SPOKE,
          spoke: SPOKE,
          hub: HUB,
          underlying: ASSET,
          priceSource: keepCurrentAddress(),
          collateralRisk: literal('7000'),
          paused: keepCurrent(),
          frozen: keepCurrent(),
          borrowable: keepCurrent(),
          receiveSharesEnabled: keepCurrent(),
        },
      ],
      liquidationUpdates: [
        {
          spokeLib: SPOKE,
          spoke: SPOKE,
          targetHealthFactor: literal('1_500_000_000_000_000_000'),
          healthFactorForMaxBonus: keepCurrent(),
          liquidationBonusFactor: literal('500'),
        },
      ],
      dynamicUpdates: [
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
      ],
    };

    const wirePmCfg = {
      targetFunctionRoles: [{target: PM as `0x${string}`, selectors: ['0x12345678'], roleId: '1'}],
      spokeActivations: [
        {spokeLib: SPOKE, spoke: SPOKE, positionManager: PM as `0x${string}`, active: true},
      ],
      pmRegistrations: [{positionManager: PM as `0x${string}`, spoke: SPOKE, registered: true}],
    };

    const manageRoleCfg = {
      memberships: [
        {
          roleId: '1',
          account: ADDR as `0x${string}`,
          granted: true,
          executionDelay: '0',
        },
      ],
      updates: [
        {
          roleId: '1',
          admin: keepCurrentUint64(),
          guardian: literal('2'),
          grantDelay: keepCurrentUint32(),
          label: 'admin',
          labelUpdate: false,
        },
      ],
    };

    const artifacts = [
      onboardAssetToHub.build({...ctx, cfg: onboardAssetCfg}),
      onboardReserveToSpoke.build({...ctx, cfg: onboardReserveCfg}),
      tuneSpokeRisk.build({...ctx, cfg: tuneSpokeCfg}),
      tuneReserveRisk.build({...ctx, cfg: tuneReserveCfg}),
      wirePositionManager.build({...ctx, cfg: wirePmCfg}),
      manageRole.build({...ctx, cfg: manageRoleCfg}),
    ];

    const marketConfigs: MarketConfigs = {
      ['AaveV4Ethereum']: {
        artifacts,
        configs: {
          [FEATURE.V4_USECASE_ONBOARD_ASSET_TO_HUB]: onboardAssetCfg,
          [FEATURE.V4_USECASE_ONBOARD_RESERVE_TO_SPOKE]: onboardReserveCfg,
          [FEATURE.V4_USECASE_TUNE_SPOKE_RISK]: tuneSpokeCfg,
          [FEATURE.V4_USECASE_TUNE_RESERVE_RISK]: tuneReserveCfg,
          [FEATURE.V4_USECASE_WIRE_POSITION_MANAGER]: wirePmCfg,
          [FEATURE.V4_USECASE_MANAGE_ROLE]: manageRoleCfg,
        },
        cache: {blockNumber: 42},
      },
    };

    const files = await generateFiles(OPTS, marketConfigs);
    expect(files).toMatchSnapshot();
  });
});
