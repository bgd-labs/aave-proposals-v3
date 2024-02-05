import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Chaos Labs - Eyal Ovadya',
    pools: ['AaveV2Ethereum'],
    title: 'Chaos Labs V2 Ethereum LT Reductions',
    discussion: 'https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-01-30-2024/16468',
    shortName: 'ChaosLabsV2EthereumLTReductions',
    date: '20240201',
    snapshot: 'No snapshot for Direct-to-AIP',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19133686}}},
};
