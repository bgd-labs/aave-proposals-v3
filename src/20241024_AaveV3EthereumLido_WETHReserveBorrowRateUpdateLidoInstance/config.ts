import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'wETH Reserve Borrow Rate Update - Lido Instance',
    shortName: 'WETHReserveBorrowRateUpdateLidoInstance',
    date: '20241024',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-weth-wsteth-borrow-rate-updates/19550',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.75',
              variableRateSlope2: '',
            },
          },
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '0.5',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21036516},
    },
  },
};
