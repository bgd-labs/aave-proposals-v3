import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'wstETH Borrow Cap Reduction',
    shortName: 'WstETHBorrowCapReduction',
    date: '20240913',
    author: 'Tokenlogic',
    discussion: 'https://governance.aave.com/t/arfc-lido-instance-reduce-wsteth-borrow-cap/19016',
    snapshot: 'Direct-To-Aip',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {CAPS_UPDATE: [{asset: 'wstETH', supplyCap: '', borrowCap: '100'}]},
      cache: {blockNumber: 20740411},
    },
  },
};
