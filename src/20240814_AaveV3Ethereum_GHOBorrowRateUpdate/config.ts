import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'GHO Borrow Rate Update',
    shortName: 'GHOBorrowRateUpdate',
    date: '20240814',
    author: 'ACI',
    discussion: 'https://governance.aave.com/t/gho-stewards-adjustments-gho-borrow-rate/18649',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'GHO',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '6',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 20526943},
    },
  },
};
