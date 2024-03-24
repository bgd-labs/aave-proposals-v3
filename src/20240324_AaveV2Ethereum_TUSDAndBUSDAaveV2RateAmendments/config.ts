import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'TUSD and BUSD Aave V2 Rate Amendments',
    shortName: 'TUSDAndBUSDAaveV2RateAmendments',
    date: '20240324',
    author: 'Chaos Labs',
    discussion: 'https://governance.aave.com/t/arfc-tusd-and-busd-aave-v2-rate-amendments/16887',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xcff2253ff9d74193354370fe95ebe0fe2f0b6f34873281d1b9b55b9f51dea011',
  },
  poolOptions: {
    AaveV2Ethereum: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'BUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '10',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'TUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '10',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 19502937},
    },
  },
};
