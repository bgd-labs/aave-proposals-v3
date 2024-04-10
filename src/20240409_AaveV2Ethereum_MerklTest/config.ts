import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum'],
    title: 'Merkl test',
    shortName: 'MerklTest',
    date: '20240409',
    author: 'BGD Labs',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19619568}}},
};
