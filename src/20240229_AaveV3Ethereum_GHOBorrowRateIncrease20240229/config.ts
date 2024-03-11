import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'GHO Borrow Rate Increase 2024-02-29',
    shortName: 'GHOBorrowRateIncrease20240229',
    date: '20240229',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/arfc-increase-gho-borrow-rate-29-02-2024/16787',
    snapshot: '',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'GHO',
            params: {
              optimalUtilizationRate: '0',
              baseVariableBorrowRate: '7.22',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
              stableRateSlope1: '0',
              stableRateSlope2: '0',
              baseStableRateOffset: '0',
              stableRateExcessOffset: '0',
              optimalStableToTotalDebtRatio: '0',
            },
          },
        ],
      },
      cache: {blockNumber: 19334429},
    },
  },
};
