import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'Chaos Labs Ethereum V2 LT Reductions',
    shortName: 'ChaosLabsEthereumV2LTReductions',
    date: '20240509',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-ethereum-v2-lt-reductions-05-06-2024/17598',
    snapshot: '',
  },
  poolOptions: {
    AaveV2Ethereum: {
      configs: {OTHERS: {}},
      cache: {blockNumber: 19832836},
    },
  },
};
