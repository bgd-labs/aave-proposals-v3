import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3Polygon', 'AaveV3Optimism', 'AaveV3Arbitrum'],
    title: 'Deprecation of Long-tail Assets',
    shortName: 'DeprecationOfLongTailAssets',
    date: '20250715',
    discussion: 'https://governance.aave.com/t/direct-to-aip-deprecation-of-long-tail-assets/22592',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'SNX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '6',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
        COLLATERALS_UPDATE: [
          {
            asset: 'SNX',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '1',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '95',
            asset: 'SNX',
          },
        ],
      },
      cache: {blockNumber: 22925754},
    },
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'EURS',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '2',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
        COLLATERALS_UPDATE: [
          {
            asset: 'EURS',
            ltv: '0',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '1',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '50',
            asset: 'EURS',
          },
        ],
      },
      cache: {blockNumber: 73995872},
    },
    AaveV3Optimism: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '2',
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
            asset: 'LUSD',
          },
        ],
      },
      cache: {blockNumber: 138499234},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '2',
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
            asset: 'LUSD',
          },
        ],
      },
      cache: {blockNumber: 358013997},
    },
  },
};
