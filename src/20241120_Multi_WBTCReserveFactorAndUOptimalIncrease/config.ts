import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: ' WBTC Reserve Factor and UOptimal Increase ',
    shortName: 'WBTCReserveFactorAndUOptimalIncrease',
    date: '20241120',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-wbtc-reserve-factor-and-uoptimal-increase-10-25-24/19596',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '80',
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
            reserveFactor: '50',
            asset: 'WBTC',
          },
        ],
      },
      cache: {blockNumber: 21230828},
    },
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '80',
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
            reserveFactor: '50',
            asset: 'WBTC',
          },
        ],
      },
      cache: {blockNumber: 64525193},
    },
    AaveV3Optimism: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '80',
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
            reserveFactor: '50',
            asset: 'WBTC',
          },
        ],
      },
      cache: {blockNumber: 128264864},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '80',
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
            reserveFactor: '50',
            asset: 'WBTC',
          },
        ],
      },
      cache: {blockNumber: 276532623},
    },
  },
};
