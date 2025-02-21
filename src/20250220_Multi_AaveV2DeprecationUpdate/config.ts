import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV2Ethereum', 'AaveV2Polygon', 'AaveV2Avalanche'],
    title: 'Aave V2 Deprecation Update',
    shortName: 'AaveV2DeprecationUpdate',
    date: '20250220',
    discussion:
      'https://governance.aave.com/t/arfc-aave-v2-deprecation-update-disable-new-borrows-ir-curve-and-reserve-factor-adjustments/20918',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0xe1f53fe1748e6b31068eca832a07e5be5765ca3bf4ec1c900a13d78f29ed1d51',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV2Ethereum: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'USDT',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '60',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'YFI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '0',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'ZRX',
            params: {
              optimalUtilizationRate: '1',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'UNI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '0',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'AAVE',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'BAT',
            params: {
              optimalUtilizationRate: '1',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'BUSD',
            params: {
              optimalUtilizationRate: '1',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'DAI',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '60',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'KNC',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'LINK',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'MANA',
            params: {
              optimalUtilizationRate: '1',
              baseVariableBorrowRate: '1',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'SNX',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'sUSD',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'TUSD',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '60',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'CRV',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '0',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'GUSD',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'BAL',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'renFIL',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'RAI',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'AMPL',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'USDP',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'DPI',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'FRAX',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'FEI',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'UST',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '',
              variableRateSlope1: '0',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'LUSD',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21886703},
    },
    AaveV2Polygon: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'GHST',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'BAL',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'CRV',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
          {
            asset: 'LINK',
            params: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '300',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 68149583},
    },
    AaveV2Avalanche: {
      configs: {
        RATE_UPDATE_V2: [
          {
            asset: 'WBTCe',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '20',
              variableRateSlope1: '0',
              variableRateSlope2: '',
              stableRateSlope1: '',
              stableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 57597554},
    },
  },
};
