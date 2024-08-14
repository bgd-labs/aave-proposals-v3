import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV2Ethereum',
      'AaveV2Polygon',
      'AaveV2Avalanche',
      'AaveV3Polygon',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Base',
    ],
    title: 'Reserve Factor Updates August',
    shortName: 'ReserveFactorUpdatesAugust',
    date: '20240726',
    author: 'karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 20527680}},
    AaveV2Polygon: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '12.75',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '12.75',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '12.75',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WBTC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '7.75',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '7.75',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'WMATIC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.75',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 60583790},
    },
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 49251980}},
    AaveV3Polygon: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '35',
            asset: 'USDC',
          },
        ],
      },
      cache: {blockNumber: 60583790},
    },
    AaveV3Optimism: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '35',
            asset: 'USDC',
          },
        ],
      },
      cache: {blockNumber: 124024860},
    },
    AaveV3Arbitrum: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '35',
            asset: 'USDC',
          },
        ],
      },
      cache: {blockNumber: 242816390},
    },
    AaveV3Base: {
      configs: {
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            stableRateModeEnabled: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '35',
            asset: 'USDbC',
          },
        ],
      },
      cache: {blockNumber: 18429550},
    },
  },
};
