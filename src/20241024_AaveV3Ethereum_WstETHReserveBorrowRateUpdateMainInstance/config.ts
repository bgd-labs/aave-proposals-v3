import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'wstETH Reserve Borrow Rate Update - Main Instance',
    shortName: 'WstETHReserveBorrowRateUpdateMainInstance',
    date: '20241024',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-weth-wsteth-borrow-rate-updates/19550',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '0.00',
              variableRateSlope1: '2.00',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 21036418},
    },
  },
};
