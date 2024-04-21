import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'Ethereum V2 LT Reductions ',
    shortName: 'EthereumV2LTReductions',
    date: '20240416',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-ethereum-v2-lt-reductions-04-15-2024/17369',
    snapshot: '',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19666652}}},
};
