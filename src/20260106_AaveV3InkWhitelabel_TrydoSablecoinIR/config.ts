import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Trydo Sablecoin IR',
    shortName: 'TrydoSablecoinIR',
    date: '20260106',
    author: 'ACI',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDG',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 34210021},
    },
  },
};
