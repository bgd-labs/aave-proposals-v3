import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250203_Multi_UpdateUSDSGHOBorrowRate/config.ts',
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'Update USDS & GHO Borrow Rate',
    shortName: 'UpdateUSDSGHOBorrowRate',
    date: '20250203',
    discussion: 'https://governance.aave.com/t/arfc-update-usds-gho-borrow-rate/20892',
    snapshot: 'direct-to-aip',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDS',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '8.75',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21767442},
    },
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDS',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '8.75',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'GHO',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '6.5',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21767447},
    },
  },
};
