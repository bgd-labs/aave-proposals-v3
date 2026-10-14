import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Labs',
    configFile: 'src/20261013_AaveV4Avalanche_OnboardUSDeCoreHub/config.ts',
    force: true,
    markets: ['AaveV4Avalanche'],
    title: 'Onboard USDe to Aave V4 Core Instance on Avalanche',
    shortName: 'OnboardUSDeCoreHub',
    date: '20261013',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-usde-to-aave-v4-core-instance-on-avalanche/25576',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV4Avalanche: {
      configs: {
        V4_USECASE_ONBOARD_RESERVE_TO_SPOKE: {
          freshHubs: [],
          freshSpokes: ['ETHENA_ECOSYSTEM_SPOKE'],
          hubAssetListings: [
            {
              hubLib: 'AaveV4AvalancheHubs.CORE_HUB',
              hub: 'CORE_HUB',
              underlying: 'USDE',
              feeReceiver: 'AaveV4Avalanche.TREASURY_SPOKE',
              liquidityFee: '0',
              irStrategy: 'AaveV4AvalancheIRStrategies.CORE_USDt_IR_STRATEGY',
              irPreset: 'nonBorrowable',
            },
          ],
          listings: [
            {
              spokeLib: 'ETHENA_ECOSYSTEM_SPOKE',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              hub: 'AaveV4AvalancheHubs.CORE_HUB',
              underlying: 'USDE',
              priceSource: '0x5b7810a910B4a878AaA4800a824E5E5796838009',
              config: {
                collateralRisk: '0',
                paused: false,
                frozen: false,
                borrowable: false,
                receiveSharesEnabled: true,
              },
              dynamicConfig: {
                collateralFactor: '93',
                maxLiquidationBonus: '102',
                liquidationFee: '10',
              },
            },
            {
              spokeLib: 'ETHENA_ECOSYSTEM_SPOKE',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              hub: 'AaveV4AvalancheHubs.CORE_HUB',
              underlying: 'AaveV4AvalancheAssets.USDt_UNDERLYING',
              priceSource: '0x5b7810a910B4a878AaA4800a824E5E5796838009',
              config: {
                collateralRisk: '0',
                paused: false,
                frozen: false,
                borrowable: true,
                receiveSharesEnabled: true,
              },
              dynamicConfig: {
                collateralFactor: '0',
                maxLiquidationBonus: '100',
                liquidationFee: '0',
              },
            },
            {
              spokeLib: 'ETHENA_ECOSYSTEM_SPOKE',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              hub: 'AaveV4AvalancheHubs.CORE_HUB',
              underlying: 'AaveV4AvalancheAssets.USDC_UNDERLYING',
              priceSource: '0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483',
              config: {
                collateralRisk: '0',
                paused: false,
                frozen: false,
                borrowable: true,
                receiveSharesEnabled: true,
              },
              dynamicConfig: {
                collateralFactor: '0',
                maxLiquidationBonus: '100',
                liquidationFee: '0',
              },
            },
          ],
          updates: [],
          liquidationUpdates: [
            {
              spokeLib: 'ETHENA_ECOSYSTEM_SPOKE',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              targetHealthFactor: {kind: 'literal', value: '1.0277'},
              healthFactorForMaxBonus: {kind: 'literal', value: '0.99'},
              liquidationBonusFactor: {kind: 'literal', value: '100'},
            },
          ],
          hubSpokeAdditions: [
            {
              hubLib: 'AaveV4AvalancheHubs.CORE_HUB',
              hub: 'CORE_HUB',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              assets: [
                {
                  underlying: 'USDE',
                  addCap: '5000000',
                  drawCap: '0',
                  riskPremiumThreshold: '0',
                  active: true,
                  halted: false,
                },
                {
                  underlying: 'AaveV4AvalancheAssets.USDt_UNDERLYING',
                  addCap: '0',
                  drawCap: '2500000',
                  riskPremiumThreshold: '0',
                  active: true,
                  halted: false,
                },
                {
                  underlying: 'AaveV4AvalancheAssets.USDC_UNDERLYING',
                  addCap: '0',
                  drawCap: '2500000',
                  riskPremiumThreshold: '0',
                  active: true,
                  halted: false,
                },
              ],
            },
          ],
          pmUpdates: [
            {
              spokeLib: 'ETHENA_ECOSYSTEM_SPOKE',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              positionManager: 'AaveV4AvalanchePositionManagers.GIVER_POSITION_MANAGER',
              active: true,
            },
            {
              spokeLib: 'ETHENA_ECOSYSTEM_SPOKE',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              positionManager: 'AaveV4AvalanchePositionManagers.TAKER_POSITION_MANAGER',
              active: true,
            },
            {
              spokeLib: 'ETHENA_ECOSYSTEM_SPOKE',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              positionManager: 'AaveV4AvalanchePositionManagers.CONFIG_POSITION_MANAGER',
              active: true,
            },
            {
              spokeLib: 'ETHENA_ECOSYSTEM_SPOKE',
              spoke: 'ETHENA_ECOSYSTEM_SPOKE',
              positionManager: 'AaveV4AvalanchePositionManagers.SIGNATURE_GATEWAY',
              active: true,
            },
          ],
        },
      },
      cache: {blockNumber: 97445417},
      labels: {
        '0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34': {
          label: 'USDE',
          address: '0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34',
          kind: 'asset',
        },
        '0xaf22446124e566e54845f65b722e4dcbf12b650a': {
          label: 'ETHENA_ECOSYSTEM_SPOKE',
          address: '0xaf22446124e566e54845f65b722E4dCbf12b650A',
          kind: 'spoke',
        },
      },
    },
  },
};
