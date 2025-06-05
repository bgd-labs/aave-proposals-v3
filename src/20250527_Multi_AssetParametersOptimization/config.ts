import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250527_Multi_AssetParametersOptimization/config.ts',
    force: true,
    update: true,
    author: 'Aave-Chan Initiative',
    title: 'Asset Parameters Optimization',
    discussion: 'https://governance.aave.com/t/direct-to-aip-asset-parameters-optimization/22178',
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
              variableRateSlope1: '10',
              variableRateSlope2: '150',
            },
          },
          {
            asset: 'SNX',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '150',
            },
          },
          {
            asset: 'BAL',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '15',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'RLUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '4',
              variableRateSlope1: '2.5',
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
      cache: {blockNumber: 22626835},
    },
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'CRV',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '10',
              variableRateSlope2: '150',
            },
          },
          {
            asset: 'BAL',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '15',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 72328112},
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
      cache: {blockNumber: 37085611},
    },
  },
};
