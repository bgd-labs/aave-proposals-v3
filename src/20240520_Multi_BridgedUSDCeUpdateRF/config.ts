import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'config.ts',
    force: true,
    pools: ['AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'StablecoinIRUpdates',
    shortName: 'StablecoinIRUpdates',
    date: '20240424',
    author: 'Chaos Labs, ACI',
    discussion:
      'https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-04-22-2024/17450',
    snapshot: 'Direct-to-AIP',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDCn',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '11',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 56205923},
    },
    AaveV3Optimism: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDCn',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '11',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 119190057},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDCn',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '11',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 204403350},
    },
  },
};
