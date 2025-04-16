import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: '',
    force: true,
    update: true,
    author: 'Aave Chan Initiative',
    pools: [
      'AaveV3Ethereum',
      'AaveV3EthereumLido',
      'AaveV3EthereumEtherFi',
      'AaveV3Avalanche',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Metis',
      'AaveV3Base',
      'AaveV3Gnosis',
      'AaveV3Scroll',
      'AaveV3BNB',
      'AaveV3ZkSync',
    ],
    title: 'Stablecoins Interest Rate Curve Update',
    shortName: 'StablecoinsInterestRateCurveUpdate',
    date: '20250312',
    discussion:
      'https://governance.aave.com/t/arfc-stablecoin-interest-rate-curve-update-03-04-2025/21269',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'crvUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 22032215},
    },
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 22032215},
    },
    AaveV3EthereumEtherFi: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 22032215},
    },
    AaveV3Avalanche: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'DAIe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDt',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'AUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 58622425},
    },
    AaveV3Optimism: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'sUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDCn',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 133100485},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDCn',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 68965786},
    },
    AaveV3Metis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'mDAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'mUSDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'mUSDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 19895916},
    },
    AaveV3Base: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 27505200},
    },
    AaveV3Gnosis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WXDAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'EURe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDCe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 38999696},
    },
    AaveV3Scroll: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 13991707},
    },
    AaveV3BNB: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FDUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 47406038},
    },
    AaveV3ZkSync: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '6.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 57552347},
    },
  },
};
