import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'Deprecation of Small-cap Stablecoins on V2 Ethereum',
    shortName: 'DeprecationOfSmallCapStablecoinsOnV2Ethereum',
    date: '20240502',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-deprecation-of-small-cap-stablecoins-on-v2-ethereum/17484/1',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xf6aaa50a6a76f44df9cfbbb760ca80878854dd16d88b16a3fc0f5fa6920741f0',
  },
  poolOptions: {
    AaveV2Ethereum: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'sUSD',
            params: {
              optimalUtilizationRate: '20',
              baseVariableBorrowRate: '3',
              variableRateSlope1: '15',
              variableRateSlope2: '200',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'GUSD',
            params: {
              optimalUtilizationRate: '20',
              baseVariableBorrowRate: '3',
              variableRateSlope1: '15',
              variableRateSlope2: '200',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDP',
            params: {
              optimalUtilizationRate: '20',
              baseVariableBorrowRate: '3',
              variableRateSlope1: '15',
              variableRateSlope2: '200',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '20',
              baseVariableBorrowRate: '3',
              variableRateSlope1: '15',
              variableRateSlope2: '200',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '20',
              baseVariableBorrowRate: '3',
              variableRateSlope1: '15',
              variableRateSlope2: '200',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 19783031},
    },
  },
};
