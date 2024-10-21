import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'wstETH Slope1 & Uoptimal Update',
    shortName: 'WstETHSlope1UoptimalUpdate',
    date: '20241001',
    author: 'karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-lido-instance-wsteth-slope1-uoptimal-update/19069',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x80a2e4e23afa0536c198acc18bb90f2cbb9a28d06e5ab9f2999eb49503232c5f',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '80',
              baseVariableBorrowRate: '',
              variableRateSlope1: '2.25',
              variableRateSlope2: '',
            },
          },
        ],
      },
      cache: {blockNumber: 20874549},
    },
  },
};
