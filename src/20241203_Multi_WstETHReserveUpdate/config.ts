import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'wstETH Reserve Update',
    shortName: 'WstETHReserveUpdate',
    date: '20241203',
    author: 'ACI',
    discussion:
      'https://governance.aave.com/t/arfc-prime-core-instance-wsteth-reserve-update/19973',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '1.75',
              variableRateSlope2: '85',
            },
          },
        ],
      },
      cache: {blockNumber: 21322520},
    },
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '1.75',
              variableRateSlope2: '85',
            },
          },
        ],
      },
      cache: {blockNumber: 21322524},
    },
  },
};
