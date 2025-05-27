import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    title: 'Asset Parameters Optimization',
    discussion: 'https://governance.aave.com/t/arfc-asset-parameters-optimization',
    snapshot: 'Direct-to-AIP',
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Celo'],
    shortName: 'AssetParametersOptimization',
    date: '20250527',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'CRV',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'SNX',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'BAL',
            params: {
              optimalUtilizationRate: '45',
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
            reserveFactor: '20',
            asset: 'crvUSD',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '20',
            asset: 'RLUSD',
          },
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '20',
            asset: 'USDtb',
          },
        ],
      },
      cache: {blockNumber: 22576417},
    },
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'CRV',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'BAL',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 72042544},
    },
    AaveV3Celo: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '20',
            asset: 'USDT',
          },
        ],
      },
      cache: {blockNumber: 36475951},
    },
  },
};
