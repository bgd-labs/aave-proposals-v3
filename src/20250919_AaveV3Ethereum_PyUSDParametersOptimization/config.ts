import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'pyUSD Parameters Optimization',
    shortName: 'PyUSDParametersOptimization',
    date: '20250919',
    author: '@TokenLogic',
    discussion: 'https://governance.aave.com/t/direct-to-aip-pyusd-parameters-optimization/23082/2',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'PYUSD',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '10',
            asset: 'PYUSD',
          },
        ],
      },
      cache: {blockNumber: 23397595},
    },
  },
};
