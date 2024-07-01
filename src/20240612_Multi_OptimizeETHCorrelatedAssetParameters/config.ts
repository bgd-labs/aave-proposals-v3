import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: './config.ts',
    author: 'Aave Chan Initiative',
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
      'AaveV3BNB',
    ],
    title: 'Optimize ETH-correlated asset parameters',
    shortName: 'OptimizeETHCorrelatedAssetParameters',
    date: '20240612',
    discussion: 'https://governance.aave.com/t/arfc-optimize-eth-correlated-asset-parameters/17886',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x3d79b416cfa6c70a85d03d07148d3a2025b88f294694d76fb101167af332c2fc',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 20078561},
    },
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 58085999},
    },
    AaveV3Avalanche: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETHe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 46641063},
    },
    AaveV3Optimism: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 121315273},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 221211071},
    },
    AaveV3Metis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 17329826},
    },
    AaveV3Base: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 15720041},
    },
    AaveV3Gnosis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 34432968},
    },
    AaveV3Scroll: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 6508767},
    },
    AaveV3BNB: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'ETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.7',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
              baseStableRateOffset: '',
              stableRateExcessOffset: '',
              optimalStableToTotalDebtRatio: '',
            },
          },
        ],
      },
      cache: {blockNumber: 39559153},
    },
  },
};
