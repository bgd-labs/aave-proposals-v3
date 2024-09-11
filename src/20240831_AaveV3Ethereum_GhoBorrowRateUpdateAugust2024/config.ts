import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Gho Borrow Rate Update August 2024',
    shortName: 'GhoBorrowRateUpdateAugust2024',
    date: '20240831',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-gho-stewards-gho-parameter-adjustments/17289/29',
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
              baseVariableBorrowRate: '5',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 20649570},
    },
  },
};
