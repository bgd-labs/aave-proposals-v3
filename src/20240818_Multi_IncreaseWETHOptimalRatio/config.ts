import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
    ],
    title: 'Increase WETH Optimal Ratio',
    shortName: 'IncreaseWETHOptimalRatio',
    date: '20240818',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-increase-weth-optimal-ratio-to-90-on-all-aave-markets/18556',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x2930599cae3cec0a16bd0aef13524347e0c5e85cff7dd66ae9b2bed90fc5d1fe',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 60736106},
    },
    AaveV3Avalanche: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETHe',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 49404440},
    },
    AaveV3Metis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 18143308},
    },
    AaveV3Base: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 18593229},
    },
    AaveV3Gnosis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 35542977},
    },
    AaveV3Scroll: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 8482390},
    },
  },
};
