import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV2Polygon', 'AaveV3Polygon'],
    title: 'Full Deprecation of DPI Across Aave Deployments',
    shortName: 'FullDeprecationOfDPIAcrossAaveDeployments',
    date: '20251008',
    author: 'BGD Labs (@bgdlabs)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-full-deprecation-of-dpi-across-aave-deployments/23212',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV2Ethereum: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'DPI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '40',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 23533325},
    },
    AaveV2Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 77413300}},
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'DPI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '',
              variableRateSlope2: '40',
            },
          },
        ],
      },
      cache: {blockNumber: 77413306},
    },
  },
};
