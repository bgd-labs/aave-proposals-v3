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
      'AaveV3Polygon',
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
    title: 'Decrease Slope1 Parameter for Stablecoins on Aave V3',
    shortName: 'DecreaseSlope1ParameterforStablecoinsonAaveV3',
    date: '20250203',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-stewards-decrease-slope1-parameter-for-stablecoins-on-aave-v3-01-29-25/20841',
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
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'crvUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21768687},
    },
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21768687},
    },
    AaveV3EthereumEtherFi: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21768687},
    },
    AaveV3Polygon: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '10.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'EURS',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDCn',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 67502760},
    },
    AaveV3Avalanche: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'DAIe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDt',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'AUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 56787515},
    },
    AaveV3Optimism: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '10.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'sUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDCn',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 131509787},
    },
    AaveV3Arbitrum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '10.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDCn',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 302332186},
    },
    AaveV3Metis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'mDAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'mUSDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'mUSDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 19644005},
    },
    AaveV3Base: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDbC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '10.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 25914503},
    },
    AaveV3Gnosis: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WXDAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'EURe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDCe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '10.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 38379372},
    },
    AaveV3Scroll: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 13177278},
    },
    AaveV3BNB: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'FDUSD',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 46345668},
    },
    AaveV3ZkSync: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '9.5',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 55203165},
    },
  },
};
