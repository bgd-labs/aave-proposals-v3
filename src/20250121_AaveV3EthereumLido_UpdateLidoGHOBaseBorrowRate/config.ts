import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Update Lido GHO base borrow rate',
    shortName: 'UpdateLidoGHOBaseBorrowRate',
    date: '20250121',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-risk-stewards-reduce-gho-borrow-rate-prime-instance/20501',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'GHO',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '8.5',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21673369},
    },
  },
};
