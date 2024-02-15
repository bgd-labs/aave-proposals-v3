import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2EthereumAMM'],
    title: '[ARFC] Deprecate Aave V2 AMM Market - Step 2',
    shortName: 'ARFCDeprecateAaveV2AMMMarketStep2',
    date: '20240205',
    author: 'Gauntlet',
    discussion: 'https://governance.aave.com/t/arfc-deprecate-aave-v2-amm-market-step-2/16408/1',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x0ade316f52d5f763160ea15538a71a4682ae1b708864e8d33497d8de40ad9973',
  },
  poolOptions: {
    AaveV2EthereumAMM: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '6',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '4',
              variableRateSlope1: '10',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '4',
              variableRateSlope1: '10',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '6',
              variableRateSlope1: '10',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '5',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
        OTHERS: {},
      },
      cache: {blockNumber: 19164401},
    },
  },
};
