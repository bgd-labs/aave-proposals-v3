import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Prime Instance - wstETH Borrow Rate + rsETH Supply Cap Update',
    shortName: 'PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate',
    date: '20250122',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-prime-instance-wsteth-borrow-rate-rseth-supply-cap-update/20644',
    snapshot:
      'https://snapshot.org/#/s:aave.eth/proposal/0xfc21203137ea8753ab8903fe4edd568bcaa7ea084586a7acb2c3b361d3dae9c8',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '0.75',
              variableRateSlope2: '',
            },
          },
        ],
        CAPS_UPDATE: [{asset: 'wstETH', supplyCap: '65000', borrowCap: ''}],
      },
      cache: {blockNumber: 21681966},
    },
  },
};
