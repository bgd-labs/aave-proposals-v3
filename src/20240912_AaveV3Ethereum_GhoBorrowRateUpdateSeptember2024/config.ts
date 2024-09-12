import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Gho Borrow Rate Update September 2024',
    shortName: 'GhoBorrowRateUpdateSeptember2024',
    date: '20240912',
    author: 'karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-gho-stewards-gho-parameter-adjustments/17289/32',
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
              baseVariableBorrowRate: '4.25',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 20736417},
    },
  },
};
