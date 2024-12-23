import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'tmp.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'USDS Interest Rate Curve Update',
    shortName: 'USDSInterestRateCurveUpdate',
    date: '20241223',
    discussion: 'https://governance.aave.com/t/arfc-usds-interest-rate-curve-update/20243',
    snapshot: 'Direct-to-AIP',
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
              baseVariableBorrowRate: '11.75',
              variableRateSlope1: '',
              variableRateSlope2: '35',
            },
          },
        ],
      },
      cache: {blockNumber: 21464361},
    },
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDS',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '11.75',
              variableRateSlope2: '35',
            },
          },
        ],
      },
      cache: {blockNumber: 21464361},
    },
  },
};
