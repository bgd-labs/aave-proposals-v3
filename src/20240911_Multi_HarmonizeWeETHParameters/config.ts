import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Arbitrum', 'AaveV3Base', 'AaveV3Scroll'],
    title: 'Harmonize WeETH Parameters',
    shortName: 'HarmonizeWeETHParameters',
    date: '20240911',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-harmonize-weeth-parameters/19012',
    snapshot: 'Direct-To-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'weETH',
            params: {
              optimalUtilizationRate: '30',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 20730095},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'weETH',
            params: {
              optimalUtilizationRate: '30',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 252529853},
    },
    AaveV3Base: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'weETH',
            params: {
              optimalUtilizationRate: '30',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 19650632},
    },
    AaveV3Scroll: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'weETH',
            params: {
              optimalUtilizationRate: '30',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            asset: 'weETH',
          },
        ],
      },
      cache: {blockNumber: 9206353},
    },
  },
};
