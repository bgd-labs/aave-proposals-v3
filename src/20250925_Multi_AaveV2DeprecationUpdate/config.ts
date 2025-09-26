import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV2Polygon', 'AaveV2Avalanche'],
    title: 'Aave v2 Deprecation - Update',
    shortName: 'AaveV2DeprecationUpdate',
    date: '20250925',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-aave-v2-deprecation-update/23008/2',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x0c5427caf17d21b321a3b62362d085e580446b136b0eccf7f4dc377856025486',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '40',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '12.5',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '5',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '50',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '12.5',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '60',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '12.5',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 23435818},
    },
    AaveV2Polygon: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '65',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDT0',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WPOL',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 76860330},
    },
    AaveV2Avalanche: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'WETHe',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'DAIe',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDTe',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDCe',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '0',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WBTCe',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WAVAX',
            params: {
              optimalUtilizationRate: '25',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '15',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 69241072},
    },
  },
};
