import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Trydo Stablecoin IR',
    shortName: 'TrydoStablecoinIR',
    date: '20260107',
    author: 'Chaos Labs (implemented by Aavechan Initiative @aci via Skyward)',
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
      cache: {blockNumber: 34306982},
    },
  },
};
